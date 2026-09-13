import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, waitFor, fireEvent } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { TransactionsPage } from '@/pages/admin/TransactionsPage';
import { apiClient } from '@/api/client';
import type { Transaction } from '@/types/transaction';

vi.mock('@/api/client', () => ({
  TOKEN_KEY: 'scms_web_token',
  extractApiError: vi.fn((e: unknown) => (e instanceof Error ? e.message : 'An error occurred')),
  apiClient: {
    get: vi.fn(),
    interceptors: { request: { use: vi.fn() }, response: { use: vi.fn() } },
  },
}));

vi.mock('@/features/auth/AuthContext', async (importOriginal) => {
  const actual = await importOriginal<typeof import('@/features/auth/AuthContext')>();
  return { ...actual, extractApiError: vi.fn((e: unknown) => (e instanceof Error ? e.message : 'error')) };
});

const mockTransactions: Transaction[] = [
  {
    id: 10, student_id: 1, equipment_id: 3, equipment_name: 'Cricket Bat',
    issued_by: 5, issued_at: '2024-06-01T09:00:00Z', due_at: '2024-06-01T11:00:00Z',
    status: 'ISSUED', returned_at: undefined, condition_on_return: undefined,
  },
  {
    id: 11, student_id: 2, equipment_id: 4, equipment_name: 'Football',
    issued_by: 5, issued_at: '2024-05-20T09:00:00Z', due_at: '2024-05-20T11:00:00Z',
    returned_at: '2024-05-20T10:30:00Z', status: 'RETURNED_DAMAGED',
    condition_on_return: 'DAMAGED', damage_report: 'Torn cover',
  },
];

const mockPage = {
  success: true,
  data: mockTransactions,
  pagination: { page: 1, limit: 25, total: 2, totalPages: 1 },
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

describe('TransactionsPage', () => {
  beforeEach(() => { vi.clearAllMocks(); });

  it('renders transaction list with equipment names', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });

    render(<Wrapper><TransactionsPage /></Wrapper>);

    await waitFor(() => {
      expect(screen.getByText('Cricket Bat')).toBeInTheDocument();
    });
    expect(screen.getByText('Football')).toBeInTheDocument();
  });

  it('renders correct status badges', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });

    render(<Wrapper><TransactionsPage /></Wrapper>);

    await waitFor(() => {
      expect(screen.getAllByText('ISSUED').length).toBeGreaterThanOrEqual(1);
    });
    // RETURNED_DAMAGED badge text — may span multiple elements or match via aria
    expect(screen.getByText(/returned.damaged/i)).toBeInTheDocument();
  });

  it('sends status filter to API', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });

    render(<Wrapper><TransactionsPage /></Wrapper>);

    await waitFor(() => expect(screen.getByText('Cricket Bat')).toBeInTheDocument());

    const select = screen.getByRole('combobox', { name: /filter by status/i });
    fireEvent.change(select, { target: { value: 'OVERDUE' } });

    await waitFor(() => {
      const calls = (apiClient.get as ReturnType<typeof vi.fn>).mock.calls;
      const last = calls[calls.length - 1];
      expect(last[1]?.params?.status).toBe('OVERDUE');
    });
  });

  it('shows transaction detail modal on row click', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });

    render(<Wrapper><TransactionsPage /></Wrapper>);

    await waitFor(() => expect(screen.getByText('Cricket Bat')).toBeInTheDocument());

    const rows = screen.getAllByRole('row');
    fireEvent.click(rows[1]);

    await waitFor(() => {
      expect(screen.getByText(/transaction #10/i)).toBeInTheDocument();
    });
  });

  it('shows error state when API fails', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockRejectedValue(new Error('Network error'));

    render(<Wrapper><TransactionsPage /></Wrapper>);

    await waitFor(() => {
      expect(screen.getByText(/could not load transactions/i)).toBeInTheDocument();
    });
    expect(screen.getByRole('button', { name: /try again/i })).toBeInTheDocument();
  });
});
