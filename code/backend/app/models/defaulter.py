from datetime import datetime, timezone
from typing import Optional
from sqlmodel import Field, SQLModel
from app.models.enums import DefaulterStatus


class Defaulter(SQLModel, table=True):
    __tablename__ = "defaulters"

    id: Optional[int] = Field(default=None, primary_key=True)
    student_id: int = Field(foreign_key="students.id", index=True)
    transaction_id: int = Field(foreign_key="transactions.id", unique=True, index=True)
    detected_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    overdue_days: int
    status: DefaulterStatus = Field(default=DefaulterStatus.ACTIVE, index=True)
    resolved_at: Optional[datetime] = Field(default=None)
    resolved_by: Optional[int] = Field(default=None, foreign_key="users.id")
