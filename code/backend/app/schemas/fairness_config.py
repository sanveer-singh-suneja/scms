from datetime import datetime
from decimal import Decimal
from typing import Optional
from pydantic import BaseModel, field_validator


class FairnessConfigRead(BaseModel):
    id: int
    daily_usage_cap: int
    recency_threshold_days: int
    recency_weight: Decimal
    updated_at: datetime
    updated_by: Optional[int]

    model_config = {"from_attributes": True}


class FairnessConfigUpdate(BaseModel):
    daily_usage_cap: Optional[int] = None
    recency_threshold_days: Optional[int] = None
    recency_weight: Optional[Decimal] = None

    @field_validator("daily_usage_cap")
    @classmethod
    def cap_ge_1(cls, v: Optional[int]) -> Optional[int]:
        if v is not None and v < 1:
            raise ValueError("daily_usage_cap must be >= 1")
        return v

    @field_validator("recency_threshold_days")
    @classmethod
    def threshold_ge_1(cls, v: Optional[int]) -> Optional[int]:
        if v is not None and v < 1:
            raise ValueError("recency_threshold_days must be >= 1")
        return v

    @field_validator("recency_weight")
    @classmethod
    def weight_range(cls, v: Optional[Decimal]) -> Optional[Decimal]:
        if v is not None and not (Decimal("0.0") <= v <= Decimal("1.0")):
            raise ValueError("recency_weight must be between 0.0 and 1.0")
        return v
