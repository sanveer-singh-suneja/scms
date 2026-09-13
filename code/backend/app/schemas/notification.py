from datetime import datetime
from typing import Optional
from pydantic import BaseModel
from app.models.enums import NotificationType


class NotificationRead(BaseModel):
    id: int
    student_id: int
    type: NotificationType
    title: str
    message: str
    is_read: bool
    created_at: datetime
    expires_at: Optional[datetime]

    model_config = {"from_attributes": True}


class UnreadCountRead(BaseModel):
    unread_count: int
