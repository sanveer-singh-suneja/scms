from datetime import datetime, timezone
from fastapi import APIRouter, HTTPException, status

from app.core.dependencies import AdminUser, SessionDep
from app.models import FairnessConfig
from app.schemas.common import StandardResponse
from app.schemas.fairness_config import FairnessConfigRead, FairnessConfigUpdate

router = APIRouter(prefix="/admin/fairness-config", tags=["admin-fairness"])


@router.get("")
def get_config(admin: AdminUser, session: SessionDep):
    cfg = session.get(FairnessConfig, 1)
    if cfg is None:
        cfg = FairnessConfig()
        session.add(cfg)
        session.commit()
        session.refresh(cfg)
    return StandardResponse.ok(FairnessConfigRead.model_validate(cfg))


@router.put("")
def update_config(body: FairnessConfigUpdate, admin: AdminUser, session: SessionDep):
    cfg = session.get(FairnessConfig, 1)
    if cfg is None:
        cfg = FairnessConfig()
    if body.daily_usage_cap is not None:
        cfg.daily_usage_cap = body.daily_usage_cap
    if body.recency_threshold_days is not None:
        cfg.recency_threshold_days = body.recency_threshold_days
    if body.recency_weight is not None:
        cfg.recency_weight = body.recency_weight
    cfg.updated_at = datetime.now(timezone.utc)
    cfg.updated_by = admin.id
    session.add(cfg)
    session.commit()
    session.refresh(cfg)
    return StandardResponse.ok(FairnessConfigRead.model_validate(cfg))
