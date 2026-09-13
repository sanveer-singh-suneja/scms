from datetime import datetime, timezone
from sqlmodel import Session, select

from app.models import Booking, Defaulter, Equipment, Slot, Transaction, UsageStatistics
from app.models.enums import (
    BookingStatus,
    DefaulterStatus,
    EquipmentCondition,
    EquipmentStatus,
    TransactionStatus,
)
from app.services.notification import create_notification
from app.models.enums import NotificationType


def issue_equipment(
    session: Session,
    booking_id: int,
    equipment_id: int,
    issued_by_id: int,
) -> Transaction:
    from fastapi import HTTPException, status

    booking = session.get(Booking, booking_id)
    if booking is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "BOOKING_NOT_FOUND", "message": "Booking not found."},
        )
    if booking.status != BookingStatus.CONFIRMED:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail={"code": "BOOKING_NOT_CONFIRMED", "message": "Only CONFIRMED bookings can be issued."},
        )

    equipment = session.get(Equipment, equipment_id)
    if equipment is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "EQUIPMENT_NOT_FOUND", "message": "Equipment not found."},
        )
    if equipment.id != booking.equipment_id:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail={"code": "EQUIPMENT_MISMATCH", "message": "Scanned equipment does not match the booking."},
        )
    if equipment.status != EquipmentStatus.AVAILABLE:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail={"code": "EQUIPMENT_ALREADY_ISSUED", "message": "Equipment is not available."},
        )

    slot = session.get(Slot, booking.slot_id)
    due_at = datetime.combine(slot.date, slot.end_time, tzinfo=timezone.utc) if slot else datetime.now(timezone.utc)

    txn = Transaction(
        booking_id=booking_id,
        student_id=booking.student_id,
        equipment_id=equipment.id,
        due_at=due_at,
        issued_by=issued_by_id,
        status=TransactionStatus.ISSUED,
    )
    session.add(txn)

    equipment.status = EquipmentStatus.ISSUED
    session.add(equipment)

    session.commit()
    session.refresh(txn)
    return txn


def return_equipment(
    session: Session,
    transaction_id: int,
    condition: EquipmentCondition,
    damage_report: str | None,
    returned_by_id: int,
) -> Transaction:
    from fastapi import HTTPException, status

    txn = session.get(Transaction, transaction_id)
    if txn is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "TRANSACTION_NOT_FOUND", "message": "Transaction not found."},
        )
    if txn.status not in (TransactionStatus.ISSUED, TransactionStatus.OVERDUE):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail={"code": "INVALID_TRANSACTION_STATE", "message": "Transaction is not in a returnable state."},
        )
    if condition == EquipmentCondition.DAMAGED and not damage_report:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail={"code": "DAMAGE_REPORT_REQUIRED", "message": "A damage report is required for DAMAGED condition."},
        )

    now = datetime.now(timezone.utc)
    txn.returned_at = now
    txn.condition_on_return = condition
    txn.damage_report = damage_report
    txn.returned_to = returned_by_id
    txn.status = (
        TransactionStatus.RETURNED_DAMAGED
        if condition == EquipmentCondition.DAMAGED
        else TransactionStatus.RETURNED
    )
    session.add(txn)

    # Update equipment
    equipment = session.get(Equipment, txn.equipment_id)
    if equipment:
        equipment.status = (
            EquipmentStatus.MAINTENANCE
            if condition == EquipmentCondition.DAMAGED
            else EquipmentStatus.AVAILABLE
        )
        equipment.condition = condition
        session.add(equipment)

    # Update booking to COMPLETED
    if txn.booking_id:
        booking = session.get(Booking, txn.booking_id)
        if booking:
            booking.status = BookingStatus.COMPLETED
            session.add(booking)

    # Update usage statistics
    _update_usage_stats(session, txn.student_id, now)

    # Resolve active defaulter for this transaction
    defaulter = session.exec(
        select(Defaulter).where(
            Defaulter.transaction_id == transaction_id,
            Defaulter.status.in_([DefaulterStatus.ACTIVE, DefaulterStatus.NOTIFIED]),
        )
    ).first()
    if defaulter:
        defaulter.status = DefaulterStatus.RESOLVED
        defaulter.resolved_at = now
        session.add(defaulter)

    # Notifications
    create_notification(session, txn.student_id, NotificationType.RETURN_CONFIRMED)
    if condition == EquipmentCondition.DAMAGED:
        create_notification(session, txn.student_id, NotificationType.DAMAGE_LOGGED)

    session.commit()
    session.refresh(txn)
    return txn


def _update_usage_stats(session: Session, student_id: int, now: datetime) -> None:
    from datetime import timedelta
    cutoff = now - timedelta(days=7)
    recent_count = len(session.exec(
        select(Transaction).where(
            Transaction.student_id == student_id,
            Transaction.returned_at >= cutoff,
            Transaction.status.in_([TransactionStatus.RETURNED, TransactionStatus.RETURNED_DAMAGED]),
        )
    ).all())

    total_count = len(session.exec(
        select(Transaction).where(
            Transaction.student_id == student_id,
            Transaction.status.in_([TransactionStatus.RETURNED, TransactionStatus.RETURNED_DAMAGED]),
        )
    ).all())

    stats = session.exec(
        select(UsageStatistics).where(UsageStatistics.student_id == student_id)
    ).first()

    if stats is None:
        stats = UsageStatistics(student_id=student_id)
    stats.sessions_last_7_days = recent_count
    stats.total_sessions = total_count
    stats.last_session_at = now
    stats.updated_at = now
    session.add(stats)
