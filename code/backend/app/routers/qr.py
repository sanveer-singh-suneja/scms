from fastapi import APIRouter, HTTPException, status
from sqlmodel import select

from app.core.dependencies import CurrentUser, SessionDep
from app.models import Booking, Equipment, Slot, Student, Transaction
from app.models.enums import BookingStatus, EquipmentStatus, TransactionStatus
from app.schemas.common import StandardResponse
from pydantic import BaseModel

router = APIRouter(prefix="/qr", tags=["qr"])


class StudentQRValidateRequest(BaseModel):
    token: str


class EquipmentQRValidateRequest(BaseModel):
    qr_code: str


@router.post("/validate/student")
def validate_student_qr(body: StudentQRValidateRequest, user: CurrentUser, session: SessionDep):
    student = session.exec(
        select(Student).where(Student.qr_identifier == body.token)
    ).first()
    if not student:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "QR_NOT_FOUND", "message": "Student QR token not recognized."},
        )

    # Find most recent CONFIRMED booking
    confirmed_booking = session.exec(
        select(Booking).where(
            Booking.student_id == student.id,
            Booking.status == BookingStatus.CONFIRMED,
        ).order_by(Booking.created_at.desc())
    ).first()

    current_booking = None
    if confirmed_booking:
        equipment = session.get(Equipment, confirmed_booking.equipment_id)
        slot = session.get(Slot, confirmed_booking.slot_id)
        current_booking = {
            "id": confirmed_booking.id,
            "equipment": {
                "id": equipment.id,
                "name": equipment.name,
            } if equipment else {"id": confirmed_booking.equipment_id, "name": ""},
            "slot": {
                "id": slot.id,
                "date": str(slot.date),
                "start_time": str(slot.start_time),
                "end_time": str(slot.end_time),
            } if slot else None,
            "status": confirmed_booking.status,
        }

    # Find open transaction (ISSUED or OVERDUE)
    open_txn = session.exec(
        select(Transaction).where(
            Transaction.student_id == student.id,
            Transaction.status.in_([TransactionStatus.ISSUED, TransactionStatus.OVERDUE]),
        ).order_by(Transaction.issued_at.desc())
    ).first()

    open_transaction = None
    if open_txn:
        equipment = session.get(Equipment, open_txn.equipment_id)
        open_transaction = {
            "id": open_txn.id,
            "student_id": open_txn.student_id,
            "equipment_id": open_txn.equipment_id,
            "equipment_name": equipment.name if equipment else None,
            "issued_at": open_txn.issued_at.isoformat(),
            "due_at": open_txn.due_at.isoformat(),
            "status": open_txn.status,
            "issued_by": open_txn.issued_by,
        }

    return StandardResponse.ok({
        "student": {
            "id": student.id,
            "student_id": student.student_id,
            "name": student.name,
            "department": student.department,
            "status": student.status,
        },
        "current_booking": current_booking,
        "open_transaction": open_transaction,
    })


@router.post("/validate/equipment")
def validate_equipment_qr(body: EquipmentQRValidateRequest, user: CurrentUser, session: SessionDep):
    equipment = session.exec(
        select(Equipment).where(Equipment.qr_code == body.qr_code)
    ).first()
    if not equipment:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "EQUIPMENT_NOT_FOUND", "message": "Equipment QR code not recognized."},
        )
    if equipment.status == EquipmentStatus.RETIRED:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail={"code": "EQUIPMENT_RETIRED", "message": "This equipment is retired."},
        )
    return StandardResponse.ok({
        "id": equipment.id,
        "name": equipment.name,
        "category": equipment.category,
        "qr_code": equipment.qr_code,
        "status": equipment.status,
        "condition": equipment.condition,
    })
