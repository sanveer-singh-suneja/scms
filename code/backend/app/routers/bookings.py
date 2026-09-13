from fastapi import APIRouter, HTTPException, Query, status
from sqlmodel import Session, select

from app.core.dependencies import CurrentStudent, SessionDep
from app.models import Booking, Equipment, Slot
from app.models.enums import BookingStatus
from app.schemas.booking import (
    BookingCreate, BookingEquipmentInfo, BookingReadFull,
    BookingSlotInfo, QueuePositionRead,
)
from app.schemas.common import StandardResponse
from app.services.booking import cancel_booking, create_booking

router = APIRouter(prefix="/bookings", tags=["bookings"])


def _enrich(booking: Booking, session: Session) -> BookingReadFull:
    slot = session.get(Slot, booking.slot_id)
    equipment = session.get(Equipment, booking.equipment_id)
    return BookingReadFull(
        id=booking.id,
        slot=BookingSlotInfo(
            id=slot.id,
            date=slot.date,
            start_time=slot.start_time,
            end_time=slot.end_time,
            booking_cutoff_at=slot.booking_cutoff_at,
        ) if slot else None,
        equipment=BookingEquipmentInfo(
            id=equipment.id,
            name=equipment.name,
        ) if equipment else None,
        status=booking.status,
        priority_score=booking.priority_score,
        queue_position=booking.queue_position,
        created_at=booking.created_at,
        allocated_at=booking.allocated_at,
        booking_cutoff_at=slot.booking_cutoff_at if slot else None,
    )


@router.post("", status_code=201)
def submit_booking(body: BookingCreate, student: CurrentStudent, session: SessionDep):
    booking = create_booking(session, student, body.slot_id)
    return StandardResponse.ok(_enrich(booking, session))


@router.get("")
def list_bookings(
    student: CurrentStudent,
    session: SessionDep,
    page: int = Query(1, ge=1),
    limit: int = Query(20, ge=1, le=100),
    booking_status: BookingStatus | None = Query(None, alias="status"),
):
    query = select(Booking).where(Booking.student_id == student.id)
    if booking_status:
        query = query.where(Booking.status == booking_status)
    query = query.order_by(Booking.created_at.desc())
    total = len(session.exec(query).all())
    items = session.exec(query.offset((page - 1) * limit).limit(limit)).all()
    return StandardResponse.list_ok(
        [_enrich(b, session) for b in items], page, limit, total
    )


@router.get("/{booking_id}")
def get_booking(booking_id: int, student: CurrentStudent, session: SessionDep):
    booking = session.get(Booking, booking_id)
    if not booking or booking.student_id != student.id:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "BOOKING_NOT_FOUND", "message": "Booking not found."},
        )
    return StandardResponse.ok(_enrich(booking, session))


@router.delete("/{booking_id}", status_code=200)
def cancel_my_booking(booking_id: int, student: CurrentStudent, session: SessionDep):
    booking = cancel_booking(session, booking_id, student.id)
    return StandardResponse.ok(_enrich(booking, session))


@router.get("/{booking_id}/queue-position")
def get_queue_position(booking_id: int, student: CurrentStudent, session: SessionDep):
    booking = session.get(Booking, booking_id)
    if not booking or booking.student_id != student.id:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "BOOKING_NOT_FOUND", "message": "Booking not found."},
        )
    # Count total waitlisted for this slot
    total_waitlisted = len(session.exec(
        select(Booking).where(
            Booking.slot_id == booking.slot_id,
            Booking.status == BookingStatus.WAITLISTED,
        )
    ).all())
    return StandardResponse.ok(QueuePositionRead(
        booking_id=booking.id,
        queue_position=booking.queue_position,
        total_waitlisted=total_waitlisted,
        status=booking.status,
    ))


@router.get("/{booking_id}/priority")
def get_priority(booking_id: int, student: CurrentStudent, session: SessionDep):
    booking = session.get(Booking, booking_id)
    if not booking or booking.student_id != student.id:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "BOOKING_NOT_FOUND", "message": "Booking not found."},
        )
    return StandardResponse.ok({
        "booking_id": booking.id,
        "status": booking.status,
        "priority_score": float(booking.priority_score) if booking.priority_score is not None else None,
        "allocated_at": booking.allocated_at.isoformat() if booking.allocated_at else None,
    })
