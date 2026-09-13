import { describe, it, expect, vi } from 'vitest';
import { render, screen } from '@testing-library/react';
import { MemoryRouter, Routes, Route } from 'react-router-dom';
import { AuthContext } from '@/features/auth/AuthContext';
import { ProtectedRoute } from '@/features/auth/ProtectedRoute';
import type { AuthUser } from '@/types/auth';

function makeAuthContext(user: AuthUser | null, isLoading = false) {
  return {
    user,
    isLoading,
    isAuthenticated: !!user,
    login: vi.fn(),
    logout: vi.fn(),
  };
}

function render_with_route(
  authCtx: ReturnType<typeof makeAuthContext>,
  initialPath: string
) {
  return render(
    <AuthContext.Provider value={authCtx}>
      <MemoryRouter initialEntries={[initialPath]}>
        <Routes>
          <Route path="/login" element={<div>Login Page</div>} />
          <Route element={<ProtectedRoute />}>
            <Route path="/dashboard" element={<div>Protected Content</div>} />
            <Route path="/admin" element={<ProtectedRoute requiredRole="ADMIN" />}>
              <Route index element={<div>Admin Only</div>} />
            </Route>
          </Route>
        </Routes>
      </MemoryRouter>
    </AuthContext.Provider>
  );
}

describe('ProtectedRoute', () => {
  it('shows spinner while loading', () => {
    const ctx = makeAuthContext(null, true);
    render_with_route(ctx, '/dashboard');
    expect(screen.getByRole('status')).toBeInTheDocument();
  });

  it('redirects to /login when unauthenticated', () => {
    const ctx = makeAuthContext(null);
    render_with_route(ctx, '/dashboard');
    expect(screen.getByText('Login Page')).toBeInTheDocument();
  });

  it('renders protected content when authenticated', () => {
    const user: AuthUser = { id: 1, name: 'Alice', email: 'a@test.com', role: 'ADMIN' };
    const ctx = makeAuthContext(user);
    render_with_route(ctx, '/dashboard');
    expect(screen.getByText('Protected Content')).toBeInTheDocument();
  });

  it('redirects to /unauthorized when wrong role', () => {
    const user: AuthUser = { id: 2, name: 'Bob', email: 'b@test.com', role: 'STAFF' };
    render(
      <AuthContext.Provider value={makeAuthContext(user)}>
        <MemoryRouter initialEntries={['/admin-only']}>
          <Routes>
            <Route path="/unauthorized" element={<div>Unauthorized</div>} />
            <Route element={<ProtectedRoute requiredRole="ADMIN" />}>
              <Route path="/admin-only" element={<div>Admin Area</div>} />
            </Route>
          </Routes>
        </MemoryRouter>
      </AuthContext.Provider>
    );
    expect(screen.getByText('Unauthorized')).toBeInTheDocument();
  });
});
