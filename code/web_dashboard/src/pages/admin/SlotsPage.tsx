import { useState } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { Plus, Play } from 'lucide-react';
import { apiClient } from '@/api/client';
import { ENDPOINTS } from '@/api/endpoints';
import type { Slot, SlotCreateRequest, AllocationResult, DeactivateResult } from '@/types/slot';
import type { Equipment } from '@/types/equipment';
import type { PaginatedResponse, ApiResponse } from '@/types/common';
import { Card } from '@/components/ui/Card';
import { Button } from '@/components/ui/Button';
import {
  Table, TableHead, TableBody, TableRow, TableCell, TableHeadCell,
} from '@/components/ui/Table';
import { SlotStatusBadge } from '@/components/ui/Badge';
import { Pagination } from '@/components/ui/Pagination';
import { Spinner } from '@/components/ui/Spinner';
import { EmptyState, ErrorState } from '@/components/ui/EmptyState';
import { Dialog, DialogContent, ConfirmDialog } from '@/components/ui/Dialog';
import { Input } from '@/components/ui/Input';
import { useToast } from '@/components/ui/Toast';
import { extractApiError } from '@/features/auth/AuthContext';
import { formatDate, formatTime, formatDateTime } from '@/utils/format';

type CreateForm = {
  equipment_id: string;
  date: string;
  start_time: string;
  end_time: string;
  capacity: string;
  booking_cutoff_at: string;
};

type EditForm = {
  date: string;
  start_time: string;
  end_time: string;
  capacity: string;
  booking_cutoff_at: string;
};

const emptyCreate = (): CreateForm => ({
  equipment_id: '',
  date: '',
  start_time: '',
  end_time: '',
  capacity: '1',
  booking_cutoff_at: '',
});

function datetimeLocalToISO(local: string): string {
  return local ? `${local}:00Z` : '';
}

function validateCreate(form: CreateForm): Partial<Record<keyof CreateForm, string>> {
  const errs: Partial<Record<keyof CreateForm, string>> = {};
  if (!form.equipment_id) errs.equipment_id = 'Select equipment';
  if (!form.date) errs.date = 'Required';
  if (!form.start_time) errs.start_time = 'Required';
  if (!form.end_time) errs.end_time = 'Required';
  else if (form.start_time && form.end_time <= form.start_time) errs.end_time = 'Must be after start time';
  const cap = parseInt(form.capacity, 10);
  if (!form.capacity || isNaN(cap) || cap < 1) errs.capacity = 'Must be ≥ 1';
  if (!form.booking_cutoff_at) errs.booking_cutoff_at = 'Required';
  else if (form.date && form.start_time) {
    const cutoff = new Date(datetimeLocalToISO(form.booking_cutoff_at));
    const slotStart = new Date(`${form.date}T${form.start_time}:00Z`);
    if (cutoff >= slotStart) errs.booking_cutoff_at = 'Must be before slot start time';
  }
  return errs;
}

export function SlotsPage() {
  const [page, setPage] = useState(1);
  const [createOpen, setCreateOpen] = useState(false);
  const [editSlot, setEditSlot] = useState<Slot | null>(null);
  const [deactivateSlot, setDeactivateSlot] = useState<Slot | null>(null);
  const [allocationResult, setAllocationResult] = useState<(AllocationResult & { slotId: number }) | null>(null);
  const [createForm, setCreateForm] = useState<CreateForm>(emptyCreate());
  const [createErrors, setCreateErrors] = useState<Partial<Record<keyof CreateForm, string>>>({});
  const [editForm, setEditForm] = useState<EditForm>({ date: '', start_time: '', end_time: '', capacity: '1', booking_cutoff_at: '' });
  const [editErrors, setEditErrors] = useState<Partial<Record<keyof EditForm, string>>>({});

  const qc = useQueryClient();
  const { toast } = useToast();

  const { data, isLoading, error, refetch } = useQuery({
    queryKey: ['admin', 'slots', page],
    queryFn: () =>
      apiClient
        .get<PaginatedResponse<Slot>>(ENDPOINTS.ADMIN_SLOTS, { params: { page, limit: 20 } })
        .then((r) => r.data),
    staleTime: 30_000,
  });

  // Load equipment for the create form selector (only when dialog is open).
  const equipmentQuery = useQuery({
    queryKey: ['inventory-all'],
    queryFn: () =>
      apiClient
        .get<PaginatedResponse<Equipment>>(ENDPOINTS.INVENTORY, { params: { limit: 100 } })
        .then((r) => r.data.data.filter((e) => e.status !== 'RETIRED')),
    enabled: createOpen,
    staleTime: 60_000,
  });

  const createMutation = useMutation({
    mutationFn: (body: SlotCreateRequest) =>
      apiClient.post<ApiResponse<Slot>>(ENDPOINTS.ADMIN_SLOTS, body).then((r) => r.data),
    onSuccess: () => {
      toast('success', 'Slot created');
      setCreateOpen(false);
      setCreateForm(emptyCreate());
      setCreateErrors({});
      void qc.invalidateQueries({ queryKey: ['admin', 'slots'] });
    },
    onError: (err) => toast('error', 'Failed to create slot', extractApiError(err)),
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, body }: { id: number; body: Partial<EditForm & { capacity: number; booking_cutoff_at: string }> }) =>
      apiClient.put<ApiResponse<Slot>>(ENDPOINTS.ADMIN_SLOT_BY_ID(id), body).then((r) => r.data),
    onSuccess: () => {
      toast('success', 'Slot updated');
      setEditSlot(null);
      void qc.invalidateQueries({ queryKey: ['admin', 'slots'] });
    },
    onError: (err) => toast('error', 'Update failed', extractApiError(err)),
  });

  const deactivateMutation = useMutation({
    mutationFn: (id: number) =>
      apiClient.patch<ApiResponse<DeactivateResult>>(ENDPOINTS.ADMIN_SLOT_DEACTIVATE(id)).then((r) => r.data.data),
    onSuccess: (result) => {
      toast('success', `Slot closed. ${result.cancelled_bookings} booking(s) cancelled.`);
      setDeactivateSlot(null);
      void qc.invalidateQueries({ queryKey: ['admin', 'slots'] });
    },
    onError: (err) => toast('error', 'Deactivation failed', extractApiError(err)),
  });

  const allocationMutation = useMutation({
    mutationFn: (id: number) =>
      apiClient.post<ApiResponse<AllocationResult>>(ENDPOINTS.ADMIN_SLOT_RUN_ALLOCATION(id)).then((r) => r.data.data),
    onSuccess: (result, id) => {
      setAllocationResult({ ...result, slotId: id });
      void qc.invalidateQueries({ queryKey: ['admin', 'slots'] });
      void qc.invalidateQueries({ queryKey: ['analytics'] });
    },
    onError: (err) => toast('error', 'Allocation failed', extractApiError(err)),
  });

  function openEdit(slot: Slot) {
    setEditSlot(slot);
    const cutoffLocal = slot.booking_cutoff_at
      ? slot.booking_cutoff_at.slice(0, 16)
      : '';
    setEditForm({
      date: slot.date,
      start_time: slot.start_time.slice(0, 5),
      end_time: slot.end_time.slice(0, 5),
      capacity: String(slot.capacity),
      booking_cutoff_at: cutoffLocal,
    });
    setEditErrors({});
  }

  function submitCreate(e: React.FormEvent) {
    e.preventDefault();
    const errs = validateCreate(createForm);
    if (Object.keys(errs).length > 0) { setCreateErrors(errs); return; }
    createMutation.mutate({
      equipment_id: parseInt(createForm.equipment_id, 10),
      date: createForm.date,
      start_time: createForm.start_time,
      end_time: createForm.end_time,
      capacity: parseInt(createForm.capacity, 10),
      booking_cutoff_at: datetimeLocalToISO(createForm.booking_cutoff_at),
    });
  }

  function submitEdit(e: React.FormEvent) {
    e.preventDefault();
    if (!editSlot) return;
    const partial: Record<string, string | number> = {};
    if (editForm.date) partial.date = editForm.date;
    if (editForm.start_time) partial.start_time = editForm.start_time;
    if (editForm.end_time) partial.end_time = editForm.end_time;
    if (editForm.capacity) partial.capacity = parseInt(editForm.capacity, 10);
    if (editForm.booking_cutoff_at) partial.booking_cutoff_at = datetimeLocalToISO(editForm.booking_cutoff_at);

    if (editForm.start_time && editForm.end_time && editForm.end_time <= editForm.start_time) {
      setEditErrors({ end_time: 'Must be after start time' });
      return;
    }
    const cap = parseInt(editForm.capacity, 10);
    if (isNaN(cap) || cap < 1) {
      setEditErrors({ capacity: 'Must be ≥ 1' });
      return;
    }
    setEditErrors({});
    updateMutation.mutate({ id: editSlot.id, body: partial });
  }

  const selectClass = 'h-9 w-full rounded-md border border-gray-300 bg-white px-3 text-sm text-gray-900 focus:border-primary-500 focus:outline-none focus:ring-2 focus:ring-primary-500/20';

  const canRunAllocation = (slot: Slot) =>
    slot.status === 'OPEN' || slot.status === 'PENDING_ALLOCATION';

  const canEdit = (slot: Slot) =>
    slot.status === 'OPEN';

  const canDeactivate = (slot: Slot) =>
    slot.status !== 'CLOSED';

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-xl font-semibold text-gray-900">Slots</h1>
          <p className="text-sm text-gray-500">Manage booking slots and batch allocation</p>
        </div>
        <Button size="sm" onClick={() => { setCreateForm(emptyCreate()); setCreateErrors({}); setCreateOpen(true); }}>
          <Plus className="h-4 w-4" />
          Create Slot
        </Button>
      </div>

      <Card padding="none">
        {isLoading ? (
          <div className="flex justify-center py-16"><Spinner /></div>
        ) : error ? (
          <ErrorState title="Could not load slots" message={extractApiError(error)} onRetry={() => void refetch()} />
        ) : !data?.data.length ? (
          <EmptyState title="No slots" description="Create a slot to allow student bookings." />
        ) : (
          <>
            <Table>
              <TableHead>
                <tr>
                  <TableHeadCell>Equipment</TableHeadCell>
                  <TableHeadCell>Date</TableHeadCell>
                  <TableHeadCell>Time</TableHeadCell>
                  <TableHeadCell>Cap.</TableHeadCell>
                  <TableHeadCell>Avail.</TableHeadCell>
                  <TableHeadCell>Status</TableHeadCell>
                  <TableHeadCell>Cutoff</TableHeadCell>
                  <TableHeadCell>Allocation</TableHeadCell>
                  <TableHeadCell>Actions</TableHeadCell>
                </tr>
              </TableHead>
              <TableBody>
                {data.data.map((slot) => (
                  <TableRow key={slot.id}>
                    <TableCell className="font-medium text-gray-900">
                      {slot.equipment_name ?? `#${slot.equipment_id}`}
                    </TableCell>
                    <TableCell>{formatDate(slot.date)}</TableCell>
                    <TableCell className="whitespace-nowrap">
                      {formatTime(slot.start_time)} – {formatTime(slot.end_time)}
                    </TableCell>
                    <TableCell>{slot.capacity}</TableCell>
                    <TableCell>{slot.available_count}</TableCell>
                    <TableCell><SlotStatusBadge status={slot.status} /></TableCell>
                    <TableCell className="text-xs text-gray-500">
                      {formatDateTime(slot.booking_cutoff_at)}
                    </TableCell>
                    <TableCell className="text-xs text-gray-500">
                      {slot.allocation_run_at ? formatDateTime(slot.allocation_run_at) : '—'}
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-1">
                        {canEdit(slot) && (
                          <Button variant="ghost" size="sm" onClick={() => openEdit(slot)}>Edit</Button>
                        )}
                        {canRunAllocation(slot) && (
                          <Button variant="ghost" size="sm"
                            onClick={() => allocationMutation.mutate(slot.id)}
                            loading={allocationMutation.isPending && allocationMutation.variables === slot.id}
                            title="Run batch allocation">
                            <Play className="h-3 w-3" />
                          </Button>
                        )}
                        {canDeactivate(slot) && (
                          <Button variant="ghost" size="sm"
                            onClick={() => setDeactivateSlot(slot)}
                            className="text-red-600 hover:text-red-700">
                            Close
                          </Button>
                        )}
                      </div>
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

      {/* Create slot dialog */}
      <Dialog open={createOpen} onOpenChange={(o) => { if (!createMutation.isPending) setCreateOpen(o); }}>
        <DialogContent title="Create Slot" size="md">
          <form onSubmit={submitCreate} className="space-y-3 mt-2">
            <div className="flex flex-col gap-1">
              <label className="text-sm font-medium text-gray-700">Equipment</label>
              {equipmentQuery.isLoading ? (
                <div className="flex items-center gap-2 text-sm text-gray-500"><Spinner size="sm" />Loading equipment…</div>
              ) : (
                <select className={selectClass} value={createForm.equipment_id}
                  onChange={(e) => setCreateForm((f) => ({ ...f, equipment_id: e.target.value }))}>
                  <option value="">Select equipment…</option>
                  {(equipmentQuery.data ?? []).map((eq) => (
                    <option key={eq.id} value={eq.id}>{eq.name} ({eq.category})</option>
                  ))}
                </select>
              )}
              {createErrors.equipment_id && <p className="text-xs text-red-600">{createErrors.equipment_id}</p>}
            </div>

            <div className="grid grid-cols-2 gap-3">
              <Input label="Date" type="date" value={createForm.date} error={createErrors.date}
                onChange={(e) => setCreateForm((f) => ({ ...f, date: e.target.value }))} />
              <Input label="Capacity" type="number" min={1} value={createForm.capacity} error={createErrors.capacity}
                onChange={(e) => setCreateForm((f) => ({ ...f, capacity: e.target.value }))} />
            </div>

            <div className="grid grid-cols-2 gap-3">
              <Input label="Start Time" type="time" value={createForm.start_time} error={createErrors.start_time}
                onChange={(e) => setCreateForm((f) => ({ ...f, start_time: e.target.value }))} />
              <Input label="End Time" type="time" value={createForm.end_time} error={createErrors.end_time}
                onChange={(e) => setCreateForm((f) => ({ ...f, end_time: e.target.value }))} />
            </div>

            <Input label="Booking Cutoff" type="datetime-local" value={createForm.booking_cutoff_at}
              error={createErrors.booking_cutoff_at}
              hint="Must be before slot start time"
              onChange={(e) => setCreateForm((f) => ({ ...f, booking_cutoff_at: e.target.value }))} />

            <div className="flex justify-end gap-2 pt-2">
              <Button type="button" variant="secondary" onClick={() => setCreateOpen(false)}
                disabled={createMutation.isPending}>Cancel</Button>
              <Button type="submit" loading={createMutation.isPending}>Create Slot</Button>
            </div>
          </form>
        </DialogContent>
      </Dialog>

      {/* Edit slot dialog */}
      <Dialog open={!!editSlot} onOpenChange={(o) => { if (!updateMutation.isPending && !o) setEditSlot(null); }}>
        <DialogContent title={`Edit Slot #${editSlot?.id}`} size="md">
          <form onSubmit={submitEdit} className="space-y-3 mt-2">
            <div className="grid grid-cols-2 gap-3">
              <Input label="Date" type="date" value={editForm.date}
                onChange={(e) => setEditForm((f) => ({ ...f, date: e.target.value }))} />
              <Input label="Capacity" type="number" min={1} value={editForm.capacity} error={editErrors.capacity}
                onChange={(e) => setEditForm((f) => ({ ...f, capacity: e.target.value }))} />
            </div>
            <div className="grid grid-cols-2 gap-3">
              <Input label="Start Time" type="time" value={editForm.start_time}
                onChange={(e) => setEditForm((f) => ({ ...f, start_time: e.target.value }))} />
              <Input label="End Time" type="time" value={editForm.end_time} error={editErrors.end_time}
                onChange={(e) => setEditForm((f) => ({ ...f, end_time: e.target.value }))} />
            </div>
            <Input label="Booking Cutoff" type="datetime-local" value={editForm.booking_cutoff_at}
              onChange={(e) => setEditForm((f) => ({ ...f, booking_cutoff_at: e.target.value }))} />
            <div className="flex justify-end gap-2 pt-2">
              <Button type="button" variant="secondary" onClick={() => setEditSlot(null)}
                disabled={updateMutation.isPending}>Cancel</Button>
              <Button type="submit" loading={updateMutation.isPending}>Save Changes</Button>
            </div>
          </form>
        </DialogContent>
      </Dialog>

      {/* Deactivate confirmation */}
      <ConfirmDialog
        open={!!deactivateSlot}
        onOpenChange={(o) => !o && setDeactivateSlot(null)}
        title="Close slot?"
        description={`Slot on ${deactivateSlot ? formatDate(deactivateSlot.date) : ''} will be CLOSED. All REQUESTED bookings will be cancelled.`}
        confirmLabel="Close Slot"
        variant="danger"
        loading={deactivateMutation.isPending}
        onConfirm={() => deactivateSlot && deactivateMutation.mutate(deactivateSlot.id)}
      />

      {/* Allocation result */}
      <Dialog open={!!allocationResult} onOpenChange={(o) => !o && setAllocationResult(null)}>
        <DialogContent title="Allocation Complete" size="sm">
          {allocationResult && (
            <div className="mt-2 space-y-3">
              <div className="rounded-lg bg-gray-50 p-4 text-sm space-y-2">
                <p><span className="font-medium">Slot:</span> #{allocationResult.slotId}</p>
                <p><span className="font-medium">Status:</span> {allocationResult.slot_status}</p>
                <p className="text-green-700"><span className="font-medium">Confirmed:</span> {allocationResult.confirmed_count}</p>
                <p className="text-amber-700"><span className="font-medium">Waitlisted:</span> {allocationResult.waitlisted_count}</p>
                {allocationResult.allocation_run_at && (
                  <p className="text-xs text-gray-500">Run at {formatDateTime(allocationResult.allocation_run_at)}</p>
                )}
              </div>
              <div className="flex justify-end">
                <Button onClick={() => setAllocationResult(null)}>Done</Button>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>
    </div>
  );
}
