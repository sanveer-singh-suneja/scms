from datetime import datetime, timezone
from fastapi import APIRouter, HTTPException, Query, status
from sqlmodel import select

from app.core.dependencies import AdminUser, SessionDep
from app.models import Defaulter, Student, Transaction
from app.models.enums import DefaulterStatus
from app.schemas.common import StandardResponse

router = APIRouter(prefix="/admin/defaulters", tags=["admin-defaulters"])


@router.get("")
def list_defaulters(
    admin: AdminUser,
    session: SessionDep,
    status_filter: DefaulterStatus | None = Query(None, alias="status"),
    page: int = Query(1, ge=1),
    limit: int = Query(20, ge=1, le=100),
):
    query = select(Defaulter)
    if status_filter:
        query = query.where(Defaulter.status == status_filter)
    total = len(session.exec(query).all())
    items = session.exec(query.order_by(Defaulter.detected_at.desc()).offset((page - 1) * limit).limit(limit)).all()

    result = []
    for d in items:
        student = session.get(Student, d.student_id)
        result.append({
            "id": d.id,
            "student_id": d.student_id,
            "student_name": student.name if student else None,
            "transaction_id": d.transaction_id,
            "detected_at": d.detected_at.isoformat(),
            "overdue_days": d.overdue_days,
            "status": d.status,
            "resolved_at": d.resolved_at.isoformat() if d.resolved_at else None,
        })
    return StandardResponse.list_ok(result, page, limit, total)


@router.get("/{defaulter_id}")
def get_defaulter(defaulter_id: int, admin: AdminUser, session: SessionDep):
    d = session.get(Defaulter, defaulter_id)
    if not d:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "NOT_FOUND", "message": "Defaulter record not found."},
        )
    student = session.get(Student, d.student_id)
    txn = session.get(Transaction, d.transaction_id)
    return StandardResponse.ok({
        "id": d.id,
        "student": {"id": student.id, "name": student.name, "student_id": student.student_id} if student else None,
        "transaction_id": d.transaction_id,
        "equipment_id": txn.equipment_id if txn else None,
        "detected_at": d.detected_at.isoformat(),
        "overdue_days": d.overdue_days,
        "status": d.status,
        "resolved_at": d.resolved_at.isoformat() if d.resolved_at else None,
        "resolved_by": d.resolved_by,
    })


@router.put("/{defaulter_id}/resolve")
def resolve_defaulter(defaulter_id: int, admin: AdminUser, session: SessionDep):
    d = session.get(Defaulter, defaulter_id)
    if not d:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "NOT_FOUND", "message": "Defaulter record not found."},
        )
    if d.status == DefaulterStatus.RESOLVED:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail={"code": "VALIDATION_ERROR", "message": "Defaulter record is already resolved."},
        )
    d.status = DefaulterStatus.RESOLVED
    d.resolved_at = datetime.now(timezone.utc)
    d.resolved_by = admin.id
    session.add(d)
    session.commit()
    session.refresh(d)
    return StandardResponse.ok({"id": d.id, "status": d.status, "resolved_at": d.resolved_at.isoformat()})
