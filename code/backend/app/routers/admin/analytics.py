from fastapi import APIRouter, Query

from app.core.dependencies import AdminUser, SessionDep
from app.schemas.common import StandardResponse
from app.services import analytics as analytics_service

router = APIRouter(prefix="/admin/analytics", tags=["admin-analytics"])


@router.get("/overview")
def overview(admin: AdminUser, session: SessionDep):
    return StandardResponse.ok(analytics_service.get_overview(session))


@router.get("/equipment")
def equipment_analytics(admin: AdminUser, session: SessionDep):
    return StandardResponse.ok(analytics_service.get_equipment_analytics(session))


@router.get("/bookings")
def booking_analytics(admin: AdminUser, session: SessionDep):
    return StandardResponse.ok(analytics_service.get_booking_analytics(session))


@router.get("/usage-trends")
def usage_trends(
    admin: AdminUser,
    session: SessionDep,
    days: int = Query(7, ge=1, le=90),
):
    return StandardResponse.ok(analytics_service.get_usage_trends(session, days))


@router.get("/peak-hours")
def peak_hours(admin: AdminUser, session: SessionDep):
    return StandardResponse.ok(analytics_service.get_peak_hours(session))


@router.get("/damage-stats")
def damage_stats(admin: AdminUser, session: SessionDep):
    return StandardResponse.ok(analytics_service.get_damage_stats(session))
