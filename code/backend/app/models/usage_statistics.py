from datetime import datetime, timezone
from typing import Optional
from sqlmodel import Field, SQLModel


class UsageStatistics(SQLModel, table=True):
    __tablename__ = "usage_statistics"

    id: Optional[int] = Field(default=None, primary_key=True)
    student_id: int = Field(foreign_key="students.id", unique=True, index=True)
    sessions_last_7_days: int = Field(default=0)
    last_session_at: Optional[datetime] = Field(default=None)
    total_sessions: int = Field(default=0)
    updated_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
