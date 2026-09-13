from datetime import datetime, timezone
from decimal import Decimal
from typing import Optional
from sqlalchemy import UniqueConstraint
from sqlmodel import Field, SQLModel
from app.models.enums import BookingStatus


class Booking(SQLModel, table=True):
    __tablename__ = "bookings"
    __table_args__ = (UniqueConstraint("student_id", "slot_id", name="uq_booking_student_slot"),)

    id: Optional[int] = Field(default=None, primary_key=True)
    student_id: int = Field(foreign_key="students.id", index=True)
    equipment_id: int = Field(foreign_key="equipment.id")
    slot_id: int = Field(foreign_key="slots.id", index=True)
    status: BookingStatus = Field(default=BookingStatus.REQUESTED, index=True)
    priority_score: Optional[Decimal] = Field(default=None, decimal_places=4, max_digits=6)
    queue_position: Optional[int] = Field(default=None)
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc), index=True)
    allocated_at: Optional[datetime] = Field(default=None)
