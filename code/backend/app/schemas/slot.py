from datetime import date, datetime, time
from typing import Optional
from pydantic import BaseModel, field_validator
from app.models.enums import SlotStatus


class SlotCreate(BaseModel):
    equipment_id: int
    date: date
    start_time: time
    end_time: time
    capacity: int
    booking_cutoff_at: datetime

    @field_validator("capacity")
    @classmethod
    def capacity_positive(cls, v: int) -> int:
        if v < 1:
            raise ValueError("capacity must be >= 1")
        return v


class SlotUpdate(BaseModel):
    date: Optional[date] = None
    start_time: Optional[time] = None
    end_time: Optional[time] = None
    capacity: Optional[int] = None
    booking_cutoff_at: Optional[datetime] = None


class SlotRead(BaseModel):
    id: int
    equipment_id: int
    equipment_name: Optional[str] = None
    date: date
    start_time: time
    end_time: time
    capacity: int
    available_count: int
    booking_cutoff_at: datetime
    allocation_run_at: Optional[datetime]
    status: SlotStatus
    created_at: datetime

    model_config = {"from_attributes": True}
