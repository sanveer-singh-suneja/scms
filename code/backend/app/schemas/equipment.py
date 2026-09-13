from datetime import datetime
from typing import Optional
from pydantic import BaseModel
from app.models.enums import EquipmentCondition, EquipmentStatus


class EquipmentCreate(BaseModel):
    name: str
    category: str
    qr_code: str
    location: Optional[str] = None
    notes: Optional[str] = None


class EquipmentUpdate(BaseModel):
    name: Optional[str] = None
    category: Optional[str] = None
    location: Optional[str] = None
    notes: Optional[str] = None
    status: Optional[EquipmentStatus] = None
    condition: Optional[EquipmentCondition] = None


class EquipmentRead(BaseModel):
    id: int
    name: str
    category: str
    qr_code: str
    status: EquipmentStatus
    condition: EquipmentCondition
    location: Optional[str]
    notes: Optional[str]
    added_at: datetime

    model_config = {"from_attributes": True}


class EquipmentAvailability(BaseModel):
    equipment_id: int
    available_slots: list[dict]
