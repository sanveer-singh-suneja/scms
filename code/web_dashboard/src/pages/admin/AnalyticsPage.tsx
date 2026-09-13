import { useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import { apiClient } from '@/api/client';
import { ENDPOINTS } from '@/api/endpoints';
import type {
  BookingAnalytics,
  UsageTrend,
  EquipmentAnalytics,
  PeakHour,
  DamageStats,
} from '@/types/analytics';
import type { ApiResponse } from '@/types/common';
import { Card, CardHeader, CardTitle, StatCard } from '@/components/ui/Card';
import { BarChartWidget } from '@/components/charts/BarChartWidget';
import { LineChartWidget } from '@/components/charts/LineChartWidget';
import { Spinner } from '@/components/ui/Spinner';
import { EmptyState, ErrorState } from '@/components/ui/EmptyState';
import {
  Table,
  TableHead,
  TableBody,
  TableRow,
  TableCell,
  TableHeadCell,
} from '@/components/ui/Table';
import { extractApiError } from '@/features/auth/AuthContext';
import { formatHour, shortDate, formatRelative } from '@/utils/format';

const PERIOD_OPTIONS = [
  { label: '7 days', value: 7 },
  { label: '14 days', value: 14 },
  { label: '30 days', value: 30 },
];

export function AnalyticsPage() {
  const [days, setDays] = useState(7);

  const trends = useQuery({
    queryKey: ['analytics', 'usage-trends', days],
    queryFn: () =>
      apiClient
        .get<ApiResponse<UsageTrend[]>>(ENDPOINTS.ANALYTICS_USAGE_TRENDS, { params: { days } })
        .then((r) => r.data.data),
    staleTime: 30_000,
  });

  const bookings = useQuery({
    queryKey: ['analytics', 'bookings'],
    queryFn: () =>
      apiClient
        .get<ApiResponse<BookingAnalytics>>(ENDPOINTS.ANALYTICS_BOOKINGS)
        .then((r) => r.data.data),
    staleTime: 30_000,
  });

  const equipment = useQuery({
    queryKey: ['analytics', 'equipment'],
    queryFn: () =>
      apiClient
        .get<ApiResponse<EquipmentAnalytics[]>>(ENDPOINTS.ANALYTICS_EQUIPMENT)
        .then((r) => r.data.data),
    staleTime: 30_000,
  });

  const peakHours = useQuery({
    queryKey: ['analytics', 'peak-hours'],
    queryFn: () =>
      apiClient
        .get<ApiResponse<PeakHour[]>>(ENDPOINTS.ANALYTICS_PEAK_HOURS)
        .then((r) => r.data.data),
    staleTime: 30_000,
  });

  const damage = useQuery({
    queryKey: ['analytics', 'damage-stats'],
    queryFn: () =>
      apiClient
        .get<ApiResponse<DamageStats>>(ENDPOINTS.ANALYTICS_DAMAGE_STATS)
        .then((r) => r.data.data),
    staleTime: 30_000,
  });

  // Transform for charts
  const trendsData = (trends.data ?? []).map((t) => ({ ...t, date: shortDate(t.date) }));

  const bookingStatusData = bookings.data
    ? [
        { status: 'Requested', count: bookings.data.requested },
        { status: 'Confirmed', count: bookings.data.confirmed },
        { status: 'Waitlisted', count: bookings.data.waitlisted },
        { status: 'Completed', count: bookings.data.completed },
        { status: 'No-show', count: bookings.data.no_show },
        { status: 'Cancelled', count: bookings.data.cancelled },
      ]
    : [];

  const peakData = (peakHours.data ?? [])
    .slice()
    .sort((a, b) => b.booking_count - a.booking_count)
    .slice(0, 10)
    .map((h) => ({ hour: formatHour(h.hour), count: h.booking_count }));

  const utilData = (equipment.data ?? [])
    .slice()
    .sort((a, b) => b.utilization_rate - a.utilization_rate)
    .slice(0, 10)
    .map((e) => ({ name: e.name, utilization: parseFloat((e.utilization_rate * 100).toFixed(1)) }));

  return (
    <div className="space-y-6">
      {/* Header + period selector */}
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h1 className="text-xl font-semibold text-gray-900">Analytics</h1>
          <p className="text-sm text-gray-500">Usage statistics, trends, and performance</p>
        </div>
        <div className="flex gap-1 rounded-lg border border-gray-200 bg-white p-1">
          {PERIOD_OPTIONS.map(({ label, value }) => (
            <button
              key={value}
              onClick={() => setDays(value)}
              className={[
                'rounded-md px-3 py-1.5 text-sm font-medium transition-colors',
                days === value
                  ? 'bg-primary-600 text-white'
                  : 'text-gray-600 hover:bg-gray-100',
              ].join(' ')}
            >
              {label}
            </button>
          ))}
        </div>
      </div>

      {/* Usage Trends */}
      <LineChartWidget
        title="Usage Trends"
        data={trendsData}
        lines={[
          { key: 'bookings', label: 'Bookings', color: '#3b82f6' },
          { key: 'issues', label: 'Issues', color: '#10b981' },
          { key: 'returns', label: 'Returns', color: '#6b7280' },
        ]}
        xKey="date"
        isLoading={trends.isLoading}
        error={trends.error ? extractApiError(trends.error) : undefined}
      />

      {/* Booking Status + Peak Hours side by side */}
      <div className="grid grid-cols-1 gap-5 xl:grid-cols-2">
        <BarChartWidget
          title="Booking Status Distribution"
          data={bookingStatusData}
          bars={[{ key: 'count', label: 'Bookings', color: '#3b82f6' }]}
          xKey="status"
          isLoading={bookings.isLoading}
          error={bookings.error ? extractApiError(bookings.error) : undefined}
        />

        <BarChartWidget
          title="Peak Hours (Top 10)"
          data={peakData}
          bars={[{ key: 'count', label: 'Bookings', color: '#f59e0b' }]}
          xKey="hour"
          isLoading={peakHours.isLoading}
          error={peakHours.error ? extractApiError(peakHours.error) : undefined}
        />
      </div>

      {/* Equipment Utilisation */}
      <div className="space-y-4">
        <BarChartWidget
          title="Equipment Utilisation (Top 10)"
          data={utilData}
          bars={[{ key: 'utilization', label: 'Utilisation %', color: '#10b981' }]}
          xKey="name"
          isLoading={equipment.isLoading}
          error={equipment.error ? extractApiError(equipment.error) : undefined}
        />

        {/* Equipment performance table */}
        <Card padding="none">
          <CardHeader className="px-4 py-3 border-b border-gray-100">
            <CardTitle>Equipment Performance</CardTitle>
          </CardHeader>
          {equipment.isLoading ? (
            <div className="flex justify-center py-10"><Spinner /></div>
          ) : equipment.error ? (
            <ErrorState
              title="Could not load equipment data"
              message={extractApiError(equipment.error)}
              onRetry={() => void equipment.refetch()}
            />
          ) : !equipment.data?.length ? (
            <EmptyState title="No equipment data" />
          ) : (
            <Table>
              <TableHead>
                <tr>
                  <TableHeadCell>Name</TableHeadCell>
                  <TableHeadCell>Category</TableHeadCell>
                  <TableHeadCell>Bookings</TableHeadCell>
                  <TableHeadCell>Issues</TableHeadCell>
                  <TableHeadCell>Utilisation</TableHeadCell>
                </tr>
              </TableHead>
              <TableBody>
                {equipment.data.map((e) => (
                  <TableRow key={e.equipment_id}>
                    <TableCell className="font-medium text-gray-900">{e.name}</TableCell>
                    <TableCell>{e.category}</TableCell>
                    <TableCell>{e.total_bookings}</TableCell>
                    <TableCell>{e.total_issues}</TableCell>
                    <TableCell>
                      <div className="flex items-center gap-2">
                        <div className="h-1.5 w-20 rounded-full bg-gray-200">
                          <div
                            className="h-1.5 rounded-full bg-primary-500"
                            style={{ width: `${Math.min(e.utilization_rate * 100, 100)}%` }}
                          />
                        </div>
                        <span className="text-xs text-gray-500">
                          {(e.utilization_rate * 100).toFixed(0)}%
                        </span>
                      </div>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          )}
        </Card>
      </div>

      {/* Damage Stats */}
      {damage.isLoading ? (
        <div className="flex justify-center py-6"><Spinner /></div>
      ) : damage.error ? (
        <ErrorState
          title="Could not load damage data"
          message={extractApiError(damage.error)}
          onRetry={() => void damage.refetch()}
        />
      ) : damage.data ? (
        <div className="space-y-4">
          <div className="grid grid-cols-1 gap-4 sm:grid-cols-3">
            <StatCard label="Total Returns" value={damage.data.total_returns} />
            <StatCard
              label="Damaged Returns"
              value={damage.data.damaged_returns}
              variant={damage.data.damaged_returns > 0 ? 'warning' : 'default'}
            />
            <StatCard
              label="Damage Rate"
              value={`${(damage.data.damage_rate * 100).toFixed(1)}%`}
              variant={damage.data.damage_rate > 0.1 ? 'danger' : 'default'}
            />
          </div>

          {damage.data.recent_damage_reports.length > 0 && (
            <Card padding="none">
              <CardHeader className="px-4 py-3 border-b border-gray-100">
                <CardTitle>Recent Damage Reports</CardTitle>
              </CardHeader>
              <Table>
                <TableHead>
                  <tr>
                    <TableHeadCell>Transaction</TableHeadCell>
                    <TableHeadCell>Equipment</TableHeadCell>
                    <TableHeadCell>Report</TableHeadCell>
                    <TableHeadCell>Returned</TableHeadCell>
                  </tr>
                </TableHead>
                <TableBody>
                  {damage.data.recent_damage_reports.map((r) => (
                    <TableRow key={r.transaction_id}>
                      <TableCell className="text-xs text-gray-500">#{r.transaction_id}</TableCell>
                      <TableCell>#{r.equipment_id}</TableCell>
                      <TableCell className="max-w-xs truncate">{r.damage_report}</TableCell>
                      <TableCell className="text-xs text-gray-500">
                        {formatRelative(r.returned_at)}
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </Card>
          )}
        </div>
      ) : null}
    </div>
  );
}
