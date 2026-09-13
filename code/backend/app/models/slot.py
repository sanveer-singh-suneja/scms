from datetime import date, datetime, time, timezone
from typing import Optional
from sqlmodel import Field, SQLModel
from app.models.enums import SlotStatus


class Slot(SQLModel, table=True):
    __tablename__ = "slots"

    id: Optional[int] = Field(default=None, primary_key=True)
    equipment_id: int = Field(foreign_key="equipment.id", index=True)
    date: date
    start_time: time
    end_time: time
    capacity: int
    available_count: int
    booking_cutoff_at: datetime = Field(index=True)
    allocation_run_at: Optional[datetime] = Field(default=None)
    status: SlotStatus = Field(default=SlotStatus.OPEN, index=True)
    created_by: int = Field(foreign_key="users.id")
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
