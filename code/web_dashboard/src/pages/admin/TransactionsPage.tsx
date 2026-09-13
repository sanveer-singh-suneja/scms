import { useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import { useSearchParams } from 'react-router-dom';
import { AlertTriangle } from 'lucide-react';
import { apiClient } from '@/api/client';
import { ENDPOINTS } from '@/api/endpoints';
import type { Transaction, TransactionStatus } from '@/types/transaction';
import type { EquipmentCondition } from '@/types/equipment';
import type { PaginatedResponse } from '@/types/common';
import { Card } from '@/components/ui/Card';
import { TransactionStatusBadge, Badge } from '@/components/ui/Badge';
import { Spinner } from '@/components/ui/Spinner';
import { EmptyState, ErrorState } from '@/components/ui/EmptyState';
import { Pagination } from '@/components/ui/Pagination';
import { Dialog, DialogContent } from '@/components/ui/Dialog';
import {
  Table, TableHead, TableBody, TableRow, TableCell, TableHeadCell,
} from '@/components/ui/Table';
import { extractApiError } from '@/features/auth/AuthContext';
import { formatDateTime } from '@/utils/format';

const TXN_STATUSES: TransactionStatus[] = ['ISSUED', 'RETURNED', 'RETURNED_DAMAGED', 'OVERDUE'];

const conditionVariant = (c: EquipmentCondition) =>
  ({ GOOD: 'success', FAIR: 'warning', DAMAGED: 'danger' } as const)[c];

export function TransactionsPage() {
  const [searchParams, setSearchParams] = useSearchParams();
  const [page, setPage] = useState(1);
  const [statusFilter, setStatusFilter] = useState<TransactionStatus | ''>(
    (searchParams.get('status') as TransactionStatus) || ''
  );
  const [detail, setDetail] = useState<Transaction | null>(null);

  const params: Record<string, string | number> = { page, limit: 25 };
  if (statusFilter) params.status = statusFilter;

  const { data, isLoading, error, refetch } = useQuery({
    queryKey: ['admin', 'transactions', page, statusFilter],
    queryFn: () =>
      apiClient
        .get<PaginatedResponse<Transaction>>(ENDPOINTS.ADMIN_TRANSACTIONS, { params })
        .then((r) => r.data),
    staleTime: 30_000,
  });

  function applyStatus(s: TransactionStatus | '') {
    setStatusFilter(s);
    setPage(1);
    if (s) setSearchParams({ status: s });
    else setSearchParams({});
  }

  const selectClass = 'h-8 rounded-md border border-gray-300 bg-white px-2 text-sm text-gray-700 focus:border-primary-500 focus:outline-none';

  return (
    <div className="space-y-4">
      <div>
        <h1 className="text-xl font-semibold text-gray-900">Transactions</h1>
        <p className="text-sm text-gray-500">Equipment issue and return history</p>
      </div>

      <Card padding="none">
        <div className="flex items-center gap-3 border-b border-gray-100 px-4 py-3">
          <select
            value={statusFilter}
            onChange={(e) => applyStatus(e.target.value as TransactionStatus | '')}
            className={selectClass}
            aria-label="Filter by status"
          >
            <option value="">All statuses</option>
            {TXN_STATUSES.map((s) => (
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
          <ErrorState title="Could not load transactions" message={extractApiError(error)} onRetry={() => void refetch()} />
        ) : !data?.data.length ? (
          <EmptyState title="No transactions" description={statusFilter ? `No ${statusFilter} transactions.` : 'No transactions yet.'} />
        ) : (
          <>
            <Table>
              <TableHead>
                <tr>
                  <TableHeadCell>ID</TableHeadCell>
                  <TableHeadCell>Student</TableHeadCell>
                  <TableHeadCell>Equipment</TableHeadCell>
                  <TableHeadCell>Status</TableHeadCell>
                  <TableHeadCell>Issued At</TableHeadCell>
                  <TableHeadCell>Due At</TableHeadCell>
                  <TableHeadCell>Returned At</TableHeadCell>
                  <TableHeadCell>Condition</TableHeadCell>
                </tr>
              </TableHead>
              <TableBody>
                {data.data.map((t) => (
                  <TableRow
                    key={t.id}
                    className="cursor-pointer"
                    onClick={() => setDetail(t)}
                  >
                    <TableCell className="text-gray-500 text-xs">#{t.id}</TableCell>
                    <TableCell>#{t.student_id}</TableCell>
                    <TableCell>
                      {t.equipment_name ?? `#${t.equipment_id}`}
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-1">
                        <TransactionStatusBadge status={t.status} />
                        {t.status === 'OVERDUE' && (
                          <AlertTriangle className="h-3 w-3 text-red-500" />
                        )}
                      </div>
                    </TableCell>
                    <TableCell className="text-xs">{formatDateTime(t.issued_at)}</TableCell>
                    <TableCell className="text-xs">{formatDateTime(t.due_at)}</TableCell>
                    <TableCell className="text-xs text-gray-500">
                      {t.returned_at ? formatDateTime(t.returned_at) : '—'}
                    </TableCell>
                    <TableCell>
                      {t.condition_on_return ? (
                        <Badge variant={conditionVariant(t.condition_on_return)}>
                          {t.condition_on_return}
                        </Badge>
                      ) : '—'}
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

      {/* Detail drawer */}
      <Dialog open={!!detail} onOpenChange={(o) => !o && setDetail(null)}>
        <DialogContent title={`Transaction #${detail?.id}`} size="sm">
          {detail && (
            <div className="mt-2 space-y-3 text-sm">
              <div className="grid grid-cols-2 gap-x-4 gap-y-2 rounded-lg bg-gray-50 p-4">
                <div>
                  <p className="text-xs text-gray-500">Student</p>
                  <p className="font-medium">#{detail.student_id}</p>
                </div>
                <div>
                  <p className="text-xs text-gray-500">Equipment</p>
                  <p className="font-medium">{detail.equipment_name ?? `#${detail.equipment_id}`}</p>
                </div>
                <div>
                  <p className="text-xs text-gray-500">Status</p>
                  <TransactionStatusBadge status={detail.status} />
                </div>
                <div>
                  <p className="text-xs text-gray-500">Issued By (staff)</p>
                  <p className="font-medium">#{detail.issued_by}</p>
                </div>
                <div>
                  <p className="text-xs text-gray-500">Issued At</p>
                  <p className="text-xs font-medium">{formatDateTime(detail.issued_at)}</p>
                </div>
                <div>
                  <p className="text-xs text-gray-500">Due At</p>
                  <p className="text-xs font-medium">{formatDateTime(detail.due_at)}</p>
                </div>
                {detail.returned_at && (
                  <>
                    <div>
                      <p className="text-xs text-gray-500">Returned At</p>
                      <p className="text-xs font-medium">{formatDateTime(detail.returned_at)}</p>
                    </div>
                    {detail.returned_to != null && (
                      <div>
                        <p className="text-xs text-gray-500">Returned To (staff)</p>
                        <p className="font-medium">#{detail.returned_to}</p>
                      </div>
                    )}
                  </>
                )}
                {detail.condition_on_return && (
                  <div>
                    <p className="text-xs text-gray-500">Condition on Return</p>
                    <Badge variant={conditionVariant(detail.condition_on_return)}>
                      {detail.condition_on_return}
                    </Badge>
                  </div>
                )}
                {detail.booking_id != null && (
                  <div>
                    <p className="text-xs text-gray-500">Booking</p>
                    <p className="font-medium">#{detail.booking_id}</p>
                  </div>
                )}
              </div>
              {detail.damage_report && (
                <div className="rounded-lg border border-red-100 bg-red-50 p-3">
                  <p className="text-xs font-medium text-red-700">Damage Report</p>
                  <p className="mt-1 text-xs text-red-600">{detail.damage_report}</p>
                </div>
              )}
              <div className="flex justify-end">
                <button
                  onClick={() => setDetail(null)}
                  className="rounded-md bg-primary-600 px-4 py-2 text-sm font-medium text-white hover:bg-primary-700"
                >
                  Close
                </button>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>
    </div>
  );
}
