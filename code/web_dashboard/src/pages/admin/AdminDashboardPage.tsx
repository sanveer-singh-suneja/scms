import { useQuery } from '@tanstack/react-query';
import {
  Package,
  CheckCircle,
  AlertTriangle,
  BookOpen,
  ArrowLeftRight,
  Clock,
  UserX,
  ArrowRight,
} from 'lucide-react';
import { Link } from 'react-router-dom';
import { apiClient } from '@/api/client';
import { ENDPOINTS } from '@/api/endpoints';
import type { AnalyticsOverview, BookingAnalytics, UsageTrend } from '@/types/analytics';
import type { ApiResponse } from '@/types/common';
import { StatCard, Card, CardHeader, CardTitle } from '@/components/ui/Card';
import { Spinner } from '@/components/ui/Spinner';
import { ErrorState } from '@/components/ui/EmptyState';
import { LineChartWidget } from '@/components/charts/LineChartWidget';
import { BarChartWidget } from '@/components/charts/BarChartWidget';
import { extractApiError } from '@/features/auth/AuthContext';
import { shortDate } from '@/utils/format';

export function AdminDashboardPage() {
  const overview = useQuery({
    queryKey: ['analytics', 'overview'],
    queryFn: () =>
      apiClient
        .get<ApiResponse<AnalyticsOverview>>(ENDPOINTS.ANALYTICS_OVERVIEW)
        .then((r) => r.data.data),
    staleTime: 30_000,
  });

  const trends = useQuery({
    queryKey: ['analytics', 'usage-trends'],
    queryFn: () =>
      apiClient
        .get<ApiResponse<UsageTrend[]>>(ENDPOINTS.ANALYTICS_USAGE_TRENDS, {
          params: { days: 7 },
        })
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

  const ov = overview.data;

  // Transform BookingAnalytics object into a single-row array for the bar chart.
  const bookingChartData = bookings.data
    ? [
        { status: 'Requested', count: bookings.data.requested },
        { status: 'Confirmed', count: bookings.data.confirmed },
        { status: 'Waitlisted', count: bookings.data.waitlisted },
        { status: 'Completed', count: bookings.data.completed },
        { status: 'No-show', count: bookings.data.no_show },
        { status: 'Cancelled', count: bookings.data.cancelled },
      ]
    : [];

  const trendsData = (trends.data ?? []).map((t) => ({
    ...t,
    date: shortDate(t.date),
  }));

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-xl font-semibold text-gray-900">Dashboard</h1>
        <p className="text-sm text-gray-500">System overview at a glance</p>
      </div>

      {/* KPI cards */}
      {overview.isLoading ? (
        <div className="flex justify-center py-10">
          <Spinner size="lg" />
        </div>
      ) : overview.error ? (
        <ErrorState
          title="Could not load overview"
          message={extractApiError(overview.error)}
          onRetry={() => void overview.refetch()}
        />
      ) : (
        <>
          <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-4">
            <StatCard
              label="Total Equipment"
              value={ov?.total_equipment ?? '–'}
              icon={<Package className="h-5 w-5" />}
              variant="default"
            />
            <StatCard
              label="Available"
              value={ov?.available_equipment ?? '–'}
              icon={<CheckCircle className="h-5 w-5" />}
              variant="success"
            />
            <Link to="/admin/transactions?status=ISSUED" className="block rounded-xl hover:ring-2 hover:ring-primary-300 transition-all">
              <StatCard
                label="Active Transactions"
                value={ov?.active_transactions ?? '–'}
                icon={<ArrowLeftRight className="h-5 w-5" />}
                variant="default"
              />
            </Link>
            <Link to="/admin/transactions?status=OVERDUE" className="block rounded-xl hover:ring-2 hover:ring-red-300 transition-all">
              <StatCard
                label="Overdue"
                value={ov?.overdue_transactions ?? '–'}
                icon={<AlertTriangle className="h-5 w-5" />}
                variant={ov && ov.overdue_transactions > 0 ? 'danger' : 'default'}
              />
            </Link>
          </div>

          <div className="grid grid-cols-1 gap-4 sm:grid-cols-3">
            <StatCard
              label="Total Bookings"
              value={ov?.total_bookings ?? '–'}
              icon={<BookOpen className="h-5 w-5" />}
              variant="default"
            />
            <Link to="/admin/bookings?status=CONFIRMED" className="block rounded-xl hover:ring-2 hover:ring-primary-300 transition-all">
              <StatCard
                label="Confirmed Bookings"
                value={ov?.confirmed_bookings ?? '–'}
                icon={<Clock className="h-5 w-5" />}
                variant="default"
              />
            </Link>
            <Link to="/admin/defaulters?status=ACTIVE" className="block rounded-xl hover:ring-2 hover:ring-red-300 transition-all">
              <StatCard
                label="Active Defaulters"
                value={ov?.active_defaulters ?? '–'}
                icon={<UserX className="h-5 w-5" />}
                variant={ov && ov.active_defaulters > 0 ? 'danger' : 'default'}
              />
            </Link>
          </div>
        </>
      )}

      {/* Charts */}
      <div className="grid grid-cols-1 gap-5 xl:grid-cols-2">
        <LineChartWidget
          title="7-Day Usage Trends"
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

        <BarChartWidget
          title="Booking Status Breakdown"
          data={bookingChartData}
          bars={[{ key: 'count', label: 'Count', color: '#3b82f6' }]}
          xKey="status"
          isLoading={bookings.isLoading}
          error={bookings.error ? extractApiError(bookings.error) : undefined}
        />
      </div>

      {/* Quick actions */}
      <Card>
        <CardHeader>
          <CardTitle>Quick Actions</CardTitle>
        </CardHeader>
        <div className="grid grid-cols-2 gap-3 sm:grid-cols-4 mt-2">
          {[
            { label: 'View Inventory', to: '/admin/inventory' },
            { label: 'Manage Bookings', to: '/admin/bookings' },
            { label: 'Transactions', to: '/admin/transactions' },
            { label: 'Defaulters', to: '/admin/defaulters' },
          ].map(({ label, to }) => (
            <Link
              key={to}
              to={to}
              className="flex items-center justify-between rounded-lg border border-gray-200 px-4 py-3 text-sm font-medium text-gray-700 transition-colors hover:bg-gray-50 hover:text-primary-600"
            >
              {label}
              <ArrowRight className="h-4 w-4 shrink-0 text-gray-400" />
            </Link>
          ))}
        </div>
      </Card>
    </div>
  );
}
