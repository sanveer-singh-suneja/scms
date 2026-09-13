from pydantic import BaseModel


class AnalyticsOverview(BaseModel):
    total_equipment: int
    available_equipment: int
    total_bookings: int
    confirmed_bookings: int
    active_transactions: int
    overdue_transactions: int
    active_defaulters: int


class EquipmentAnalytics(BaseModel):
    equipment_id: int
    name: str
    category: str
    total_bookings: int
    total_issues: int
    utilization_rate: float


class BookingAnalytics(BaseModel):
    total: int
    requested: int
    confirmed: int
    waitlisted: int
    cancelled: int
    no_show: int
    completed: int


class UsageTrend(BaseModel):
    date: str
    bookings: int
    issues: int
    returns: int


class PeakHour(BaseModel):
    hour: int
    booking_count: int


class DamageStats(BaseModel):
    total_returns: int
    damaged_returns: int
    damage_rate: float
    recent_damage_reports: list[dict]
