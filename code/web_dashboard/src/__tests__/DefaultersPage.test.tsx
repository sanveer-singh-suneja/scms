import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, waitFor, fireEvent } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { DefaultersPage } from '@/pages/admin/DefaultersPage';
import { apiClient } from '@/api/client';
import { ToastProvider } from '@/components/ui/Toast';
import type { Defaulter } from '@/types/transaction';

vi.mock('@/api/client', () => ({
  TOKEN_KEY: 'scms_web_token',
  extractApiError: vi.fn((e: unknown) => (e instanceof Error ? e.message : 'An error occurred')),
  apiClient: {
    get: vi.fn(),
    put: vi.fn(),
    interceptors: { request: { use: vi.fn() }, response: { use: vi.fn() } },
  },
}));

vi.mock('@/features/auth/AuthContext', async (importOriginal) => {
  const actual = await importOriginal<typeof import('@/features/auth/AuthContext')>();
  return { ...actual, extractApiError: vi.fn((e: unknown) => (e instanceof Error ? e.message : 'error')) };
});

const mockDefaulters: Defaulter[] = [
  { id: 1, student_id: 10, student_name: 'Amit Kumar', transaction_id: 5, overdue_days: 3, status: 'ACTIVE', detected_at: '2024-06-01T00:00:00Z' },
  { id: 2, student_id: 11, student_name: 'Priya Singh', transaction_id: 6, overdue_days: 12, status: 'NOTIFIED', detected_at: '2024-05-20T00:00:00Z' },
  { id: 3, student_id: 12, student_name: 'Ravi Sharma', transaction_id: 7, overdue_days: 5, status: 'RESOLVED', detected_at: '2024-05-10T00:00:00Z', resolved_at: '2024-05-15T10:00:00Z' },
];

const mockPage = {
  success: true,
  data: mockDefaulters,
  pagination: { page: 1, limit: 25, total: 3, totalPages: 1 },
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

describe('DefaultersPage', () => {
  beforeEach(() => { vi.clearAllMocks(); });

  it('renders active defaulters with student names and overdue days', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });

    render(<Wrapper><DefaultersPage /></Wrapper>);

    await waitFor(() => {
      expect(screen.getByText('Amit Kumar')).toBeInTheDocument();
    });
    expect(screen.getByText('Priya Singh')).toBeInTheDocument();
    expect(screen.getByText('3d')).toBeInTheDocument();
    expect(screen.getByText('12d')).toBeInTheDocument();
  });

  it('sends status filter to API', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });

    render(<Wrapper><DefaultersPage /></Wrapper>);

    await waitFor(() => expect(screen.getByText('Amit Kumar')).toBeInTheDocument());

    const select = screen.getByRole('combobox', { name: /filter by status/i });
    fireEvent.change(select, { target: { value: 'ACTIVE' } });

    await waitFor(() => {
      const calls = (apiClient.get as ReturnType<typeof vi.fn>).mock.calls;
      const last = calls[calls.length - 1];
      expect(last[1]?.params?.status).toBe('ACTIVE');
    });
  });

  it('shows Resolve button only for non-RESOLVED defaulters', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });

    render(<Wrapper><DefaultersPage /></Wrapper>);

    await waitFor(() => expect(screen.getByText('Amit Kumar')).toBeInTheDocument());

    const resolveButtons = screen.getAllByRole('button', { name: /resolve/i });
    // ACTIVE and NOTIFIED have Resolve; RESOLVED does not
    expect(resolveButtons).toHaveLength(2);
  });

  it('opens confirm dialog and calls resolve mutation', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });
    (apiClient.put as ReturnType<typeof vi.fn>).mockResolvedValue({
      data: { success: true, data: { id: 1, status: 'RESOLVED', resolved_at: '2024-06-05T10:00:00Z' } },
    });

    render(<Wrapper><DefaultersPage /></Wrapper>);

    await waitFor(() => expect(screen.getByText('Amit Kumar')).toBeInTheDocument());

    fireEvent.click(screen.getAllByRole('button', { name: /resolve/i })[0]);

    await waitFor(() => {
      expect(screen.getByText(/resolve defaulter\?/i)).toBeInTheDocument();
    });

    fireEvent.click(screen.getByRole('button', { name: /^resolve$/i }));

    await waitFor(() => {
      expect(apiClient.put as ReturnType<typeof vi.fn>).toHaveBeenCalledWith(
        expect.stringContaining('resolve'),
      );
    });
  });

  it('shows error state when API fails', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockRejectedValue(new Error('Server error'));

    render(<Wrapper><DefaultersPage /></Wrapper>);

    await waitFor(() => {
      expect(screen.getByText(/could not load defaulters/i)).toBeInTheDocument();
    });
    expect(screen.getByRole('button', { name: /try again/i })).toBeInTheDocument();
  });
});
