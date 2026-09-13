import { Outlet } from 'react-router-dom';

export function AuthLayout() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-primary-50 to-primary-100 flex items-center justify-center p-4">
      <div className="w-full max-w-sm">
        <div className="mb-8 text-center">
          <div className="inline-flex items-center justify-center h-12 w-12 rounded-xl bg-primary-600 text-white font-bold text-xl mb-3">
            S
          </div>
          <h1 className="text-2xl font-bold text-gray-900">SCMS</h1>
          <p className="text-sm text-gray-500 mt-1">Smart Sports Equipment Management</p>
        </div>
        <Outlet />
      </div>
    </div>
  );
}
