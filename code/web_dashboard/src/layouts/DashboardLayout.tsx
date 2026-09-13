import { useState } from 'react';
import { NavLink, Outlet, useNavigate } from 'react-router-dom';
import {
  LayoutDashboard,
  Package,
  Calendar,
  BookOpen,
  ArrowLeftRight,
  AlertTriangle,
  BarChart2,
  Sliders,
  Users,
  LogOut,
  Menu,
  X,
  ChevronDown,
} from 'lucide-react';
import { cn } from '@/utils/cn';
import { useAuth } from '@/hooks/useAuth';
import { Badge } from '@/components/ui/Badge';

interface NavItem {
  label: string;
  to: string;
  icon: React.ReactNode;
  roles?: ('ADMIN' | 'STAFF')[];
}

const NAV_ITEMS: NavItem[] = [
  {
    label: 'Dashboard',
    to: '/admin/dashboard',
    icon: <LayoutDashboard className="h-4 w-4" />,
    roles: ['ADMIN'],
  },
  {
    label: 'Inventory',
    to: '/admin/inventory',
    icon: <Package className="h-4 w-4" />,
    roles: ['ADMIN', 'STAFF'],
  },
  {
    label: 'Slots',
    to: '/admin/slots',
    icon: <Calendar className="h-4 w-4" />,
    roles: ['ADMIN'],
  },
  {
    label: 'Bookings',
    to: '/admin/bookings',
    icon: <BookOpen className="h-4 w-4" />,
    roles: ['ADMIN'],
  },
  {
    label: 'Transactions',
    to: '/admin/transactions',
    icon: <ArrowLeftRight className="h-4 w-4" />,
    roles: ['ADMIN'],
  },
  {
    label: 'Defaulters',
    to: '/admin/defaulters',
    icon: <AlertTriangle className="h-4 w-4" />,
    roles: ['ADMIN'],
  },
  {
    label: 'Analytics',
    to: '/admin/analytics',
    icon: <BarChart2 className="h-4 w-4" />,
    roles: ['ADMIN'],
  },
  {
    label: 'Fairness',
    to: '/admin/fairness',
    icon: <Sliders className="h-4 w-4" />,
    roles: ['ADMIN'],
  },
  {
    label: 'Staff',
    to: '/admin/staff',
    icon: <Users className="h-4 w-4" />,
    roles: ['ADMIN'],
  },
];

function SidebarNav({ onNavigate }: { onNavigate?: () => void }) {
  const { user } = useAuth();
  const visibleItems = NAV_ITEMS.filter(
    (item) => !item.roles || (user && item.roles.includes(user.role))
  );

  return (
    <nav aria-label="Main navigation">
      <ul className="space-y-0.5">
        {visibleItems.map((item) => (
          <li key={item.to}>
            <NavLink
              to={item.to}
              onClick={onNavigate}
              className={({ isActive }) =>
                cn(
                  'flex items-center gap-3 rounded-md px-3 py-2 text-sm font-medium transition-colors',
                  isActive
                    ? 'bg-primary-50 text-primary-700'
                    : 'text-gray-600 hover:bg-gray-100 hover:text-gray-900'
                )
              }
            >
              {item.icon}
              {item.label}
            </NavLink>
          </li>
        ))}
      </ul>
    </nav>
  );
}

function UserMenu() {
  const { user, logout } = useAuth();
  const navigate = useNavigate();
  const [open, setOpen] = useState(false);

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  return (
    <div className="relative">
      <button
        onClick={() => setOpen((v) => !v)}
        className="flex items-center gap-2 rounded-md px-2 py-1.5 text-sm text-gray-700 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-primary-500"
        aria-haspopup="menu"
        aria-expanded={open}
      >
        <div className="flex h-7 w-7 items-center justify-center rounded-full bg-primary-600 text-xs font-semibold text-white">
          {user?.name?.[0]?.toUpperCase() ?? '?'}
        </div>
        <span className="hidden sm:block font-medium">{user?.name}</span>
        <Badge variant={user?.role === 'ADMIN' ? 'danger' : 'info'} className="hidden sm:inline-flex">
          {user?.role}
        </Badge>
        <ChevronDown className="h-3.5 w-3.5 text-gray-400" />
      </button>

      {open && (
        <>
          <div className="fixed inset-0 z-10" onClick={() => setOpen(false)} />
          <div
            role="menu"
            className="absolute right-0 z-20 mt-1 w-44 rounded-lg border border-gray-200 bg-white py-1 shadow-lg"
          >
            <div className="border-b border-gray-100 px-3 py-2 text-xs text-gray-500">
              {user?.email}
            </div>
            <button
              role="menuitem"
              onClick={handleLogout}
              className="flex w-full items-center gap-2 px-3 py-2 text-sm text-red-600 hover:bg-red-50"
            >
              <LogOut className="h-4 w-4" />
              Sign out
            </button>
          </div>
        </>
      )}
    </div>
  );
}

export function DashboardLayout() {
  const [sidebarOpen, setSidebarOpen] = useState(false);

  return (
    <div className="flex h-screen overflow-hidden bg-gray-50">
      {/* Mobile overlay */}
      {sidebarOpen && (
        <div
          className="fixed inset-0 z-20 bg-black/40 lg:hidden"
          onClick={() => setSidebarOpen(false)}
        />
      )}

      {/* Sidebar */}
      <aside
        className={cn(
          'fixed inset-y-0 left-0 z-30 flex w-60 flex-col border-r border-gray-200 bg-white transition-transform lg:static lg:translate-x-0',
          sidebarOpen ? 'translate-x-0' : '-translate-x-full'
        )}
      >
        {/* Logo */}
        <div className="flex h-14 items-center gap-2.5 border-b border-gray-200 px-4">
          <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-primary-600 text-white text-sm font-bold">
            S
          </div>
          <span className="font-semibold text-gray-900">SCMS</span>
          <button
            className="ml-auto rounded p-1 text-gray-400 hover:bg-gray-100 lg:hidden"
            onClick={() => setSidebarOpen(false)}
            aria-label="Close sidebar"
          >
            <X className="h-4 w-4" />
          </button>
        </div>

        {/* Nav */}
        <div className="flex-1 overflow-y-auto px-3 py-4">
          <SidebarNav onNavigate={() => setSidebarOpen(false)} />
        </div>
      </aside>

      {/* Main */}
      <div className="flex flex-1 flex-col overflow-hidden">
        {/* Topbar */}
        <header className="flex h-14 shrink-0 items-center gap-3 border-b border-gray-200 bg-white px-4">
          <button
            className="rounded p-1.5 text-gray-500 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-primary-500 lg:hidden"
            onClick={() => setSidebarOpen(true)}
            aria-label="Open sidebar"
          >
            <Menu className="h-5 w-5" />
          </button>
          <div className="flex-1" />
          <UserMenu />
        </header>

        {/* Page content */}
        <main className="flex-1 overflow-y-auto p-6" id="main-content">
          <Outlet />
        </main>
      </div>
    </div>
  );
}
