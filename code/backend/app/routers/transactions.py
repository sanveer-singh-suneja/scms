from fastapi import APIRouter, HTTPException, Query, status
from sqlmodel import select

from app.core.dependencies import CurrentStudent, CurrentUser, SessionDep
from app.models import Equipment, Transaction
from app.models.enums import EquipmentCondition, TransactionStatus
from app.schemas.common import StandardResponse
from app.schemas.transaction import IssueRequest, ReturnRequest, TransactionRead
from app.services.transaction import issue_equipment, return_equipment

router = APIRouter(prefix="/transactions", tags=["transactions"])


def _enrich_txn(txn: Transaction, session) -> dict:
    data = TransactionRead.model_validate(txn).model_dump()
    equipment = session.get(Equipment, txn.equipment_id)
    data["equipment_name"] = equipment.name if equipment else None
    return data


@router.post("/issue", status_code=201)
def issue(body: IssueRequest, user: CurrentUser, session: SessionDep):
    txn = issue_equipment(session, body.booking_id, body.equipment_id, user.id)
    return StandardResponse.ok(_enrich_txn(txn, session))


@router.post("/{transaction_id}/return")
def process_return(transaction_id: int, body: ReturnRequest, user: CurrentUser, session: SessionDep):
    txn = return_equipment(session, transaction_id, body.condition_on_return, body.damage_report, user.id)
    return StandardResponse.ok(_enrich_txn(txn, session))


@router.get("")
def list_my_transactions(
    student: CurrentStudent,
    session: SessionDep,
    transaction_status: TransactionStatus | None = Query(None, alias="status"),
    page: int = Query(1, ge=1),
    limit: int = Query(20, ge=1, le=100),
):
    query = select(Transaction).where(Transaction.student_id == student.id)
    if transaction_status:
        query = query.where(Transaction.status == transaction_status)
    total = len(session.exec(query).all())
    items = session.exec(query.order_by(Transaction.issued_at.desc()).offset((page - 1) * limit).limit(limit)).all()
    return StandardResponse.list_ok(
        [_enrich_txn(t, session) for t in items], page, limit, total
    )


@router.get("/{transaction_id}")
def get_transaction(transaction_id: int, student: CurrentStudent, session: SessionDep):
    txn = session.get(Transaction, transaction_id)
    if not txn or txn.student_id != student.id:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "TRANSACTION_NOT_FOUND", "message": "Transaction not found."},
        )
    return StandardResponse.ok(_enrich_txn(txn, session))


@router.get("/{transaction_id}/damage")
def get_damage(transaction_id: int, student: CurrentStudent, session: SessionDep):
    txn = session.get(Transaction, transaction_id)
    if not txn or txn.student_id != student.id:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "TRANSACTION_NOT_FOUND", "message": "Transaction not found."},
        )
    if txn.condition_on_return != EquipmentCondition.DAMAGED:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "TRANSACTION_NOT_FOUND", "message": "No damage record for this transaction."},
        )
    return StandardResponse.ok({
        "transaction_id": txn.id,
        "condition_on_return": txn.condition_on_return,
        "damage_report": txn.damage_report,
        "returned_at": txn.returned_at.isoformat() if txn.returned_at else None,
    })
