from datetime import date
from fastapi import APIRouter, Query
from sqlmodel import select

from app.core.dependencies import CurrentUser, SessionDep
from app.models import Booking, Equipment, Slot, Student, Transaction
from app.models.enums import BookingStatus, SlotStatus, TransactionStatus
from app.schemas.common import StandardResponse

router = APIRouter(prefix="/staff/queue", tags=["staff"])


@router.get("")
def get_queue(
    user: CurrentUser,
    session: SessionDep,
    slot_id: int | None = Query(None),
    for_date: date | None = Query(None),
):
    """Return today's confirmed bookings and open transactions for staff."""
    target_date = for_date or date.today()

    # ── Confirmed bookings today ────────────────────────────────────────────
    if slot_id:
        slots = [session.get(Slot, slot_id)] if session.get(Slot, slot_id) else []
    else:
        slots = session.exec(
            select(Slot).where(
                Slot.date == target_date,
                Slot.status.in_([SlotStatus.OPEN, SlotStatus.FULL, SlotStatus.PENDING_ALLOCATION]),
            )
        ).all()

    confirmed_bookings_today = []
    for slot in slots:
        if slot is None:
            continue
        bookings = session.exec(
            select(Booking).where(
                Booking.slot_id == slot.id,
                Booking.status == BookingStatus.CONFIRMED,
            ).order_by(Booking.created_at.asc())
        ).all()
        for b in bookings:
            student = session.get(Student, b.student_id)
            equipment = session.get(Equipment, b.equipment_id)
            confirmed_bookings_today.append({
                "booking_id": b.id,
                "student": {
                    "id": student.id,
                    "name": student.name,
                    "student_id": student.student_id,
                } if student else None,
                "equipment": {
                    "id": equipment.id,
                    "name": equipment.name,
                } if equipment else {"id": b.equipment_id, "name": ""},
                "slot": {
                    "start_time": str(slot.start_time),
                    "end_time": str(slot.end_time),
                },
                "status": b.status,
            })

    # ── Open transactions (ISSUED + OVERDUE) ────────────────────────────────
    open_txns = session.exec(
        select(Transaction).where(
            Transaction.status.in_([TransactionStatus.ISSUED, TransactionStatus.OVERDUE]),
        ).order_by(Transaction.due_at.asc())
    ).all()

    open_transactions = []
    for txn in open_txns:
        student = session.get(Student, txn.student_id)
        equipment = session.get(Equipment, txn.equipment_id)
        open_transactions.append({
            "transaction_id": txn.id,
            "student": {
                "id": student.id,
                "name": student.name,
            } if student else None,
            "equipment": {
                "id": equipment.id,
                "name": equipment.name,
            } if equipment else {"id": txn.equipment_id, "name": ""},
            "issued_at": txn.issued_at.isoformat(),
            "due_at": txn.due_at.isoformat(),
            "status": txn.status,
        })

    return StandardResponse.ok({
        "confirmed_bookings_today": confirmed_bookings_today,
        "open_transactions": open_transactions,
    })
