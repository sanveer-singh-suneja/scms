from datetime import datetime, timezone
from decimal import Decimal
from typing import Optional
from sqlmodel import Field, SQLModel


class FairnessConfig(SQLModel, table=True):
    __tablename__ = "fairness_config"

    id: int = Field(default=1, primary_key=True)
    daily_usage_cap: int = Field(default=2)
    recency_threshold_days: int = Field(default=2)
    recency_weight: Decimal = Field(default=Decimal("0.50"), decimal_places=2, max_digits=3)
    updated_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    updated_by: Optional[int] = Field(default=None, foreign_key="users.id")
