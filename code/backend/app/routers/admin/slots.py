from datetime import datetime, timezone
from fastapi import APIRouter, HTTPException, Query, status
from sqlmodel import select

from app.core.dependencies import AdminUser, SessionDep
from app.models import Booking, Equipment, Slot
from app.models.enums import BookingStatus, EquipmentStatus, SlotStatus
from app.schemas.common import StandardResponse
from app.schemas.slot import SlotCreate, SlotRead, SlotUpdate
from app.services.fairness_engine import run_batch_allocation
from app.services.notification import create_notification
from app.models.enums import NotificationType

router = APIRouter(prefix="/admin/slots", tags=["admin-slots"])


@router.post("", status_code=201)
def create_slot(body: SlotCreate, admin: AdminUser, session: SessionDep):
    equipment = session.get(Equipment, body.equipment_id)
    if not equipment:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "EQUIPMENT_NOT_FOUND", "message": "Equipment not found."},
        )
    if equipment.status == EquipmentStatus.RETIRED:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail={"code": "EQUIPMENT_RETIRED", "message": "Cannot create slot for retired equipment."},
        )
    slot_start = datetime.combine(body.date, body.start_time, tzinfo=timezone.utc)
    cutoff = body.booking_cutoff_at
    if cutoff.tzinfo is None:
        cutoff = cutoff.replace(tzinfo=timezone.utc)
    if cutoff >= slot_start:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail={"code": "VALIDATION_ERROR", "message": "booking_cutoff_at must be before slot start time."},
        )
    slot = Slot(
        equipment_id=body.equipment_id,
        date=body.date,
        start_time=body.start_time,
        end_time=body.end_time,
        capacity=body.capacity,
        available_count=body.capacity,
        booking_cutoff_at=body.booking_cutoff_at,
        created_by=admin.id,
    )
    session.add(slot)
    session.commit()
    session.refresh(slot)
    return StandardResponse.ok(SlotRead.model_validate(slot))


@router.get("")
def list_all_slots(
    admin: AdminUser,
    session: SessionDep,
    page: int = Query(1, ge=1),
    limit: int = Query(20, ge=1, le=100),
):
    query = select(Slot).order_by(Slot.date.desc())
    total = len(session.exec(query).all())
    items = session.exec(query.offset((page - 1) * limit).limit(limit)).all()
    return StandardResponse.list_ok(
        [SlotRead.model_validate(s) for s in items], page, limit, total
    )


@router.put("/{slot_id}")
def update_slot(slot_id: int, body: SlotUpdate, admin: AdminUser, session: SessionDep):
    slot = session.get(Slot, slot_id)
    if not slot:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "SLOT_NOT_FOUND", "message": "Slot not found."},
        )
    if body.capacity is not None:
        confirmed_count = len(session.exec(
            select(Booking).where(Booking.slot_id == slot_id, Booking.status == BookingStatus.CONFIRMED)
        ).all())
        if body.capacity < confirmed_count:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail={"code": "VALIDATION_ERROR", "message": f"Capacity cannot be reduced below {confirmed_count} (current confirmed bookings)."},
            )
        slot.capacity = body.capacity
        slot.available_count = max(0, body.capacity - confirmed_count)
    if body.date is not None:
        slot.date = body.date
    if body.start_time is not None:
        slot.start_time = body.start_time
    if body.end_time is not None:
        slot.end_time = body.end_time
    if body.booking_cutoff_at is not None:
        slot.booking_cutoff_at = body.booking_cutoff_at
    session.add(slot)
    session.commit()
    session.refresh(slot)
    return StandardResponse.ok(SlotRead.model_validate(slot))


@router.patch("/{slot_id}/deactivate")
def deactivate_slot(slot_id: int, admin: AdminUser, session: SessionDep):
    slot = session.get(Slot, slot_id)
    if not slot:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "SLOT_NOT_FOUND", "message": "Slot not found."},
        )
    # Cancel all REQUESTED bookings
    requested = session.exec(
        select(Booking).where(Booking.slot_id == slot_id, Booking.status == BookingStatus.REQUESTED)
    ).all()
    for b in requested:
        b.status = BookingStatus.CANCELLED
        session.add(b)
        create_notification(session, b.student_id, NotificationType.BOOKING_CANCELLED)

    slot.status = SlotStatus.CLOSED
    session.add(slot)
    session.commit()
    session.refresh(slot)
    return StandardResponse.ok({
        "id": slot.id,
        "status": slot.status,
        "cancelled_bookings": len(requested),
    })


@router.post("/{slot_id}/run-allocation")
def run_allocation(slot_id: int, admin: AdminUser, session: SessionDep):
    slot = session.get(Slot, slot_id)
    if not slot:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "SLOT_NOT_FOUND", "message": "Slot not found."},
        )
    if slot.status != SlotStatus.PENDING_ALLOCATION:
        # Transition to PENDING_ALLOCATION if still OPEN (manual trigger)
        if slot.status == SlotStatus.OPEN:
            slot.status = SlotStatus.PENDING_ALLOCATION
            session.add(slot)
            session.commit()
        else:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail={"code": "VALIDATION_ERROR", "message": f"Slot is in {slot.status} state; allocation cannot run."},
            )
    result = run_batch_allocation(session, slot_id)
    session.refresh(slot)
    return StandardResponse.ok({
        "slot_id": slot_id,
        "allocation_run_at": slot.allocation_run_at.isoformat() if slot.allocation_run_at else None,
        "confirmed_count": result["confirmed"],
        "waitlisted_count": result["waitlisted"],
        "slot_status": result["slot_status"],
    })
