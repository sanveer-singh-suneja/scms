import React, { createContext, useCallback, useEffect, useState } from 'react';
import { apiClient, TOKEN_KEY, extractApiError } from '@/api/client';
import { ENDPOINTS } from '@/api/endpoints';
import type { AuthUser, LoginRequest, LoginResponse } from '@/types/auth';
import type { ApiResponse } from '@/types/common';

interface AuthContextType {
  user: AuthUser | null;
  isLoading: boolean;
  isAuthenticated: boolean;
  login: (credentials: LoginRequest) => Promise<void>;
  logout: () => void;
}

export const AuthContext = createContext<AuthContextType | null>(null);

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<AuthUser | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  const logout = useCallback(() => {
    localStorage.removeItem(TOKEN_KEY);
    setUser(null);
  }, []);

  // Restore session on mount
  useEffect(() => {
    const token = localStorage.getItem(TOKEN_KEY);
    if (!token) {
      setIsLoading(false);
      return;
    }

    apiClient
      .get<ApiResponse<AuthUser>>(ENDPOINTS.AUTH_ME_STAFF)
      .then((res) => setUser(res.data.data))
      .catch(() => {
        localStorage.removeItem(TOKEN_KEY);
      })
      .finally(() => setIsLoading(false));
  }, []);

  const login = useCallback(async (credentials: LoginRequest) => {
    const res = await apiClient.post<ApiResponse<LoginResponse>>(
      ENDPOINTS.STAFF_LOGIN,
      credentials
    );
    const { token, user: authUser } = res.data.data;
    localStorage.setItem(TOKEN_KEY, token);
    setUser(authUser);
  }, []);

  return (
    <AuthContext.Provider
      value={{ user, isLoading, isAuthenticated: !!user, login, logout }}
    >
      {children}
    </AuthContext.Provider>
  );
}

// Re-export extractApiError so callers don't need a separate import
export { extractApiError };
