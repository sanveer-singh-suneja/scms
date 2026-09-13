from datetime import date, timedelta
from sqlalchemy import func
from sqlmodel import Session, select

from app.models import Booking, Defaulter, Equipment, Transaction
from app.models.enums import BookingStatus, DefaulterStatus, EquipmentStatus, TransactionStatus
from app.schemas.analytics import (
    AnalyticsOverview,
    BookingAnalytics,
    DamageStats,
    EquipmentAnalytics,
    PeakHour,
    UsageTrend,
)


def get_overview(session: Session) -> AnalyticsOverview:
    total_eq = session.exec(select(func.count()).select_from(Equipment)).one()
    available_eq = session.exec(
        select(func.count()).select_from(Equipment).where(Equipment.status == EquipmentStatus.AVAILABLE)
    ).one()
    total_bookings = session.exec(select(func.count()).select_from(Booking)).one()
    confirmed = session.exec(
        select(func.count()).select_from(Booking).where(Booking.status == BookingStatus.CONFIRMED)
    ).one()
    active_txns = session.exec(
        select(func.count()).select_from(Transaction).where(
            Transaction.status.in_([TransactionStatus.ISSUED, TransactionStatus.OVERDUE])
        )
    ).one()
    overdue_txns = session.exec(
        select(func.count()).select_from(Transaction).where(Transaction.status == TransactionStatus.OVERDUE)
    ).one()
    active_defaulters = session.exec(
        select(func.count()).select_from(Defaulter).where(Defaulter.status == DefaulterStatus.ACTIVE)
    ).one()
    return AnalyticsOverview(
        total_equipment=total_eq,
        available_equipment=available_eq,
        total_bookings=total_bookings,
        confirmed_bookings=confirmed,
        active_transactions=active_txns,
        overdue_transactions=overdue_txns,
        active_defaulters=active_defaulters,
    )


def get_booking_analytics(session: Session) -> BookingAnalytics:
    counts = {}
    for s in BookingStatus:
        counts[s.value] = session.exec(
            select(func.count()).select_from(Booking).where(Booking.status == s)
        ).one()
    return BookingAnalytics(
        total=session.exec(select(func.count()).select_from(Booking)).one(),
        requested=counts.get("REQUESTED", 0),
        confirmed=counts.get("CONFIRMED", 0),
        waitlisted=counts.get("WAITLISTED", 0),
        cancelled=counts.get("CANCELLED", 0),
        no_show=counts.get("NO_SHOW", 0),
        completed=counts.get("COMPLETED", 0),
    )


def get_equipment_analytics(session: Session) -> list[EquipmentAnalytics]:
    equipment_list = session.exec(select(Equipment)).all()
    result = []
    for eq in equipment_list:
        total_b = session.exec(
            select(func.count()).select_from(Booking).where(Booking.equipment_id == eq.id)
        ).one()
        total_i = session.exec(
            select(func.count()).select_from(Transaction).where(Transaction.equipment_id == eq.id)
        ).one()
        utilization = round(total_i / max(total_b, 1) * 100, 1) if total_b > 0 else 0.0
        result.append(EquipmentAnalytics(
            equipment_id=eq.id,
            name=eq.name,
            category=eq.category,
            total_bookings=total_b,
            total_issues=total_i,
            utilization_rate=utilization,
        ))
    return result


def get_usage_trends(session: Session, days: int = 7) -> list[UsageTrend]:
    trends = []
    for i in range(days - 1, -1, -1):
        d = date.today() - timedelta(days=i)
        bookings = session.exec(
            select(func.count()).select_from(Booking).where(func.date(Booking.created_at) == d)
        ).one()
        issues = session.exec(
            select(func.count()).select_from(Transaction).where(func.date(Transaction.issued_at) == d)
        ).one()
        returns = session.exec(
            select(func.count()).select_from(Transaction).where(func.date(Transaction.returned_at) == d)
        ).one()
        trends.append(UsageTrend(date=str(d), bookings=bookings, issues=issues, returns=returns))
    return trends


def get_peak_hours(session: Session) -> list[PeakHour]:
    peaks = []
    for hour in range(24):
        count = session.exec(
            select(func.count()).select_from(Booking).where(
                func.extract("hour", Booking.created_at) == hour
            )
        ).one()
        peaks.append(PeakHour(hour=hour, booking_count=count))
    return sorted(peaks, key=lambda p: p.booking_count, reverse=True)


def get_damage_stats(session: Session) -> DamageStats:
    total_returns = session.exec(
        select(func.count()).select_from(Transaction).where(
            Transaction.status.in_([TransactionStatus.RETURNED, TransactionStatus.RETURNED_DAMAGED])
        )
    ).one()
    damaged = session.exec(
        select(func.count()).select_from(Transaction).where(Transaction.status == TransactionStatus.RETURNED_DAMAGED)
    ).one()
    damage_rate = round(damaged / max(total_returns, 1) * 100, 1)
    recent = session.exec(
        select(Transaction).where(
            Transaction.status == TransactionStatus.RETURNED_DAMAGED,
            Transaction.damage_report.is_not(None),
        ).order_by(Transaction.returned_at.desc()).limit(10)
    ).all()
    reports = [
        {"transaction_id": t.id, "equipment_id": t.equipment_id,
         "damage_report": t.damage_report, "returned_at": str(t.returned_at)}
        for t in recent
    ]
    return DamageStats(
        total_returns=total_returns,
        damaged_returns=damaged,
        damage_rate=damage_rate,
        recent_damage_reports=reports,
    )
