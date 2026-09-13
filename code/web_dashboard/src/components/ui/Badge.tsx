import { cn } from '@/utils/cn';

type BadgeVariant =
  | 'default'
  | 'success'
  | 'warning'
  | 'danger'
  | 'info'
  | 'neutral';

interface BadgeProps {
  variant?: BadgeVariant;
  children: React.ReactNode;
  className?: string;
}

const variants: Record<BadgeVariant, string> = {
  default: 'bg-gray-100 text-gray-800',
  success: 'bg-green-100 text-green-800',
  warning: 'bg-amber-100 text-amber-800',
  danger: 'bg-red-100 text-red-800',
  info: 'bg-blue-100 text-blue-800',
  neutral: 'bg-gray-200 text-gray-600',
};

export function Badge({ variant = 'default', children, className }: BadgeProps) {
  return (
    <span
      className={cn(
        'inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium',
        variants[variant],
        className
      )}
    >
      {children}
    </span>
  );
}

// Domain-specific badge helpers
type EquipmentStatus = 'AVAILABLE' | 'BOOKED' | 'ISSUED' | 'MAINTENANCE' | 'RETIRED';
type BookingStatus = 'REQUESTED' | 'CONFIRMED' | 'WAITLISTED' | 'CANCELLED' | 'NO_SHOW' | 'COMPLETED';
type TransactionStatus = 'ISSUED' | 'RETURNED' | 'RETURNED_DAMAGED' | 'OVERDUE';
type DefaulterStatus = 'ACTIVE' | 'NOTIFIED' | 'RESOLVED';

export function EquipmentStatusBadge({ status }: { status: EquipmentStatus }) {
  const map: Record<EquipmentStatus, BadgeVariant> = {
    AVAILABLE: 'success',
    BOOKED: 'info',
    ISSUED: 'warning',
    MAINTENANCE: 'danger',
    RETIRED: 'neutral',
  };
  return <Badge variant={map[status]}>{status}</Badge>;
}

export function BookingStatusBadge({ status }: { status: BookingStatus }) {
  const map: Record<BookingStatus, BadgeVariant> = {
    REQUESTED: 'info',
    CONFIRMED: 'success',
    WAITLISTED: 'warning',
    CANCELLED: 'neutral',
    NO_SHOW: 'danger',
    COMPLETED: 'default',
  };
  return <Badge variant={map[status]}>{status}</Badge>;
}

export function TransactionStatusBadge({ status }: { status: TransactionStatus }) {
  const map: Record<TransactionStatus, BadgeVariant> = {
    ISSUED: 'info',
    RETURNED: 'success',
    RETURNED_DAMAGED: 'warning',
    OVERDUE: 'danger',
  };
  return <Badge variant={map[status]}>{status.replace('_', ' ')}</Badge>;
}

export function DefaulterStatusBadge({ status }: { status: DefaulterStatus }) {
  const map: Record<DefaulterStatus, BadgeVariant> = {
    ACTIVE: 'danger',
    NOTIFIED: 'warning',
    RESOLVED: 'success',
  };
  return <Badge variant={map[status]}>{status}</Badge>;
}

type SlotStatus = 'OPEN' | 'PENDING_ALLOCATION' | 'FULL' | 'CLOSED';

export function SlotStatusBadge({ status }: { status: SlotStatus }) {
  const map: Record<SlotStatus, BadgeVariant> = {
    OPEN: 'success',
    PENDING_ALLOCATION: 'warning',
    FULL: 'danger',
    CLOSED: 'neutral',
  };
  const label: Record<SlotStatus, string> = {
    OPEN: 'Open',
    PENDING_ALLOCATION: 'Pending Alloc.',
    FULL: 'Full',
    CLOSED: 'Closed',
  };
  return <Badge variant={map[status]}>{label[status]}</Badge>;
}
