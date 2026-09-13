import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, waitFor, fireEvent } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { FairnessPage } from '@/pages/admin/FairnessPage';
import { apiClient } from '@/api/client';
import { ToastProvider } from '@/components/ui/Toast';
import type { FairnessConfig } from '@/types/analytics';

vi.mock('@/api/client', () => ({
  TOKEN_KEY: 'scms_web_token',
  extractApiError: vi.fn((e: unknown) => (e instanceof Error ? e.message : 'An error occurred')),
  apiClient: {
    get: vi.fn(),
    put: vi.fn(),
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

const mockConfig: FairnessConfig = {
  id: 1,
  daily_usage_cap: 2,
  recency_threshold_days: 2,
  recency_weight: 0.5,
  updated_at: '2024-01-15T10:00:00Z',
  updated_by: 7,
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

describe('FairnessPage', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it('renders config values from API', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({
      data: { success: true, data: mockConfig },
    });

    render(<Wrapper><FairnessPage /></Wrapper>);

    await waitFor(() => {
      // Both daily_usage_cap and recency_threshold_days are 2, so multiple matches expected
      expect(screen.getAllByDisplayValue('2').length).toBeGreaterThanOrEqual(2);
    });
    expect(screen.getByDisplayValue('0.5')).toBeInTheDocument(); // recency_weight
  });

  it('displays updated_by staff information', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({
      data: { success: true, data: mockConfig },
    });

    render(<Wrapper><FairnessPage /></Wrapper>);

    await waitFor(() => {
      expect(screen.getByText(/last updated by staff #7/i)).toBeInTheDocument();
    });
  });

  it('submits updated config on save', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({
      data: { success: true, data: mockConfig },
    });
    (apiClient.put as ReturnType<typeof vi.fn>).mockResolvedValue({
      data: { success: true, data: { ...mockConfig, daily_usage_cap: 3 } },
    });

    render(<Wrapper><FairnessPage /></Wrapper>);

    await waitFor(() => expect(screen.getAllByDisplayValue('2').length).toBeGreaterThanOrEqual(2));

    // Change the first input (daily_usage_cap) to 3
    const inputs = screen.getAllByDisplayValue('2') as HTMLInputElement[];
    fireEvent.change(inputs[0], { target: { value: '3' } });

    fireEvent.click(screen.getByRole('button', { name: /save configuration/i }));

    await waitFor(() => {
      expect(apiClient.put as ReturnType<typeof vi.fn>).toHaveBeenCalledWith(
        expect.stringContaining('fairness'),
        expect.objectContaining({ daily_usage_cap: 3 }),
      );
    });
  });

  it('shows error state when config fails to load', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockRejectedValue(new Error('Config not found'));

    render(<Wrapper><FairnessPage /></Wrapper>);

    await waitFor(() => {
      expect(screen.getByText(/could not load fairness config/i)).toBeInTheDocument();
    });
  });
});
