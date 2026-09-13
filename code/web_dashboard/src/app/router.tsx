import { createBrowserRouter, Navigate } from 'react-router-dom';
import { AuthLayout } from '@/layouts/AuthLayout';
import { DashboardLayout } from '@/layouts/DashboardLayout';
import { ProtectedRoute } from '@/features/auth/ProtectedRoute';
import { LoginPage } from '@/pages/LoginPage';
import { AdminDashboardPage } from '@/pages/admin/AdminDashboardPage';
import { InventoryPage } from '@/pages/admin/InventoryPage';
import { SlotsPage } from '@/pages/admin/SlotsPage';
import { BookingsPage } from '@/pages/admin/BookingsPage';
import { TransactionsPage } from '@/pages/admin/TransactionsPage';
import { DefaultersPage } from '@/pages/admin/DefaultersPage';
import { AnalyticsPage } from '@/pages/admin/AnalyticsPage';
import { FairnessPage } from '@/pages/admin/FairnessPage';
import { StaffPage } from '@/pages/admin/StaffPage';
import { NotFoundPage, UnauthorizedPage } from '@/pages/NotFoundPage';

export const router = createBrowserRouter([
  // Public — auth pages
  {
    element: <AuthLayout />,
    children: [
      { path: '/login', element: <LoginPage /> },
    ],
  },

  // Protected — dashboard shell
  {
    element: <ProtectedRoute />,
    children: [
      {
        element: <DashboardLayout />,
        children: [
          // Default redirect
          { path: '/', element: <Navigate to="/admin/dashboard" replace /> },

          // Admin routes (also accessible by STAFF where permitted via sidebar visibility)
          { path: '/admin/dashboard', element: <AdminDashboardPage /> },
          { path: '/admin/inventory', element: <InventoryPage /> },
          { path: '/admin/slots', element: <SlotsPage /> },
          { path: '/admin/bookings', element: <BookingsPage /> },
          { path: '/admin/transactions', element: <TransactionsPage /> },
          { path: '/admin/defaulters', element: <DefaultersPage /> },
          { path: '/admin/analytics', element: <AnalyticsPage /> },
          { path: '/admin/fairness', element: <FairnessPage /> },
          { path: '/admin/staff', element: <StaffPage /> },

          // Error pages inside the dashboard shell
          { path: '/unauthorized', element: <UnauthorizedPage /> },
          { path: '*', element: <NotFoundPage /> },
        ],
      },
    ],
  },
]);
