from fastapi import APIRouter, HTTPException, Query, status
from sqlmodel import select

from app.core.dependencies import AdminUser, CurrentUser, SessionDep
from app.models import Equipment
from app.models.enums import EquipmentStatus
from app.schemas.common import StandardResponse
from app.schemas.equipment import EquipmentCreate, EquipmentRead, EquipmentUpdate

router = APIRouter(prefix="/inventory", tags=["inventory"])


@router.get("")
def list_inventory(
    user: CurrentUser,
    session: SessionDep,
    page: int = Query(1, ge=1),
    limit: int = Query(20, ge=1, le=100),
    category: str | None = Query(None),
    status: EquipmentStatus | None = Query(None),
):
    query = select(Equipment)
    if category:
        query = query.where(Equipment.category == category)
    if status:
        query = query.where(Equipment.status == status)
    total = len(session.exec(query).all())
    items = session.exec(query.offset((page - 1) * limit).limit(limit)).all()
    return StandardResponse.list_ok(
        [EquipmentRead.model_validate(e) for e in items], page, limit, total
    )


@router.post("", status_code=201)
def add_equipment(body: EquipmentCreate, admin: AdminUser, session: SessionDep):
    if session.exec(select(Equipment).where(Equipment.qr_code == body.qr_code)).first():
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail={"code": "QR_CODE_ALREADY_EXISTS", "message": "QR code already assigned."},
        )
    eq = Equipment(
        name=body.name,
        category=body.category,
        qr_code=body.qr_code,
        location=body.location,
        notes=body.notes,
        added_by=admin.id,
    )
    session.add(eq)
    session.commit()
    session.refresh(eq)
    return StandardResponse.ok(EquipmentRead.model_validate(eq))


@router.put("/{equipment_id}")
def update_equipment(equipment_id: int, body: EquipmentUpdate, admin: AdminUser, session: SessionDep):
    eq = session.get(Equipment, equipment_id)
    if not eq:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "EQUIPMENT_NOT_FOUND", "message": "Equipment not found."},
        )
    if body.name is not None:
        eq.name = body.name
    if body.category is not None:
        eq.category = body.category
    if body.location is not None:
        eq.location = body.location
    if body.notes is not None:
        eq.notes = body.notes
    if body.status is not None:
        if eq.status == EquipmentStatus.ISSUED:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail={"code": "CANNOT_RETIRE_ISSUED", "message": "Cannot change status of issued equipment."},
            )
        eq.status = body.status
    if body.condition is not None:
        eq.condition = body.condition
    session.add(eq)
    session.commit()
    session.refresh(eq)
    return StandardResponse.ok(EquipmentRead.model_validate(eq))


@router.patch("/{equipment_id}/retire")
def retire_equipment(equipment_id: int, admin: AdminUser, session: SessionDep):
    eq = session.get(Equipment, equipment_id)
    if not eq:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "EQUIPMENT_NOT_FOUND", "message": "Equipment not found."},
        )
    if eq.status == EquipmentStatus.ISSUED:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail={"code": "CANNOT_RETIRE_ISSUED", "message": "Cannot retire equipment that is currently issued."},
        )
    eq.status = EquipmentStatus.RETIRED
    session.add(eq)
    session.commit()
    session.refresh(eq)
    return StandardResponse.ok(EquipmentRead.model_validate(eq))
