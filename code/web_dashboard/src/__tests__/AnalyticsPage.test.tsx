import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, waitFor } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { AnalyticsPage } from '@/pages/admin/AnalyticsPage';
import type { UsageTrend, BookingAnalytics, EquipmentAnalytics, PeakHour, DamageStats } from '@/types/analytics';
import { apiClient } from '@/api/client';

vi.mock('@/api/client', () => ({
  TOKEN_KEY: 'scms_web_token',
  extractApiError: vi.fn((e: unknown) => (e instanceof Error ? e.message : 'error')),
  apiClient: {
    get: vi.fn(),
    interceptors: {
      request: { use: vi.fn() },
      response: { use: vi.fn() },
    },
  },
}));

vi.mock('@/features/auth/AuthContext', async (importOriginal) => {
  const actual = await importOriginal<typeof import('@/features/auth/AuthContext')>();
  return {
    ...actual,
    extractApiError: vi.fn((e: unknown) => (e instanceof Error ? e.message : 'error')),
  };
});

const mockTrends: UsageTrend[] = [
  { date: '2024-09-06', bookings: 10, issues: 8, returns: 7 },
  { date: '2024-09-07', bookings: 12, issues: 9, returns: 10 },
];

const mockBookings: BookingAnalytics = {
  total: 200, requested: 40, confirmed: 100,
  waitlisted: 20, cancelled: 25, no_show: 5, completed: 10,
};

const mockEquipment: EquipmentAnalytics[] = [
  { equipment_id: 1, name: 'Bat', category: 'Cricket', total_bookings: 50, total_issues: 40, utilization_rate: 0.8 },
  { equipment_id: 2, name: 'Ball', category: 'Cricket', total_bookings: 80, total_issues: 70, utilization_rate: 0.9 },
];

const mockPeakHours: PeakHour[] = [
  { hour: 9, booking_count: 30 },
  { hour: 16, booking_count: 45 },
];

const mockDamage: DamageStats = {
  total_returns: 100,
  damaged_returns: 5,
  damage_rate: 0.05,
  recent_damage_reports: [
    { transaction_id: 1, equipment_id: 1, damage_report: 'Cracked grip', returned_at: '2024-09-10T10:00:00Z' },
  ],
};

function makeClient() {
  return new QueryClient({ defaultOptions: { queries: { retry: false } } });
}

function Wrapper({ children }: { children: React.ReactNode }) {
  return (
    <QueryClientProvider client={makeClient()}>
      <MemoryRouter>{children}</MemoryRouter>
    </QueryClientProvider>
  );
}

function setupAllMocks() {
  (apiClient.get as ReturnType<typeof vi.fn>).mockImplementation((url: string) => {
    if (url.includes('usage-trends')) return Promise.resolve({ data: { success: true, data: mockTrends } });
    if (url.includes('bookings')) return Promise.resolve({ data: { success: true, data: mockBookings } });
    if (url.includes('equipment')) return Promise.resolve({ data: { success: true, data: mockEquipment } });
    if (url.includes('peak-hours')) return Promise.resolve({ data: { success: true, data: mockPeakHours } });
    if (url.includes('damage-stats')) return Promise.resolve({ data: { success: true, data: mockDamage } });
    return Promise.resolve({ data: { success: true, data: [] } });
  });
}

describe('AnalyticsPage', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it('renders the page heading', () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockReturnValue(new Promise(() => {}));

    render(
      <Wrapper>
        <AnalyticsPage />
      </Wrapper>
    );

    expect(screen.getByText('Analytics')).toBeInTheDocument();
  });

  it('renders period selector buttons', () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockReturnValue(new Promise(() => {}));

    render(
      <Wrapper>
        <AnalyticsPage />
      </Wrapper>
    );

    expect(screen.getByRole('button', { name: '7 days' })).toBeInTheDocument();
    expect(screen.getByRole('button', { name: '14 days' })).toBeInTheDocument();
    expect(screen.getByRole('button', { name: '30 days' })).toBeInTheDocument();
  });

  it('renders chart titles after data loads', async () => {
    setupAllMocks();

    render(
      <Wrapper>
        <AnalyticsPage />
      </Wrapper>
    );

    await waitFor(() => {
      expect(screen.getByText('Usage Trends')).toBeInTheDocument();
    });
    expect(screen.getByText('Booking Status Distribution')).toBeInTheDocument();
    expect(screen.getByText('Peak Hours (Top 10)')).toBeInTheDocument();
    expect(screen.getByText('Equipment Performance')).toBeInTheDocument();
  });

  it('shows damage stat labels after data loads', async () => {
    setupAllMocks();

    render(
      <Wrapper>
        <AnalyticsPage />
      </Wrapper>
    );

    await waitFor(() => {
      expect(screen.getByText('Total Returns')).toBeInTheDocument();
    });
    expect(screen.getByText('Damaged Returns')).toBeInTheDocument();
    expect(screen.getByText('Damage Rate')).toBeInTheDocument();
  });

  it('shows error state when APIs fail', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockRejectedValue(new Error('Server error'));

    render(
      <Wrapper>
        <AnalyticsPage />
      </Wrapper>
    );

    // Charts render "Chart unavailable" via ErrorState when error prop is set.
    await waitFor(() => {
      expect(screen.getAllByText(/chart unavailable/i).length).toBeGreaterThan(0);
    });
  });
});
