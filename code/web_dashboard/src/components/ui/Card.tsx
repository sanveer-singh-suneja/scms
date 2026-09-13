import { cn } from '@/utils/cn';

interface CardProps extends React.HTMLAttributes<HTMLDivElement> {
  padding?: 'none' | 'sm' | 'md' | 'lg';
}

const paddings = {
  none: '',
  sm: 'p-4',
  md: 'p-6',
  lg: 'p-8',
};

export function Card({ padding = 'md', className, children, ...props }: CardProps) {
  return (
    <div
      className={cn(
        'rounded-lg border border-gray-200 bg-white shadow-card',
        paddings[padding],
        className
      )}
      {...props}
    >
      {children}
    </div>
  );
}

export function CardHeader({ className, children, ...props }: React.HTMLAttributes<HTMLDivElement>) {
  return (
    <div className={cn('mb-4 flex items-center justify-between', className)} {...props}>
      {children}
    </div>
  );
}

export function CardTitle({ className, children, ...props }: React.HTMLAttributes<HTMLHeadingElement>) {
  return (
    <h3 className={cn('text-base font-semibold text-gray-900', className)} {...props}>
      {children}
    </h3>
  );
}

interface StatCardProps {
  label: string;
  value: string | number;
  icon?: React.ReactNode;
  variant?: 'default' | 'success' | 'warning' | 'danger';
  className?: string;
}

const statVariants = {
  default: 'text-gray-900',
  success: 'text-green-700',
  warning: 'text-amber-700',
  danger: 'text-red-700',
};

export function StatCard({ label, value, icon, variant = 'default', className }: StatCardProps) {
  return (
    <Card className={cn('flex items-start gap-4', className)} padding="md">
      {icon && (
        <div className="rounded-lg bg-gray-100 p-2.5 text-gray-600">{icon}</div>
      )}
      <div>
        <p className="text-sm text-gray-500">{label}</p>
        <p className={cn('text-2xl font-bold', statVariants[variant])}>{value}</p>
      </div>
    </Card>
  );
}
