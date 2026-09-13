from fastapi import APIRouter, Query
from sqlmodel import select

from app.core.dependencies import AdminUser, SessionDep
from app.models import Equipment, Transaction
from app.models.enums import TransactionStatus
from app.schemas.common import StandardResponse
from app.schemas.transaction import TransactionRead

router = APIRouter(prefix="/admin/transactions", tags=["admin-transactions"])


def _enrich(txn: Transaction, session) -> dict:
    data = TransactionRead.model_validate(txn).model_dump()
    equipment = session.get(Equipment, txn.equipment_id)
    data["equipment_name"] = equipment.name if equipment else None
    return data


@router.get("")
def list_all_transactions(
    admin: AdminUser,
    session: SessionDep,
    transaction_status: TransactionStatus | None = Query(None, alias="status"),
    equipment_id: int | None = Query(None),
    student_id: int | None = Query(None),
    page: int = Query(1, ge=1),
    limit: int = Query(20, ge=1, le=100),
):
    query = select(Transaction)
    if transaction_status:
        query = query.where(Transaction.status == transaction_status)
    if equipment_id:
        query = query.where(Transaction.equipment_id == equipment_id)
    if student_id:
        query = query.where(Transaction.student_id == student_id)
    total = len(session.exec(query).all())
    items = session.exec(
        query.order_by(Transaction.issued_at.desc())
        .offset((page - 1) * limit)
        .limit(limit)
    ).all()
    return StandardResponse.list_ok([_enrich(t, session) for t in items], page, limit, total)
