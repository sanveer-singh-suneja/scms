import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, waitFor } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import { AuthProvider } from '@/features/auth/AuthContext';
import { useAuth } from '@/hooks/useAuth';
import { TOKEN_KEY } from '@/api/client';

// Mock the API client module so axios.create() is never called for real
vi.mock('@/api/client', () => ({
  TOKEN_KEY: 'scms_web_token',
  extractApiError: vi.fn(() => 'An error occurred'),
  apiClient: {
    get: vi.fn().mockRejectedValue(new Error('no token')),
    post: vi.fn(),
    interceptors: {
      request: { use: vi.fn() },
      response: { use: vi.fn() },
    },
  },
}));

function AuthConsumer() {
  const { user, isAuthenticated } = useAuth();
  return (
    <div>
      <span data-testid="authenticated">{String(isAuthenticated)}</span>
      <span data-testid="user-name">{user?.name ?? 'none'}</span>
      <span data-testid="user-role">{user?.role ?? 'none'}</span>
    </div>
  );
}

function TestWrapper({ children }: { children: React.ReactNode }) {
  return (
    <MemoryRouter>
      <AuthProvider>{children}</AuthProvider>
    </MemoryRouter>
  );
}

describe('AuthContext', () => {
  beforeEach(() => {
    localStorage.clear();
    vi.clearAllMocks();
  });

  it('starts unauthenticated when no token in storage', async () => {
    render(
      <TestWrapper>
        <AuthConsumer />
      </TestWrapper>
    );

    await waitFor(() => {
      expect(screen.getByTestId('authenticated')).toHaveTextContent('false');
    });
    expect(screen.getByTestId('user-name')).toHaveTextContent('none');
  });

  it('TOKEN_KEY is stable', () => {
    expect(TOKEN_KEY).toBe('scms_web_token');
  });
});
