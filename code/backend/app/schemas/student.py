from datetime import datetime
from pydantic import BaseModel
from app.models.enums import StudentStatus


class StudentRead(BaseModel):
    id: int
    student_id: str
    name: str
    email: str
    department: str
    status: StudentStatus
    created_at: datetime

    model_config = {"from_attributes": True}


class StudentQRRead(BaseModel):
    qr_identifier: str

    model_config = {"from_attributes": True}


class UsageStatsRead(BaseModel):
    sessions_last_7_days: int
    last_session_at: datetime | None
    total_sessions: int
    updated_at: datetime

    model_config = {"from_attributes": True}
