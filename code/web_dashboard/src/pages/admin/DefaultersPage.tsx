import { useState } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { useSearchParams } from 'react-router-dom';
import { apiClient } from '@/api/client';
import { ENDPOINTS } from '@/api/endpoints';
import type { Defaulter, DefaulterStatus } from '@/types/transaction';
import type { PaginatedResponse } from '@/types/common';
import { Card } from '@/components/ui/Card';
import { DefaulterStatusBadge } from '@/components/ui/Badge';
import { Button } from '@/components/ui/Button';
import { ConfirmDialog } from '@/components/ui/Dialog';
import { Spinner } from '@/components/ui/Spinner';
import { EmptyState, ErrorState } from '@/components/ui/EmptyState';
import { Pagination } from '@/components/ui/Pagination';
import {
  Table, TableHead, TableBody, TableRow, TableCell, TableHeadCell,
} from '@/components/ui/Table';
import { extractApiError } from '@/features/auth/AuthContext';
import { useToast } from '@/components/ui/Toast';
import { formatDate, formatDateTime } from '@/utils/format';

const DEFAULTER_STATUSES: DefaulterStatus[] = ['ACTIVE', 'NOTIFIED', 'RESOLVED'];

export function DefaultersPage() {
  const [searchParams, setSearchParams] = useSearchParams();
  const [page, setPage] = useState(1);
  const [statusFilter, setStatusFilter] = useState<DefaulterStatus | ''>(
    (searchParams.get('status') as DefaulterStatus) || ''
  );
  const [resolving, setResolving] = useState<number | null>(null);

  const qc = useQueryClient();
  const { toast } = useToast();

  const params: Record<string, string | number> = { page, limit: 25 };
  if (statusFilter) params.status = statusFilter;

  const { data, isLoading, error, refetch } = useQuery({
    queryKey: ['admin', 'defaulters', page, statusFilter],
    queryFn: () =>
      apiClient
        .get<PaginatedResponse<Defaulter>>(ENDPOINTS.ADMIN_DEFAULTERS, { params })
        .then((r) => r.data),
    staleTime: 30_000,
  });

  const resolve = useMutation({
    mutationFn: (id: number) =>
      apiClient.put(ENDPOINTS.ADMIN_DEFAULTER_RESOLVE(id)).then((r) => r.data),
    onSuccess: () => {
      setResolving(null);
      toast('success', 'Defaulter resolved');
      void qc.invalidateQueries({ queryKey: ['admin', 'defaulters'] });
      void qc.invalidateQueries({ queryKey: ['analytics', 'overview'] });
    },
    onError: (err) => {
      toast('error', 'Failed to resolve', extractApiError(err));
    },
  });

  function applyStatus(s: DefaulterStatus | '') {
    setStatusFilter(s);
    setPage(1);
    if (s) setSearchParams({ status: s });
    else setSearchParams({});
  }

  const selectClass = 'h-8 rounded-md border border-gray-300 bg-white px-2 text-sm text-gray-700 focus:border-primary-500 focus:outline-none';

  return (
    <div className="space-y-4">
      <div>
        <h1 className="text-xl font-semibold text-gray-900">Defaulters</h1>
        <p className="text-sm text-gray-500">Students with overdue equipment</p>
      </div>

      <Card padding="none">
        <div className="flex items-center gap-3 border-b border-gray-100 px-4 py-3">
          <select
            value={statusFilter}
            onChange={(e) => applyStatus(e.target.value as DefaulterStatus | '')}
            className={selectClass}
            aria-label="Filter by status"
          >
            <option value="">All statuses</option>
            {DEFAULTER_STATUSES.map((s) => (
              <option key={s} value={s}>{s}</option>
            ))}
          </select>
          {data && (
            <span className="ml-auto text-xs text-gray-400">
              {data.pagination.total} total
            </span>
          )}
        </div>

        {isLoading ? (
          <div className="flex justify-center py-16"><Spinner /></div>
        ) : error ? (
          <ErrorState title="Could not load defaulters" message={extractApiError(error)} onRetry={() => void refetch()} />
        ) : !data?.data.length ? (
          <EmptyState
            title="No defaulters"
            description={statusFilter ? `No ${statusFilter} defaulters.` : 'All equipment has been returned on time.'}
          />
        ) : (
          <>
            <Table>
              <TableHead>
                <tr>
                  <TableHeadCell>Student</TableHeadCell>
                  <TableHeadCell>Transaction</TableHeadCell>
                  <TableHeadCell>Overdue Days</TableHeadCell>
                  <TableHeadCell>Status</TableHeadCell>
                  <TableHeadCell>Detected</TableHeadCell>
                  <TableHeadCell>Resolved</TableHeadCell>
                  <TableHeadCell>Actions</TableHeadCell>
                </tr>
              </TableHead>
              <TableBody>
                {data.data.map((d) => (
                  <TableRow key={d.id}>
                    <TableCell>
                      <div>
                        <p className="font-medium text-gray-900">
                          {d.student_name ?? `Student #${d.student_id}`}
                        </p>
                        <p className="text-xs text-gray-400">#{d.student_id}</p>
                      </div>
                    </TableCell>
                    <TableCell className="text-gray-500">#{d.transaction_id}</TableCell>
                    <TableCell>
                      <span className={`font-medium ${d.overdue_days > 7 ? 'text-red-600' : 'text-amber-600'}`}>
                        {d.overdue_days}d
                      </span>
                    </TableCell>
                    <TableCell><DefaulterStatusBadge status={d.status} /></TableCell>
                    <TableCell className="text-xs text-gray-500">
                      {formatDate(d.detected_at)}
                    </TableCell>
                    <TableCell className="text-xs text-gray-500">
                      {d.resolved_at ? formatDateTime(d.resolved_at) : '—'}
                    </TableCell>
                    <TableCell>
                      {d.status !== 'RESOLVED' && (
                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={() => setResolving(d.id)}
                        >
                          Resolve
                        </Button>
                      )}
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
            {data.pagination && (
              <Pagination
                pagination={{
                  page: data.pagination.page,
                  perPage: data.pagination.limit,
                  total: data.pagination.total,
                  totalPages: data.pagination.totalPages,
                }}
                onPageChange={setPage}
              />
            )}
          </>
        )}
      </Card>

      <ConfirmDialog
        open={resolving !== null}
        onOpenChange={(open) => !open && setResolving(null)}
        title="Resolve defaulter?"
        description="This will mark the defaulter record as RESOLVED. The student will be able to make new bookings."
        confirmLabel="Resolve"
        variant="primary"
        loading={resolve.isPending}
        onConfirm={() => resolving !== null && resolve.mutate(resolving)}
      />
    </div>
  );
}
