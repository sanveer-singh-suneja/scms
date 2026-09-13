from datetime import datetime
from typing import Optional
from pydantic import BaseModel
from app.models.enums import EquipmentCondition, TransactionStatus


class IssueRequest(BaseModel):
    booking_id: int
    equipment_id: int


class ReturnRequest(BaseModel):
    condition_on_return: EquipmentCondition
    damage_report: Optional[str] = None


class TransactionRead(BaseModel):
    id: int
    booking_id: Optional[int]
    student_id: int
    equipment_id: int
    equipment_name: Optional[str] = None
    issued_at: datetime
    due_at: datetime
    returned_at: Optional[datetime]
    status: TransactionStatus
    condition_on_return: Optional[EquipmentCondition]
    damage_report: Optional[str]
    issued_by: int
    returned_to: Optional[int]

    model_config = {"from_attributes": True}
