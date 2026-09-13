// All shapes mirror backend app/schemas/analytics.py exactly.

export interface AnalyticsOverview {
  total_equipment: number;
  available_equipment: number;
  total_bookings: number;
  confirmed_bookings: number;
  active_transactions: number;
  overdue_transactions: number;
  active_defaulters: number;
}

export interface EquipmentAnalytics {
  equipment_id: number;
  name: string;
  category: string;
  total_bookings: number;
  total_issues: number;
  utilization_rate: number;
}

// Single status-count object — NOT a time series.
export interface BookingAnalytics {
  total: number;
  requested: number;
  confirmed: number;
  waitlisted: number;
  cancelled: number;
  no_show: number;
  completed: number;
}

export interface UsageTrend {
  date: string;
  bookings: number;
  issues: number;
  returns: number;
}

export interface PeakHour {
  hour: number;
  booking_count: number;
}

export interface DamageReport {
  transaction_id: number;
  equipment_id: number;
  damage_report: string;
  returned_at: string;
}

export interface DamageStats {
  total_returns: number;
  damaged_returns: number;
  damage_rate: number;
  recent_damage_reports: DamageReport[];
}

export interface FairnessConfig {
  id: number;
  daily_usage_cap: number;
  recency_threshold_days: number;
  recency_weight: number;
  updated_at: string;
  updated_by: number | null;
}
