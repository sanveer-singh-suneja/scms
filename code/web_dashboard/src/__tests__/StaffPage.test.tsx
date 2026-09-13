import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, waitFor, fireEvent } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { StaffPage } from '@/pages/admin/StaffPage';
import { apiClient } from '@/api/client';
import { ToastProvider } from '@/components/ui/Toast';
import type { StaffUser } from '@/types/staff';

vi.mock('@/api/client', () => ({
  TOKEN_KEY: 'scms_web_token',
  extractApiError: vi.fn((e: unknown) => (e instanceof Error ? e.message : 'An error occurred')),
  apiClient: {
    get: vi.fn(),
    post: vi.fn(),
    put: vi.fn(),
    patch: vi.fn(),
    interceptors: { request: { use: vi.fn() }, response: { use: vi.fn() } },
  },
}));

vi.mock('@/features/auth/AuthContext', async (importOriginal) => {
  const actual = await importOriginal<typeof import('@/features/auth/AuthContext')>();
  return { ...actual, extractApiError: vi.fn((e: unknown) => (e instanceof Error ? e.message : 'error')) };
});

const mockStaff: StaffUser[] = [
  { id: 1, name: 'Ravi Kumar', email: 'ravi@thapar.edu', role: 'STAFF', status: 'ACTIVE', created_at: '2024-01-15T10:00:00Z' },
  { id: 2, name: 'Priya Admin', email: 'priya@thapar.edu', role: 'ADMIN', status: 'ACTIVE', created_at: '2024-02-20T09:00:00Z' },
  { id: 3, name: 'Old Staff', email: 'old@thapar.edu', role: 'STAFF', status: 'INACTIVE', created_at: '2024-03-01T08:00:00Z' },
];

const mockPage = {
  success: true,
  data: mockStaff,
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

describe('StaffPage', () => {
  beforeEach(() => { vi.clearAllMocks(); });

  it('renders staff list with names, roles, and statuses', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });

    render(<Wrapper><StaffPage /></Wrapper>);

    await waitFor(() => {
      expect(screen.getByText('Ravi Kumar')).toBeInTheDocument();
    });
    expect(screen.getByText('Priya Admin')).toBeInTheDocument();
    expect(screen.getByText('Old Staff')).toBeInTheDocument();
    // STAFF and ADMIN badges
    expect(screen.getAllByText('STAFF').length).toBeGreaterThanOrEqual(1);
    expect(screen.getAllByText('ADMIN').length).toBeGreaterThanOrEqual(1);
    // Active and Inactive badges
    expect(screen.getAllByText('ACTIVE').length).toBeGreaterThanOrEqual(1);
    expect(screen.getByText('INACTIVE')).toBeInTheDocument();
  });

  it('opens create dialog and submits new staff', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });
    (apiClient.post as ReturnType<typeof vi.fn>).mockResolvedValue({
      data: { success: true, data: { id: 4, name: 'New Staff', email: 'new@thapar.edu', role: 'STAFF' } },
    });

    render(<Wrapper><StaffPage /></Wrapper>);

    await waitFor(() => expect(screen.getByText('Ravi Kumar')).toBeInTheDocument());

    fireEvent.click(screen.getByRole('button', { name: /add staff/i }));

    await waitFor(() => {
      // Dialog should show a unique field label
      expect(screen.getByLabelText(/full name/i)).toBeInTheDocument();
    });

    fireEvent.change(screen.getByLabelText(/full name/i), { target: { value: 'New Staff' } });
    fireEvent.change(screen.getByLabelText(/email/i), { target: { value: 'new@thapar.edu' } });
    fireEvent.change(screen.getByLabelText(/password/i), { target: { value: 'password123' } });

    fireEvent.click(screen.getByRole('button', { name: /^create$/i }));

    await waitFor(() => {
      expect(apiClient.post as ReturnType<typeof vi.fn>).toHaveBeenCalledWith(
        expect.stringContaining('/admin/staff'),
        expect.objectContaining({ name: 'New Staff', email: 'new@thapar.edu', password: 'password123' }),
      );
    });
  });

  it('validates required fields before submitting create form', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });

    render(<Wrapper><StaffPage /></Wrapper>);

    await waitFor(() => expect(screen.getByText('Ravi Kumar')).toBeInTheDocument());

    fireEvent.click(screen.getByRole('button', { name: /add staff/i }));
    await waitFor(() => expect(screen.getByLabelText(/full name/i)).toBeInTheDocument());

    // Submit without filling anything
    fireEvent.click(screen.getByRole('button', { name: /^create$/i }));

    await waitFor(() => {
      expect(screen.getByText(/name is required/i)).toBeInTheDocument();
    });
    // POST should NOT have been called
    expect(apiClient.post as ReturnType<typeof vi.fn>).not.toHaveBeenCalled();
  });

  it('opens edit dialog pre-filled with user data and submits update', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });
    (apiClient.put as ReturnType<typeof vi.fn>).mockResolvedValue({
      data: { success: true, data: { id: 1, name: 'Ravi Updated', email: 'ravi@thapar.edu', role: 'STAFF' } },
    });

    render(<Wrapper><StaffPage /></Wrapper>);

    await waitFor(() => expect(screen.getByText('Ravi Kumar')).toBeInTheDocument());

    // Click the edit button for Ravi Kumar (first pencil button)
    const editBtns = screen.getAllByRole('button', { name: /edit/i });
    fireEvent.click(editBtns[0]);

    await waitFor(() => {
      // Edit form should be pre-filled
      expect((screen.getByLabelText(/full name/i) as HTMLInputElement).value).toBe('Ravi Kumar');
    });

    // Change the name
    fireEvent.change(screen.getByLabelText(/full name/i), { target: { value: 'Ravi Updated' } });
    fireEvent.click(screen.getByRole('button', { name: /^save$/i }));

    await waitFor(() => {
      expect(apiClient.put as ReturnType<typeof vi.fn>).toHaveBeenCalledWith(
        expect.stringContaining('/admin/staff/1'),
        expect.objectContaining({ name: 'Ravi Updated' }),
      );
    });
  });

  it('shows deactivate confirm dialog and calls deactivate mutation', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockResolvedValue({ data: mockPage });
    (apiClient.patch as ReturnType<typeof vi.fn>).mockResolvedValue({
      data: { success: true, data: { id: 1, status: 'INACTIVE' } },
    });

    render(<Wrapper><StaffPage /></Wrapper>);

    await waitFor(() => expect(screen.getByText('Ravi Kumar')).toBeInTheDocument());

    const deactivateBtns = screen.getAllByRole('button', { name: /deactivate/i });
    fireEvent.click(deactivateBtns[0]);

    await waitFor(() => {
      expect(screen.getByText(/deactivate staff account\?/i)).toBeInTheDocument();
    });

    fireEvent.click(screen.getByRole('button', { name: /^deactivate$/i }));

    await waitFor(() => {
      expect(apiClient.patch as ReturnType<typeof vi.fn>).toHaveBeenCalledWith(
        expect.stringContaining('/admin/staff/'),
      );
    });
  });

  it('shows error state when API fails', async () => {
    (apiClient.get as ReturnType<typeof vi.fn>).mockRejectedValue(new Error('Network error'));

    render(<Wrapper><StaffPage /></Wrapper>);

    await waitFor(() => {
      expect(screen.getByText(/could not load staff/i)).toBeInTheDocument();
    });
    expect(screen.getByRole('button', { name: /try again/i })).toBeInTheDocument();
  });
});
