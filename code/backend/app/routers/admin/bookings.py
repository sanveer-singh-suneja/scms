from fastapi import APIRouter, Query
from sqlmodel import select

from app.core.dependencies import AdminUser, SessionDep
from app.models import Booking
from app.models.enums import BookingStatus
from app.schemas.booking import BookingRead
from app.schemas.common import StandardResponse

router = APIRouter(prefix="/admin/bookings", tags=["admin-bookings"])


@router.get("")
def list_all_bookings(
    admin: AdminUser,
    session: SessionDep,
    slot_id: int | None = Query(None),
    booking_status: BookingStatus | None = Query(None, alias="status"),
    page: int = Query(1, ge=1),
    limit: int = Query(20, ge=1, le=100),
):
    query = select(Booking)
    if slot_id:
        query = query.where(Booking.slot_id == slot_id)
    if booking_status:
        query = query.where(Booking.status == booking_status)
    total = len(session.exec(query).all())
    items = session.exec(query.order_by(Booking.created_at.desc()).offset((page - 1) * limit).limit(limit)).all()
    return StandardResponse.list_ok(
        [BookingRead.model_validate(b) for b in items], page, limit, total
    )
