from datetime import date
from fastapi import APIRouter, HTTPException, Query, status
from sqlmodel import select

from app.core.dependencies import SessionDep
from app.models import Equipment, Slot
from app.models.enums import SlotStatus
from app.schemas.common import StandardResponse
from app.schemas.slot import SlotRead

router = APIRouter(prefix="/slots", tags=["slots"])


def _enrich_slot(slot: Slot, equipment: Equipment | None) -> dict:
    data = SlotRead.model_validate(slot).model_dump()
    data["equipment_name"] = equipment.name if equipment else None
    return data


@router.get("")
def list_slots(
    session: SessionDep,
    equipment_id: int | None = Query(None),
    from_date: date | None = Query(None),
    page: int = Query(1, ge=1),
    limit: int = Query(20, ge=1, le=100),
):
    query = select(Slot).where(
        Slot.status.in_([SlotStatus.OPEN, SlotStatus.FULL, SlotStatus.PENDING_ALLOCATION])
    )
    if equipment_id:
        query = query.where(Slot.equipment_id == equipment_id)
    if from_date:
        query = query.where(Slot.date >= from_date)
    else:
        query = query.where(Slot.date >= date.today())
    total = len(session.exec(query).all())
    items = session.exec(query.order_by(Slot.date.asc()).offset((page - 1) * limit).limit(limit)).all()

    result = []
    for slot in items:
        equipment = session.get(Equipment, slot.equipment_id)
        result.append(_enrich_slot(slot, equipment))

    return StandardResponse.list_ok(result, page, limit, total)


@router.get("/{slot_id}")
def get_slot(slot_id: int, session: SessionDep):
    slot = session.get(Slot, slot_id)
    if not slot:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "SLOT_NOT_FOUND", "message": "Slot not found."},
        )
    equipment = session.get(Equipment, slot.equipment_id)
    return StandardResponse.ok(_enrich_slot(slot, equipment))
