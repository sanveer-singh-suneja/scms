import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, waitFor, fireEvent } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { BookingsPage } from '@/pages/admin/BookingsPage';
import { apiClient } from '@/api/client';
import { ToastProvider } from '@/components/ui/Toast';
import type { Booking } from '@/types/booking';

vi.mock('@/api/client', () => ({
  TOKEN_KEY: 'scms_web_token',
  extractApiError: vi.fn((e: unknown) => (e instanceof Error ? e.message : 'An error occurred')),
  apiClient: {
    get: vi.fn(),
    delete: vi.fn(),
    interceptors: { request: { use: vi.fn() }, response: { use: vi.fn() } },
  },
}));

vi.mock('@/features/auth/AuthContext', async (importOriginal) => {
  const actual = await importOriginal<typeof import('@/features/auth/AuthContext')>();
  return { ...actual, extractApiError: vi.fn((e: unknown) => (e instanceof Error ? e.message : 'error')) };
});

const mockBookings: Booking[] = [
  { id: 1, student_id: 10, equipment_id: 5, slot_id: 3, status: 'CONFIRMED', queue_position: undefined, priority_score: 0.1234, created_at: '2024-06-01T10:00:00Z', allocated_at: '2024-06-01T12:00:00Z' },
  { id: 2, student_id: 11, equipment_id: 6, slot_id: 4, status: 'WAITLISTED', queue_position: 2, priority_score: 0.5, created_at: '2024-06-02T10:00:00Z' },
];

const mockPage = {
  success: true,
  data: mockBookings,
  pagination: { page: 1, limit: 25, total: 2, totalPages: 1 },
};

function makeClient() {
  return new QueryClient({ defaultOptions: { queries: { retry: false } } });
}

function Wrapper({ children }: { children: React.ReactNode }) {
  return (
    <QueryClientProvider client={makeClient()}>
      <ToastProvider>
        <MemoryRouter>{children}</MemoryRouter>
      </ToastProvider>
    </QueryClientProvider>
  );
}

describe('BookingsPage', () => {
  beforeEach(() => { vi.clearAllMocks(); });

  it('renders booking list from API', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });

    render(<Wrapper><BookingsPage /></Wrapper>);

    await waitFor(() => {
      expect(screen.getByText('#1')).toBeInTheDocument();
    });
    expect(screen.getByText('#2')).toBeInTheDocument();
    // CONFIRMED appears in both the badge and the filter dropdown
    expect(screen.getAllByText('CONFIRMED').length).toBeGreaterThanOrEqual(1);
    expect(screen.getAllByText('WAITLISTED').length).toBeGreaterThanOrEqual(1);
  });

  it('sends status filter to API when changed', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });

    render(<Wrapper><BookingsPage /></Wrapper>);

    await waitFor(() => expect(screen.getByText('#1')).toBeInTheDocument());

    const select = screen.getByRole('combobox', { name: /filter by status/i });
    fireEvent.change(select, { target: { value: 'CONFIRMED' } });

    await waitFor(() => {
      const calls = (apiClient.get as ReturnType<typeof vi.fn>).mock.calls;
      const lastCall = calls[calls.length - 1];
      expect(lastCall[1]?.params?.status).toBe('CONFIRMED');
    });
  });

  it('shows cancel button for cancellable bookings and opens confirm dialog', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });

    render(<Wrapper><BookingsPage /></Wrapper>);

    await waitFor(() => expect(screen.getByText('#1')).toBeInTheDocument());

    // Both CONFIRMED and WAITLISTED are cancellable
    const cancelBtns = screen.getAllByRole('button', { name: /cancel/i });
    expect(cancelBtns.length).toBeGreaterThanOrEqual(2);

    fireEvent.click(cancelBtns[0]);
    await waitFor(() => {
      expect(screen.getByText(/cancel booking\?/i)).toBeInTheDocument();
    });
  });

  it('shows error state when API fails', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockRejectedValue(new Error('Server error'));

    render(<Wrapper><BookingsPage /></Wrapper>);

    await waitFor(() => {
      expect(screen.getByText(/could not load bookings/i)).toBeInTheDocument();
    });
    expect(screen.getByRole('button', { name: /try again/i })).toBeInTheDocument();
  });

  it('shows booking detail modal on row click', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });

    render(<Wrapper><BookingsPage /></Wrapper>);

    await waitFor(() => expect(screen.getByText('#1')).toBeInTheDocument());

    // Click the first row
    const rows = screen.getAllByRole('row');
    fireEvent.click(rows[1]); // row[0] is the header

    await waitFor(() => {
      expect(screen.getByText(/booking #1/i)).toBeInTheDocument();
    });
  });
});
