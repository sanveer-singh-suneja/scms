import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, waitFor, fireEvent } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { InventoryPage } from '@/pages/admin/InventoryPage';
import { apiClient } from '@/api/client';
import { ToastProvider } from '@/components/ui/Toast';
import type { Equipment } from '@/types/equipment';

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

const mockEquipment: Equipment[] = [
  {
    id: 1, name: 'Cricket Bat', category: 'Cricket', qr_code: 'QR001',
    status: 'AVAILABLE', condition: 'GOOD', location: 'Rack A', notes: null, added_at: '2024-01-01T00:00:00Z',
  },
  {
    id: 2, name: 'Football', category: 'Football', qr_code: 'QR002',
    status: 'MAINTENANCE', condition: 'FAIR', location: null, notes: 'Needs repair', added_at: '2024-02-01T00:00:00Z',
  },
];

const mockPage = {
  success: true,
  data: mockEquipment,
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

describe('InventoryPage', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it('renders equipment table from API data', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });

    render(<Wrapper><InventoryPage /></Wrapper>);

    await waitFor(() => {
      expect(screen.getByText('Cricket Bat')).toBeInTheDocument();
    });
    // "Football" appears in both the table row and the category filter dropdown
    expect(screen.getAllByText('Football').length).toBeGreaterThanOrEqual(1);
    expect(screen.getByText('QR001')).toBeInTheDocument();
  });

  it('sends category param when filter is changed', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });

    render(<Wrapper><InventoryPage /></Wrapper>);

    await waitFor(() => expect(screen.getByText('Cricket Bat')).toBeInTheDocument());

    const select = screen.getByRole('combobox', { name: /filter by category/i });
    fireEvent.change(select, { target: { value: 'Cricket' } });

    await waitFor(() => {
      const calls = (apiClient.get as ReturnType<typeof vi.fn>).mock.calls;
      const lastCall = calls[calls.length - 1];
      expect(lastCall[1]?.params?.category).toBe('Cricket');
    });
  });

  it('opens create dialog when Add Equipment is clicked', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });

    render(<Wrapper><InventoryPage /></Wrapper>);

    await waitFor(() => expect(screen.getByText('Cricket Bat')).toBeInTheDocument());

    fireEvent.click(screen.getByRole('button', { name: /add equipment/i }));

    await waitFor(() => {
      // Hint text only present inside the dialog form
      expect(screen.getByText(/unique identifier printed/i)).toBeInTheDocument();
    });
  });

  it('shows error state when API fails', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockRejectedValue(new Error('Server error'));

    render(<Wrapper><InventoryPage /></Wrapper>);

    await waitFor(() => {
      expect(screen.getByText(/could not load inventory/i)).toBeInTheDocument();
    });
    expect(screen.getByRole('button', { name: /try again/i })).toBeInTheDocument();
  });
});
