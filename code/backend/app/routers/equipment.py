from datetime import date
from fastapi import APIRouter, HTTPException, Query, status
from sqlmodel import select

from app.core.dependencies import SessionDep
from app.models import Equipment, Slot
from app.models.enums import EquipmentStatus, SlotStatus
from app.schemas.common import StandardResponse
from app.schemas.equipment import EquipmentRead

router = APIRouter(prefix="/equipment", tags=["equipment"])


@router.get("")
def list_equipment(
    session: SessionDep,
    category: str | None = Query(None),
    page: int = Query(1, ge=1),
    limit: int = Query(20, ge=1, le=100),
):
    query = select(Equipment).where(Equipment.status != EquipmentStatus.RETIRED)
    if category:
        query = query.where(Equipment.category == category)
    total = len(session.exec(query).all())
    items = session.exec(query.offset((page - 1) * limit).limit(limit)).all()
    return StandardResponse.list_ok(
        [EquipmentRead.model_validate(e) for e in items], page, limit, total
    )


@router.get("/{equipment_id}")
def get_equipment(equipment_id: int, session: SessionDep):
    eq = session.get(Equipment, equipment_id)
    if not eq or eq.status == EquipmentStatus.RETIRED:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "EQUIPMENT_NOT_FOUND", "message": "Equipment not found."},
        )
    return StandardResponse.ok(EquipmentRead.model_validate(eq))


@router.get("/{equipment_id}/availability")
def get_availability(equipment_id: int, session: SessionDep):
    eq = session.get(Equipment, equipment_id)
    if not eq or eq.status == EquipmentStatus.RETIRED:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "EQUIPMENT_NOT_FOUND", "message": "Equipment not found."},
        )
    today = date.today()
    slots = session.exec(
        select(Slot).where(
            Slot.equipment_id == equipment_id,
            Slot.date >= today,
            Slot.status.in_([SlotStatus.OPEN, SlotStatus.FULL]),
        ).order_by(Slot.date.asc())
    ).all()
    slot_data = [
        {
            "slot_id": s.id,
            "date": str(s.date),
            "start_time": str(s.start_time),
            "end_time": str(s.end_time),
            "capacity": s.capacity,
            "available_count": s.available_count,
            "status": s.status,
            "booking_cutoff_at": s.booking_cutoff_at.isoformat(),
        }
        for s in slots
    ]
    return StandardResponse.ok({"equipment_id": equipment_id, "available_slots": slot_data})
