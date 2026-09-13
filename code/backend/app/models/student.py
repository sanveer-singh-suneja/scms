from datetime import datetime, timezone
from typing import Optional
from sqlmodel import Field, SQLModel
from app.models.enums import StudentStatus


class Student(SQLModel, table=True):
    __tablename__ = "students"

    id: Optional[int] = Field(default=None, primary_key=True)
    student_id: str = Field(max_length=50, index=True, unique=True)
    name: str = Field(max_length=255)
    email: str = Field(max_length=255, index=True, unique=True)
    department: str = Field(max_length=255)
    password_hash: str = Field(max_length=255)
    qr_identifier: str = Field(max_length=255, unique=True, index=True)
    status: StudentStatus = Field(default=StudentStatus.ACTIVE)
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
