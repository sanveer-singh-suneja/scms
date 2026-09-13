from datetime import datetime, timezone
from typing import Optional
from sqlmodel import Field, SQLModel
from app.models.enums import EquipmentCondition, EquipmentStatus


class Equipment(SQLModel, table=True):
    __tablename__ = "equipment"

    id: Optional[int] = Field(default=None, primary_key=True)
    name: str = Field(max_length=255)
    category: str = Field(max_length=100, index=True)
    qr_code: str = Field(max_length=255, unique=True, index=True)
    status: EquipmentStatus = Field(default=EquipmentStatus.AVAILABLE, index=True)
    condition: EquipmentCondition = Field(default=EquipmentCondition.GOOD)
    location: Optional[str] = Field(default=None, max_length=255)
    notes: Optional[str] = Field(default=None)
    added_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    added_by: int = Field(foreign_key="users.id")
