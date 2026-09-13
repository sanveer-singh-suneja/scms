import { useState } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { useSearchParams } from 'react-router-dom';
import { apiClient } from '@/api/client';
import { ENDPOINTS } from '@/api/endpoints';
import type { Booking, BookingStatus } from '@/types/booking';
import type { PaginatedResponse, ApiResponse } from '@/types/common';
import { Card } from '@/components/ui/Card';
import { BookingStatusBadge } from '@/components/ui/Badge';
import { Button } from '@/components/ui/Button';
import { Spinner } from '@/components/ui/Spinner';
import { EmptyState, ErrorState } from '@/components/ui/EmptyState';
import { Pagination } from '@/components/ui/Pagination';
import { ConfirmDialog, Dialog, DialogContent } from '@/components/ui/Dialog';
import {
  Table, TableHead, TableBody, TableRow, TableCell, TableHeadCell,
} from '@/components/ui/Table';
import { extractApiError } from '@/features/auth/AuthContext';
import { useToast } from '@/components/ui/Toast';
import { formatDateTime } from '@/utils/format';

const BOOKING_STATUSES: BookingStatus[] = [
  'REQUESTED', 'CONFIRMED', 'WAITLISTED', 'CANCELLED', 'NO_SHOW', 'COMPLETED',
];

const CANCELLABLE: BookingStatus[] = ['REQUESTED', 'CONFIRMED', 'WAITLISTED'];

export function BookingsPage() {
  const [searchParams, setSearchParams] = useSearchParams();
  const [page, setPage] = useState(1);
  const [statusFilter, setStatusFilter] = useState<BookingStatus | ''>(
    (searchParams.get('status') as BookingStatus) || ''
  );
  const [cancelTarget, setCancelTarget] = useState<Booking | null>(null);
  const [detailBooking, setDetailBooking] = useState<Booking | null>(null);

  const qc = useQueryClient();
  const { toast } = useToast();

  const params: Record<string, string | number> = { page, limit: 25 };
  if (statusFilter) params.status = statusFilter;

  const { data, isLoading, error, refetch } = useQuery({
    queryKey: ['admin', 'bookings', page, statusFilter],
    queryFn: () =>
      apiClient
        .get<PaginatedResponse<Booking>>(ENDPOINTS.ADMIN_BOOKINGS, { params })
        .then((r) => r.data),
    staleTime: 30_000,
  });

  const cancelMutation = useMutation({
    mutationFn: (id: number) =>
      apiClient.delete<ApiResponse<{ id: number; status: BookingStatus }>>(
        ENDPOINTS.BOOKING_BY_ID(id)
      ).then((r) => r.data),
    onSuccess: () => {
      toast('success', 'Booking cancelled');
      setCancelTarget(null);
      void qc.invalidateQueries({ queryKey: ['admin', 'bookings'] });
    },
    onError: (err) => toast('error', 'Cancel failed', extractApiError(err)),
  });

  function applyStatus(s: BookingStatus | '') {
    setStatusFilter(s);
    setPage(1);
    if (s) setSearchParams({ status: s });
    else setSearchParams({});
  }

  const selectClass = 'h-8 rounded-md border border-gray-300 bg-white px-2 text-sm text-gray-700 focus:border-primary-500 focus:outline-none';

  return (
    <div className="space-y-4">
      <div>
        <h1 className="text-xl font-semibold text-gray-900">Bookings</h1>
        <p className="text-sm text-gray-500">All booking records across all students</p>
      </div>

      <Card padding="none">
        {/* Filter bar */}
        <div className="flex items-center gap-3 border-b border-gray-100 px-4 py-3">
          <select
            value={statusFilter}
            onChange={(e) => applyStatus(e.target.value as BookingStatus | '')}
            className={selectClass}
            aria-label="Filter by status"
          >
            <option value="">All statuses</option>
            {BOOKING_STATUSES.map((s) => (
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
          <ErrorState title="Could not load bookings" message={extractApiError(error)} onRetry={() => void refetch()} />
        ) : !data?.data.length ? (
          <EmptyState title="No bookings" description={statusFilter ? `No ${statusFilter} bookings.` : 'No bookings yet.'} />
        ) : (
          <>
            <Table>
              <TableHead>
                <tr>
                  <TableHeadCell>ID</TableHeadCell>
                  <TableHeadCell>Student</TableHeadCell>
                  <TableHeadCell>Equipment</TableHeadCell>
                  <TableHeadCell>Slot</TableHeadCell>
                  <TableHeadCell>Status</TableHeadCell>
                  <TableHeadCell>Queue</TableHeadCell>
                  <TableHeadCell>Score</TableHeadCell>
                  <TableHeadCell>Created</TableHeadCell>
                  <TableHeadCell>Allocated</TableHeadCell>
                  <TableHeadCell>Actions</TableHeadCell>
                </tr>
              </TableHead>
              <TableBody>
                {data.data.map((b) => (
                  <TableRow
                    key={b.id}
                    className="cursor-pointer"
                    onClick={() => setDetailBooking(b)}
                  >
                    <TableCell className="text-gray-500 text-xs">#{b.id}</TableCell>
                    <TableCell>#{b.student_id}</TableCell>
                    <TableCell>#{b.equipment_id}</TableCell>
                    <TableCell>#{b.slot_id}</TableCell>
                    <TableCell onClick={(e) => e.stopPropagation()}>
                      <BookingStatusBadge status={b.status} />
                    </TableCell>
                    <TableCell>{b.queue_position ?? '—'}</TableCell>
                    <TableCell className="text-xs text-gray-500">
                      {b.priority_score != null
                        ? Number(b.priority_score).toFixed(4)
                        : '—'}
                    </TableCell>
                    <TableCell className="text-xs">{formatDateTime(b.created_at)}</TableCell>
                    <TableCell className="text-xs text-gray-500">
                      {b.allocated_at ? formatDateTime(b.allocated_at) : '—'}
                    </TableCell>
                    <TableCell onClick={(e) => e.stopPropagation()}>
                      {CANCELLABLE.includes(b.status) && (
                        <Button
                          variant="ghost"
                          size="sm"
                          className="text-red-600 hover:text-red-700"
                          onClick={() => setCancelTarget(b)}
                        >
                          Cancel
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

      {/* Booking detail modal */}
      <Dialog open={!!detailBooking} onOpenChange={(o) => !o && setDetailBooking(null)}>
        <DialogContent title={`Booking #${detailBooking?.id}`} size="sm">
          {detailBooking && (
            <div className="mt-2 space-y-3 text-sm">
              <div className="grid grid-cols-2 gap-x-4 gap-y-2 rounded-lg bg-gray-50 p-4">
                <div>
                  <p className="text-xs text-gray-500">Student</p>
                  <p className="font-medium">#{detailBooking.student_id}</p>
                </div>
                <div>
                  <p className="text-xs text-gray-500">Equipment</p>
                  <p className="font-medium">#{detailBooking.equipment_id}</p>
                </div>
                <div>
                  <p className="text-xs text-gray-500">Slot</p>
                  <p className="font-medium">#{detailBooking.slot_id}</p>
                </div>
                <div>
                  <p className="text-xs text-gray-500">Status</p>
                  <BookingStatusBadge status={detailBooking.status} />
                </div>
                {detailBooking.queue_position != null && (
                  <div>
                    <p className="text-xs text-gray-500">Queue Position</p>
                    <p className="font-medium">{detailBooking.queue_position}</p>
                  </div>
                )}
                {detailBooking.priority_score != null && (
                  <div>
                    <p className="text-xs text-gray-500">Priority Score</p>
                    <p className="font-medium text-xs font-mono">
                      {Number(detailBooking.priority_score).toFixed(4)}
                    </p>
                  </div>
                )}
                <div>
                  <p className="text-xs text-gray-500">Created</p>
                  <p className="font-medium text-xs">{formatDateTime(detailBooking.created_at)}</p>
                </div>
                <div>
                  <p className="text-xs text-gray-500">Allocated</p>
                  <p className="font-medium text-xs">
                    {detailBooking.allocated_at ? formatDateTime(detailBooking.allocated_at) : '—'}
                  </p>
                </div>
              </div>
              <p className="text-xs text-gray-400">
                Priority score is set by the batch allocation engine. Lower = higher priority.
              </p>
              <div className="flex justify-end gap-2">
                {CANCELLABLE.includes(detailBooking.status) && (
                  <Button
                    variant="secondary"
                    size="sm"
                    className="text-red-600"
                    onClick={() => {
                      setCancelTarget(detailBooking);
                      setDetailBooking(null);
                    }}
                  >
                    Cancel Booking
                  </Button>
                )}
                <Button onClick={() => setDetailBooking(null)}>Close</Button>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>

      {/* Cancel confirmation */}
      <ConfirmDialog
        open={!!cancelTarget}
        onOpenChange={(o) => !o && setCancelTarget(null)}
        title="Cancel booking?"
        description={`Booking #${cancelTarget?.id} will be set to CANCELLED. This cannot be undone.`}
        confirmLabel="Cancel Booking"
        variant="danger"
        loading={cancelMutation.isPending}
        onConfirm={() => cancelTarget && cancelMutation.mutate(cancelTarget.id)}
      />
    </div>
  );
}
