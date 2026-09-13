from fastapi import APIRouter
from sqlmodel import select

from app.core.dependencies import CurrentStudent, SessionDep
from app.models import UsageStatistics
from app.schemas.common import StandardResponse
from app.schemas.student import StudentQRRead, UsageStatsRead

router = APIRouter(prefix="/students", tags=["students"])


@router.get("/qr")
def get_qr(student: CurrentStudent):
    return StandardResponse.ok({"qr_identifier": student.qr_identifier})


@router.get("/usage-stats")
def get_usage_stats(student: CurrentStudent, session: SessionDep):
    stats = session.exec(
        select(UsageStatistics).where(UsageStatistics.student_id == student.id)
    ).first()
    if stats is None:
        return StandardResponse.ok({
            "sessions_last_7_days": 0,
            "last_session_at": None,
            "total_sessions": 0,
            "updated_at": None,
        })
    return StandardResponse.ok(UsageStatsRead.model_validate(stats))
