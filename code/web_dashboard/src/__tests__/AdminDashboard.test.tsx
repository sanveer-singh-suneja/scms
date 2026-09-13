import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, waitFor } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { AdminDashboardPage } from '@/pages/admin/AdminDashboardPage';
import type { AnalyticsOverview } from '@/types/analytics';
import { apiClient } from '@/api/client';

vi.mock('@/api/client', () => ({
  TOKEN_KEY: 'scms_web_token',
  extractApiError: vi.fn((e: unknown) => (e instanceof Error ? e.message : 'An error occurred')),
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

const mockOverview: AnalyticsOverview = {
  total_equipment: 50,
  available_equipment: 30,
  total_bookings: 200,
  confirmed_bookings: 120,
  active_transactions: 15,
  overdue_transactions: 3,
  active_defaulters: 2,
};

const mockBookings = {
  total: 200, requested: 40, confirmed: 120,
  waitlisted: 10, cancelled: 20, no_show: 5, completed: 5,
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

describe('AdminDashboardPage', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it('shows spinner while data is loading', () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockReturnValue(new Promise(() => {}));

    render(
      <Wrapper>
        <AdminDashboardPage />
      </Wrapper>
    );

    expect(screen.getByText('Dashboard')).toBeInTheDocument();
    expect(screen.queryByText('50')).not.toBeInTheDocument();
  });

  it('renders KPI cards from API data', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockImplementation((url: string) => {
      if (url.includes('overview')) return Promise.resolve({ data: { success: true, data: mockOverview } });
      if (url.includes('usage-trends')) return Promise.resolve({ data: { success: true, data: [] } });
      if (url.includes('bookings')) return Promise.resolve({ data: { success: true, data: mockBookings } });
      return Promise.resolve({ data: { success: true, data: [] } });
    });

    render(
      <Wrapper>
        <AdminDashboardPage />
      </Wrapper>
    );

    await waitFor(() => {
      expect(screen.getByText('50')).toBeInTheDocument(); // total_equipment
    });

    expect(screen.getByText('30')).toBeInTheDocument();   // available_equipment
    expect(screen.getByText('15')).toBeInTheDocument();   // active_transactions
    expect(screen.getByText('3')).toBeInTheDocument();    // overdue_transactions
    expect(screen.getByText('2')).toBeInTheDocument();    // active_defaulters
  });

  it('shows error state when overview API fails', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockRejectedValue(new Error('Network error'));

    render(
      <Wrapper>
        <AdminDashboardPage />
      </Wrapper>
    );

    await waitFor(() => {
      expect(screen.getByText(/could not load overview/i)).toBeInTheDocument();
    });
  });

  it('shows try again button in error state', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockRejectedValue(new Error('fail'));

    render(
      <Wrapper>
        <AdminDashboardPage />
      </Wrapper>
    );

    await waitFor(() => {
      expect(screen.getByRole('button', { name: /try again/i })).toBeInTheDocument();
    });
  });

  it('renders quick action links after data loads', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockImplementation((url: string) => {
      if (url.includes('overview')) return Promise.resolve({ data: { success: true, data: mockOverview } });
      if (url.includes('usage-trends')) return Promise.resolve({ data: { success: true, data: [] } });
      if (url.includes('bookings')) return Promise.resolve({ data: { success: true, data: mockBookings } });
      return Promise.resolve({ data: { success: true, data: [] } });
    });

    render(
      <Wrapper>
        <AdminDashboardPage />
      </Wrapper>
    );

    await waitFor(() => {
      expect(screen.getByText('View Inventory')).toBeInTheDocument();
    });
    expect(screen.getByText('Manage Bookings')).toBeInTheDocument();
    expect(screen.getByText('Transactions')).toBeInTheDocument();
    expect(screen.getByText('Defaulters')).toBeInTheDocument();
  });
});
