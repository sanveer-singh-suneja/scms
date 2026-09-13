from datetime import datetime, timezone
from typing import Optional
from sqlmodel import Field, SQLModel
from app.models.enums import EquipmentCondition, TransactionStatus


class Transaction(SQLModel, table=True):
    __tablename__ = "transactions"

    id: Optional[int] = Field(default=None, primary_key=True)
    booking_id: Optional[int] = Field(default=None, foreign_key="bookings.id", index=True)
    student_id: int = Field(foreign_key="students.id", index=True)
    equipment_id: int = Field(foreign_key="equipment.id", index=True)
    issued_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    due_at: datetime = Field(index=True)
    returned_at: Optional[datetime] = Field(default=None)
    status: TransactionStatus = Field(default=TransactionStatus.ISSUED, index=True)
    condition_on_return: Optional[EquipmentCondition] = Field(default=None)
    damage_report: Optional[str] = Field(default=None)
    issued_by: int = Field(foreign_key="users.id")
    returned_to: Optional[int] = Field(default=None, foreign_key="users.id")
