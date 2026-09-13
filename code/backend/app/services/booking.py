from datetime import date, datetime, timezone
from sqlalchemy import func
from sqlmodel import Session, select

from app.models import Booking, Defaulter, FairnessConfig, Slot, Student
from app.models.enums import (
    BookingStatus,
    DefaulterStatus,
    SlotStatus,
    StudentStatus,
)
from app.services.fairness_engine import promote_waitlist
from app.services.notification import create_notification
from app.models.enums import NotificationType


def _get_config(session: Session) -> FairnessConfig:
    cfg = session.get(FairnessConfig, 1)
    return cfg or FairnessConfig()


def check_active_defaulter(session: Session, student_id: int) -> bool:
    """Returns True if student has an ACTIVE defaulter record."""
    result = session.exec(
        select(Defaulter).where(
            Defaulter.student_id == student_id,
            Defaulter.status == DefaulterStatus.ACTIVE,
        )
    ).first()
    return result is not None


def count_sessions_today(session: Session, student_id: int) -> int:
    """Count CONFIRMED/COMPLETED bookings for today (as a proxy for usage cap)."""
    today = date.today()
    from app.models import Transaction
    from app.models.enums import TransactionStatus

    # Count transactions issued today (regardless of return status)
    completed_today = session.exec(
        select(func.count()).select_from(Transaction).where(
            Transaction.student_id == student_id,
            func.date(Transaction.issued_at) == today,
            Transaction.status.in_([
                TransactionStatus.ISSUED,
                TransactionStatus.RETURNED,
                TransactionStatus.RETURNED_DAMAGED,
                TransactionStatus.OVERDUE,
            ]),
        )
    ).one()
    return completed_today


def create_booking(session: Session, student: Student, slot_id: int) -> Booking:
    from fastapi import HTTPException, status

    if student.status == StudentStatus.SUSPENDED:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail={"code": "ACCOUNT_SUSPENDED", "message": "Account is suspended."},
        )

    if check_active_defaulter(session, student.id):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail={
                "code": "ACTIVE_DEFAULTER",
                "message": "You have an overdue equipment item. Please return it before making new bookings.",
            },
        )

    slot = session.get(Slot, slot_id)
    if slot is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "SLOT_NOT_FOUND", "message": "Slot not found."},
        )

    now = datetime.now(timezone.utc)
    if slot.status not in (SlotStatus.OPEN,):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail={"code": "SLOT_NOT_AVAILABLE", "message": "Slot is not open for booking."},
        )
    if now >= slot.booking_cutoff_at.replace(tzinfo=timezone.utc) if slot.booking_cutoff_at.tzinfo is None else now >= slot.booking_cutoff_at:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail={"code": "SLOT_BOOKING_CLOSED", "message": "Booking window for this slot has closed."},
        )
    if slot.capacity == 0:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail={"code": "SLOT_NOT_AVAILABLE", "message": "Slot has zero capacity."},
        )

    # Check duplicate
    existing = session.exec(
        select(Booking).where(
            Booking.student_id == student.id,
            Booking.slot_id == slot_id,
        )
    ).first()
    if existing:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail={"code": "DUPLICATE_BOOKING", "message": "You already have a booking for this slot."},
        )

    # Check daily usage cap
    cfg = _get_config(session)
    sessions_today = count_sessions_today(session, student.id)
    if sessions_today >= cfg.daily_usage_cap:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail={
                "code": "USAGE_CAP_REACHED",
                "message": f"Daily usage cap of {cfg.daily_usage_cap} sessions reached.",
            },
        )

    booking = Booking(
        student_id=student.id,
        equipment_id=slot.equipment_id,
        slot_id=slot_id,
        status=BookingStatus.REQUESTED,
    )
    session.add(booking)
    session.commit()
    session.refresh(booking)

    create_notification(session, student.id, NotificationType.BOOKING_RECEIVED)
    session.commit()

    return booking


def cancel_booking(session: Session, booking_id: int, student_id: int) -> Booking:
    from fastapi import HTTPException, status

    booking = session.get(Booking, booking_id)
    if booking is None or booking.student_id != student_id:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "BOOKING_NOT_FOUND", "message": "Booking not found."},
        )

    cancellable = {BookingStatus.REQUESTED, BookingStatus.CONFIRMED, BookingStatus.WAITLISTED}
    if booking.status not in cancellable:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail={"code": "BOOKING_CANNOT_CANCEL", "message": "This booking cannot be cancelled."},
        )

    was_confirmed = booking.status == BookingStatus.CONFIRMED
    booking.status = BookingStatus.CANCELLED
    session.add(booking)

    if was_confirmed:
        # Free the slot capacity and promote next waitlisted
        slot = session.get(Slot, booking.slot_id)
        if slot:
            slot.available_count = min(slot.available_count + 1, slot.capacity)
            session.add(slot)
        promote_waitlist(session, booking.slot_id)

    session.commit()
    session.refresh(booking)
    return booking
