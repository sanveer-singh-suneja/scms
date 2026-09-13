import { cn } from '@/utils/cn';
import { ChevronUp, ChevronDown, ChevronsUpDown } from 'lucide-react';
import type { TableSort, SortDirection } from '@/types/common';

// ----- Base table primitives -----

export function Table({ className, ...props }: React.HTMLAttributes<HTMLTableElement>) {
  return (
    <div className="w-full overflow-x-auto">
      <table className={cn('w-full border-collapse text-sm', className)} {...props} />
    </div>
  );
}

export function TableHead({ className, ...props }: React.HTMLAttributes<HTMLTableSectionElement>) {
  return <thead className={cn('bg-gray-50', className)} {...props} />;
}

export function TableBody({ className, ...props }: React.HTMLAttributes<HTMLTableSectionElement>) {
  return <tbody className={cn('divide-y divide-gray-100', className)} {...props} />;
}

export function TableRow({ className, ...props }: React.HTMLAttributes<HTMLTableRowElement>) {
  return (
    <tr
      className={cn('transition-colors hover:bg-gray-50/60', className)}
      {...props}
    />
  );
}

export function TableCell({ className, ...props }: React.TdHTMLAttributes<HTMLTableCellElement>) {
  return (
    <td
      className={cn('whitespace-nowrap px-4 py-3 text-gray-700', className)}
      {...props}
    />
  );
}

interface ThProps extends React.ThHTMLAttributes<HTMLTableCellElement> {
  sortKey?: string;
  sort?: TableSort | null;
  onSort?: (key: string) => void;
}

export function TableHeadCell({ className, sortKey, sort, onSort, children, ...props }: ThProps) {
  const isSorted = sort?.key === sortKey;
  const direction: SortDirection | undefined = isSorted ? sort?.direction : undefined;

  return (
    <th
      className={cn(
        'px-4 py-3 text-left text-xs font-semibold uppercase tracking-wide text-gray-500',
        sortKey && 'cursor-pointer select-none hover:text-gray-700',
        className
      )}
      onClick={sortKey && onSort ? () => onSort(sortKey) : undefined}
      aria-sort={direction === 'asc' ? 'ascending' : direction === 'desc' ? 'descending' : undefined}
      {...props}
    >
      <span className="inline-flex items-center gap-1">
        {children}
        {sortKey && (
          <span className="text-gray-400">
            {direction === 'asc' ? (
              <ChevronUp className="h-3.5 w-3.5" />
            ) : direction === 'desc' ? (
              <ChevronDown className="h-3.5 w-3.5" />
            ) : (
              <ChevronsUpDown className="h-3.5 w-3.5" />
            )}
          </span>
        )}
      </span>
    </th>
  );
}
