from datetime import date, datetime, time
from decimal import Decimal
from typing import Optional
from pydantic import BaseModel
from app.models.enums import BookingStatus


class BookingCreate(BaseModel):
    slot_id: int


class BookingRead(BaseModel):
    id: int
    student_id: int
    equipment_id: int
    slot_id: int
    status: BookingStatus
    priority_score: Optional[Decimal]
    queue_position: Optional[int]
    created_at: datetime
    allocated_at: Optional[datetime]

    model_config = {"from_attributes": True}


class BookingSlotInfo(BaseModel):
    id: int
    date: date
    start_time: time
    end_time: time
    booking_cutoff_at: datetime


class BookingEquipmentInfo(BaseModel):
    id: int
    name: str


class BookingReadFull(BaseModel):
    id: int
    slot: Optional[BookingSlotInfo]
    equipment: Optional[BookingEquipmentInfo]
    status: BookingStatus
    priority_score: Optional[Decimal]
    queue_position: Optional[int]
    created_at: datetime
    allocated_at: Optional[datetime]
    booking_cutoff_at: Optional[datetime]


class QueuePositionRead(BaseModel):
    booking_id: int
    queue_position: Optional[int]
    total_waitlisted: Optional[int] = None
    status: BookingStatus
