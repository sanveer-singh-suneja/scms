import { Link } from 'react-router-dom';
import { Button } from '@/components/ui/Button';

export function NotFoundPage() {
  return (
    <div className="flex min-h-[50vh] flex-col items-center justify-center gap-4 text-center">
      <p className="text-6xl font-bold text-gray-200">404</p>
      <h1 className="text-xl font-semibold text-gray-800">Page not found</h1>
      <p className="text-sm text-gray-500">The page you're looking for doesn't exist.</p>
      <Button asChild variant="secondary" size="sm">
        <Link to="/admin/dashboard">Back to Dashboard</Link>
      </Button>
    </div>
  );
}

export function UnauthorizedPage() {
  return (
    <div className="flex min-h-[50vh] flex-col items-center justify-center gap-4 text-center">
      <p className="text-6xl font-bold text-gray-200">403</p>
      <h1 className="text-xl font-semibold text-gray-800">Access denied</h1>
      <p className="text-sm text-gray-500">You don't have permission to view this page.</p>
      <Button asChild variant="secondary" size="sm">
        <Link to="/admin/dashboard">Back to Dashboard</Link>
      </Button>
    </div>
  );
}
