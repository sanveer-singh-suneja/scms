import { useState } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { Plus, Wrench } from 'lucide-react';
import { apiClient } from '@/api/client';
import { ENDPOINTS } from '@/api/endpoints';
import type { Equipment, EquipmentCondition, EquipmentCreateRequest } from '@/types/equipment';
import type { PaginatedResponse } from '@/types/common';
import { Card } from '@/components/ui/Card';
import { Button } from '@/components/ui/Button';
import {
  Table, TableHead, TableBody, TableRow, TableCell, TableHeadCell,
} from '@/components/ui/Table';
import { EquipmentStatusBadge, Badge } from '@/components/ui/Badge';
import { Pagination } from '@/components/ui/Pagination';
import { Spinner } from '@/components/ui/Spinner';
import { EmptyState, ErrorState } from '@/components/ui/EmptyState';
import { Dialog, DialogContent } from '@/components/ui/Dialog';
import { ConfirmDialog } from '@/components/ui/Dialog';
import { Input } from '@/components/ui/Input';
import { useToast } from '@/components/ui/Toast';
import { extractApiError } from '@/features/auth/AuthContext';
import { formatDate } from '@/utils/format';

const CATEGORIES = ['Cricket', 'Football', 'Basketball', 'Tennis', 'Badminton', 'Athletics', 'Swimming', 'Other'];
const CONDITIONS: EquipmentCondition[] = ['GOOD', 'FAIR', 'DAMAGED'];

const conditionVariant = (c: EquipmentCondition) =>
  ({ GOOD: 'success', FAIR: 'warning', DAMAGED: 'danger' } as const)[c];

type CreateForm = { name: string; category: string; qr_code: string; location: string; notes: string };
type EditForm = { name: string; category: string; location: string; notes: string; condition: EquipmentCondition };

const emptyCreate = (): CreateForm => ({ name: '', category: '', qr_code: '', location: '', notes: '' });

export function InventoryPage() {
  const [page, setPage] = useState(1);
  const [categoryFilter, setCategoryFilter] = useState('');
  const [createOpen, setCreateOpen] = useState(false);
  const [editItem, setEditItem] = useState<Equipment | null>(null);
  const [retireItem, setRetireItem] = useState<Equipment | null>(null);
  const [createForm, setCreateForm] = useState<CreateForm>(emptyCreate());
  const [editForm, setEditForm] = useState<EditForm>({ name: '', category: '', location: '', notes: '', condition: 'GOOD' });
  const [createErrors, setCreateErrors] = useState<Partial<CreateForm>>({});

  const qc = useQueryClient();
  const { toast } = useToast();

  const { data, isLoading, error, refetch } = useQuery({
    queryKey: ['inventory', page, categoryFilter],
    queryFn: () =>
      apiClient
        .get<PaginatedResponse<Equipment>>(ENDPOINTS.INVENTORY, {
          params: { page, limit: 20, ...(categoryFilter ? { category: categoryFilter } : {}) },
        })
        .then((r) => r.data),
    staleTime: 30_000,
  });

  const createMutation = useMutation({
    mutationFn: (body: EquipmentCreateRequest) =>
      apiClient.post(ENDPOINTS.INVENTORY, body).then((r) => r.data),
    onSuccess: () => {
      toast('success', 'Equipment added');
      setCreateOpen(false);
      setCreateForm(emptyCreate());
      setCreateErrors({});
      void qc.invalidateQueries({ queryKey: ['inventory'] });
    },
    onError: (err) => toast('error', 'Failed to add equipment', extractApiError(err)),
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, body }: { id: number; body: Partial<EditForm> }) =>
      apiClient.put(ENDPOINTS.INVENTORY_BY_ID(id), body).then((r) => r.data),
    onSuccess: () => {
      toast('success', 'Equipment updated');
      setEditItem(null);
      void qc.invalidateQueries({ queryKey: ['inventory'] });
    },
    onError: (err) => toast('error', 'Update failed', extractApiError(err)),
  });

  const statusMutation = useMutation({
    mutationFn: ({ id, status }: { id: number; status: 'AVAILABLE' | 'MAINTENANCE' }) =>
      apiClient.put(ENDPOINTS.INVENTORY_BY_ID(id), { status }).then((r) => r.data),
    onSuccess: (_, { status }) => {
      toast('success', `Status set to ${status}`);
      void qc.invalidateQueries({ queryKey: ['inventory'] });
    },
    onError: (err) => toast('error', 'Status change failed', extractApiError(err)),
  });

  const retireMutation = useMutation({
    mutationFn: (id: number) =>
      apiClient.patch(ENDPOINTS.INVENTORY_RETIRE(id)).then((r) => r.data),
    onSuccess: () => {
      toast('success', 'Equipment retired');
      setRetireItem(null);
      void qc.invalidateQueries({ queryKey: ['inventory'] });
    },
    onError: (err) => toast('error', 'Retire failed', extractApiError(err)),
  });

  function openEdit(item: Equipment) {
    setEditItem(item);
    setEditForm({
      name: item.name,
      category: item.category,
      location: item.location ?? '',
      notes: item.notes ?? '',
      condition: item.condition,
    });
  }

  function validateCreate(): boolean {
    const errs: Partial<CreateForm> = {};
    if (!createForm.name.trim()) errs.name = 'Required';
    if (!createForm.category.trim()) errs.category = 'Required';
    if (!createForm.qr_code.trim()) errs.qr_code = 'Required';
    setCreateErrors(errs);
    return Object.keys(errs).length === 0;
  }

  function submitCreate(e: React.FormEvent) {
    e.preventDefault();
    if (!validateCreate()) return;
    createMutation.mutate({
      name: createForm.name.trim(),
      category: createForm.category.trim(),
      qr_code: createForm.qr_code.trim(),
      ...(createForm.location ? { location: createForm.location.trim() } : {}),
      ...(createForm.notes ? { notes: createForm.notes.trim() } : {}),
    });
  }

  function submitEdit(e: React.FormEvent) {
    e.preventDefault();
    if (!editItem) return;
    updateMutation.mutate({
      id: editItem.id,
      body: {
        name: editForm.name.trim() || undefined,
        category: editForm.category.trim() || undefined,
        location: editForm.location.trim() || undefined,
        notes: editForm.notes.trim() || undefined,
        condition: editForm.condition,
      },
    });
  }

  const selectClass = 'h-9 w-full rounded-md border border-gray-300 bg-white px-3 text-sm text-gray-900 focus:border-primary-500 focus:outline-none focus:ring-2 focus:ring-primary-500/20';

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-xl font-semibold text-gray-900">Inventory</h1>
          <p className="text-sm text-gray-500">Manage all equipment</p>
        </div>
        <Button size="sm" onClick={() => { setCreateForm(emptyCreate()); setCreateErrors({}); setCreateOpen(true); }}>
          <Plus className="h-4 w-4" />
          Add Equipment
        </Button>
      </div>

      <Card padding="none">
        {/* Filter bar */}
        <div className="flex items-center gap-3 border-b border-gray-100 px-4 py-3">
          <select
            value={categoryFilter}
            onChange={(e) => { setCategoryFilter(e.target.value); setPage(1); }}
            className="h-8 rounded-md border border-gray-300 bg-white px-2 text-sm text-gray-700 focus:border-primary-500 focus:outline-none"
            aria-label="Filter by category"
          >
            <option value="">All categories</option>
            {CATEGORIES.map((c) => (
              <option key={c} value={c}>{c}</option>
            ))}
          </select>
        </div>

        {isLoading ? (
          <div className="flex justify-center py-16"><Spinner /></div>
        ) : error ? (
          <ErrorState title="Could not load inventory" message={extractApiError(error)} onRetry={() => void refetch()} />
        ) : !data?.data.length ? (
          <EmptyState title="No equipment found" description={categoryFilter ? 'Try a different category.' : 'Add equipment to get started.'} />
        ) : (
          <>
            <Table>
              <TableHead>
                <tr>
                  <TableHeadCell>Name</TableHeadCell>
                  <TableHeadCell>Category</TableHeadCell>
                  <TableHeadCell>QR Code</TableHeadCell>
                  <TableHeadCell>Status</TableHeadCell>
                  <TableHeadCell>Condition</TableHeadCell>
                  <TableHeadCell>Location</TableHeadCell>
                  <TableHeadCell>Added</TableHeadCell>
                  <TableHeadCell>Actions</TableHeadCell>
                </tr>
              </TableHead>
              <TableBody>
                {data.data.map((item) => (
                  <TableRow key={item.id}>
                    <TableCell className="font-medium text-gray-900">{item.name}</TableCell>
                    <TableCell>{item.category}</TableCell>
                    <TableCell className="font-mono text-xs text-gray-500">{item.qr_code}</TableCell>
                    <TableCell><EquipmentStatusBadge status={item.status} /></TableCell>
                    <TableCell>
                      <Badge variant={conditionVariant(item.condition)}>{item.condition}</Badge>
                    </TableCell>
                    <TableCell className="text-gray-500">{item.location ?? '—'}</TableCell>
                    <TableCell>{formatDate(item.added_at)}</TableCell>
                    <TableCell>
                      <div className="flex items-center gap-1">
                        <Button variant="ghost" size="sm" onClick={() => openEdit(item)}
                          disabled={statusMutation.isPending}>Edit</Button>
                        {item.status === 'AVAILABLE' && (
                          <Button variant="ghost" size="sm"
                            onClick={() => statusMutation.mutate({ id: item.id, status: 'MAINTENANCE' })}
                            loading={statusMutation.isPending && statusMutation.variables?.id === item.id}>
                            <Wrench className="h-3 w-3" />
                          </Button>
                        )}
                        {item.status === 'MAINTENANCE' && (
                          <Button variant="ghost" size="sm"
                            onClick={() => statusMutation.mutate({ id: item.id, status: 'AVAILABLE' })}
                            loading={statusMutation.isPending && statusMutation.variables?.id === item.id}>
                            Restore
                          </Button>
                        )}
                        {(item.status === 'AVAILABLE' || item.status === 'MAINTENANCE') && (
                          <Button variant="ghost" size="sm"
                            onClick={() => setRetireItem(item)}
                            className="text-red-600 hover:text-red-700">
                            Retire
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

      {/* Create dialog */}
      <Dialog open={createOpen} onOpenChange={(o) => { if (!createMutation.isPending) setCreateOpen(o); }}>
        <DialogContent title="Add Equipment" size="md">
          <form onSubmit={submitCreate} className="space-y-3 mt-2">
            <Input label="Name" value={createForm.name} error={createErrors.name}
              onChange={(e) => setCreateForm((f) => ({ ...f, name: e.target.value }))} />
            <div className="flex flex-col gap-1">
              <label className="text-sm font-medium text-gray-700">Category</label>
              <select className={selectClass} value={createForm.category}
                onChange={(e) => setCreateForm((f) => ({ ...f, category: e.target.value }))}>
                <option value="">Select category…</option>
                {CATEGORIES.map((c) => <option key={c} value={c}>{c}</option>)}
              </select>
              {createErrors.category && <p className="text-xs text-red-600">{createErrors.category}</p>}
            </div>
            <Input label="QR Code" value={createForm.qr_code} error={createErrors.qr_code}
              onChange={(e) => setCreateForm((f) => ({ ...f, qr_code: e.target.value }))}
              hint="Unique identifier printed/labelled on equipment" />
            <Input label="Location (optional)" value={createForm.location}
              onChange={(e) => setCreateForm((f) => ({ ...f, location: e.target.value }))}
              placeholder="e.g. Rack A, Cabinet 2" />
            <div className="flex flex-col gap-1">
              <label className="text-sm font-medium text-gray-700">Notes (optional)</label>
              <textarea value={createForm.notes}
                onChange={(e) => setCreateForm((f) => ({ ...f, notes: e.target.value }))}
                className="w-full rounded-md border border-gray-300 bg-white px-3 py-2 text-sm text-gray-900 placeholder:text-gray-400 focus:border-primary-500 focus:outline-none focus:ring-2 focus:ring-primary-500/20"
                rows={2} placeholder="Any notes about this equipment" />
            </div>
            <div className="flex justify-end gap-2 pt-2">
              <Button type="button" variant="secondary" onClick={() => setCreateOpen(false)}
                disabled={createMutation.isPending}>Cancel</Button>
              <Button type="submit" loading={createMutation.isPending}>Add Equipment</Button>
            </div>
          </form>
        </DialogContent>
      </Dialog>

      {/* Edit dialog */}
      <Dialog open={!!editItem} onOpenChange={(o) => { if (!updateMutation.isPending && !o) setEditItem(null); }}>
        <DialogContent title="Edit Equipment" size="md">
          <form onSubmit={submitEdit} className="space-y-3 mt-2">
            <Input label="Name" value={editForm.name}
              onChange={(e) => setEditForm((f) => ({ ...f, name: e.target.value }))} />
            <div className="flex flex-col gap-1">
              <label className="text-sm font-medium text-gray-700">Category</label>
              <select className={selectClass} value={editForm.category}
                onChange={(e) => setEditForm((f) => ({ ...f, category: e.target.value }))}>
                <option value="">Select category…</option>
                {CATEGORIES.map((c) => <option key={c} value={c}>{c}</option>)}
              </select>
            </div>
            <div className="flex flex-col gap-1">
              <label className="text-sm font-medium text-gray-700">Condition</label>
              <select className={selectClass} value={editForm.condition}
                onChange={(e) => setEditForm((f) => ({ ...f, condition: e.target.value as EquipmentCondition }))}>
                {CONDITIONS.map((c) => <option key={c} value={c}>{c}</option>)}
              </select>
            </div>
            <Input label="Location (optional)" value={editForm.location}
              onChange={(e) => setEditForm((f) => ({ ...f, location: e.target.value }))} />
            <div className="flex flex-col gap-1">
              <label className="text-sm font-medium text-gray-700">Notes (optional)</label>
              <textarea value={editForm.notes}
                onChange={(e) => setEditForm((f) => ({ ...f, notes: e.target.value }))}
                className="w-full rounded-md border border-gray-300 bg-white px-3 py-2 text-sm text-gray-900 focus:border-primary-500 focus:outline-none focus:ring-2 focus:ring-primary-500/20"
                rows={2} />
            </div>
            <div className="flex justify-end gap-2 pt-2">
              <Button type="button" variant="secondary" onClick={() => setEditItem(null)}
                disabled={updateMutation.isPending}>Cancel</Button>
              <Button type="submit" loading={updateMutation.isPending}>Save Changes</Button>
            </div>
          </form>
        </DialogContent>
      </Dialog>

      {/* Retire confirmation */}
      <ConfirmDialog
        open={!!retireItem}
        onOpenChange={(o) => !o && setRetireItem(null)}
        title="Retire equipment?"
        description={`"${retireItem?.name}" will be marked RETIRED. This cannot be undone. Equipment currently issued cannot be retired.`}
        confirmLabel="Retire"
        variant="danger"
        loading={retireMutation.isPending}
        onConfirm={() => retireItem && retireMutation.mutate(retireItem.id)}
      />
    </div>
  );
}
