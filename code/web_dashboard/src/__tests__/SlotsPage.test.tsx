import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, waitFor, fireEvent } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { SlotsPage } from '@/pages/admin/SlotsPage';
import { apiClient } from '@/api/client';
import { ToastProvider } from '@/components/ui/Toast';
import type { Slot } from '@/types/slot';

vi.mock('@/api/client', () => ({
  TOKEN_KEY: 'scms_web_token',
  extractApiError: vi.fn((e: unknown) => (e instanceof Error ? e.message : 'An error occurred')),
  apiClient: {
    get: vi.fn(),
    post: vi.fn(),
    put: vi.fn(),
    patch: vi.fn(),
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

const mockSlots: Slot[] = [
  {
    id: 1, equipment_id: 1, equipment_name: 'Cricket Bat',
    date: '2024-06-01', start_time: '09:00:00', end_time: '10:00:00',
    capacity: 5, available_count: 3,
    booking_cutoff_at: '2024-05-31T22:00:00Z',
    allocation_run_at: null,
    status: 'OPEN', created_at: '2024-01-01T00:00:00Z',
  },
  {
    id: 2, equipment_id: 2, equipment_name: 'Football',
    date: '2024-06-02', start_time: '10:00:00', end_time: '11:00:00',
    capacity: 10, available_count: 0,
    booking_cutoff_at: '2024-06-01T22:00:00Z',
    allocation_run_at: '2024-06-01T23:00:00Z',
    status: 'FULL', created_at: '2024-01-01T00:00:00Z',
  },
];

const mockPage = {
  success: true,
  data: mockSlots,
  pagination: { page: 1, limit: 20, total: 2, totalPages: 1 },
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

describe('SlotsPage', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it('renders slot list from API data', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });

    render(<Wrapper><SlotsPage /></Wrapper>);

    await waitFor(() => {
      expect(screen.getByText('Cricket Bat')).toBeInTheDocument();
    });
    expect(screen.getByText('Football')).toBeInTheDocument();
    expect(screen.getByText('Open')).toBeInTheDocument();
    expect(screen.getByText('Full')).toBeInTheDocument();
  });

  it('opens create slot dialog when Create Slot is clicked', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });

    render(<Wrapper><SlotsPage /></Wrapper>);

    await waitFor(() => expect(screen.getByText('Cricket Bat')).toBeInTheDocument());

    fireEvent.click(screen.getByRole('button', { name: /create slot/i }));

    await waitFor(() => {
      // Booking Cutoff label only appears inside the dialog form
      expect(screen.getByText('Booking Cutoff')).toBeInTheDocument();
    });
  });

  it('shows deactivate confirmation when Close is clicked', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });

    render(<Wrapper><SlotsPage /></Wrapper>);

    await waitFor(() => expect(screen.getByText('Cricket Bat')).toBeInTheDocument());

    const closeButtons = screen.getAllByRole('button', { name: /close/i });
    fireEvent.click(closeButtons[0]);

    await waitFor(() => {
      expect(screen.getByText(/close slot\?/i)).toBeInTheDocument();
    });
  });

  it('shows allocation result dialog after run allocation', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });
    (apiClient.post as ReturnType<typeof vi.fn>).mockResolvedValue({
      data: {
        success: true,
        data: {
          slot_id: 1, allocation_run_at: '2024-06-01T00:00:00Z',
          confirmed_count: 17, waitlisted_count: 11, slot_status: 'PENDING_ALLOCATION',
        },
      },
    });

    render(<Wrapper><SlotsPage /></Wrapper>);

    await waitFor(() => expect(screen.getByText('Cricket Bat')).toBeInTheDocument());

    // Click the play (run allocation) button in the OPEN slot row
    const playButtons = screen.getAllByRole('button');
    const playBtn = playButtons.find((b) => b.title === 'Run batch allocation');
    expect(playBtn).toBeDefined();
    fireEvent.click(playBtn!);

    await waitFor(() => {
      expect(screen.getByText('Allocation Complete')).toBeInTheDocument();
      expect(screen.getByText('17')).toBeInTheDocument(); // confirmed_count (unique)
      expect(screen.getByText('11')).toBeInTheDocument(); // waitlisted_count (unique)
    });
  });

  it('shows error state when API fails', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockRejectedValue(new Error('Network error'));

    render(<Wrapper><SlotsPage /></Wrapper>);

    await waitFor(() => {
      expect(screen.getByText(/could not load slots/i)).toBeInTheDocument();
    });
    expect(screen.getByRole('button', { name: /try again/i })).toBeInTheDocument();
  });
});
