import { useState } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { Plus, Pencil } from 'lucide-react';
import { apiClient } from '@/api/client';
import { ENDPOINTS } from '@/api/endpoints';
import type { StaffUser, StaffCreateRequest, StaffUpdateRequest, UserRole } from '@/types/staff';
import type { PaginatedResponse } from '@/types/common';
import { Card } from '@/components/ui/Card';
import { Badge } from '@/components/ui/Badge';
import { Button } from '@/components/ui/Button';
import { Dialog, DialogContent, ConfirmDialog } from '@/components/ui/Dialog';
import { Spinner } from '@/components/ui/Spinner';
import { EmptyState, ErrorState } from '@/components/ui/EmptyState';
import {
  Table, TableHead, TableBody, TableRow, TableCell, TableHeadCell,
} from '@/components/ui/Table';
import { Pagination } from '@/components/ui/Pagination';
import { extractApiError } from '@/features/auth/AuthContext';
import { useToast } from '@/components/ui/Toast';
import { formatDate } from '@/utils/format';

const inputClass =
  'w-full rounded-md border border-gray-300 px-3 py-2 text-sm text-gray-900 placeholder-gray-400 focus:border-primary-500 focus:outline-none focus:ring-1 focus:ring-primary-500';
const labelClass = 'block text-sm font-medium text-gray-700 mb-1';
const fieldClass = 'space-y-1';

const ROLES: UserRole[] = ['STAFF', 'ADMIN'];

const defaultCreate: StaffCreateRequest = { name: '', email: '', password: '', role: 'STAFF' };

export function StaffPage() {
  const [page, setPage] = useState(1);
  const [createOpen, setCreateOpen] = useState(false);
  const [editTarget, setEditTarget] = useState<StaffUser | null>(null);
  const [deactivating, setDeactivating] = useState<number | null>(null);
  const [createForm, setCreateForm] = useState<StaffCreateRequest>(defaultCreate);
  const [createErr, setCreateErr] = useState<Record<string, string>>({});
  const [editForm, setEditForm] = useState<{ name: string; email: string; role: UserRole }>({
    name: '', email: '', role: 'STAFF',
  });
  const [editErr, setEditErr] = useState<Record<string, string>>({});

  const qc = useQueryClient();
  const { toast } = useToast();

  const { data, isLoading, error, refetch } = useQuery({
    queryKey: ['admin', 'staff', page],
    queryFn: () =>
      apiClient
        .get<PaginatedResponse<StaffUser>>(ENDPOINTS.ADMIN_STAFF, { params: { page, limit: 25 } })
        .then((r) => r.data),
    staleTime: 30_000,
  });

  const create = useMutation({
    mutationFn: (body: StaffCreateRequest) =>
      apiClient.post(ENDPOINTS.ADMIN_STAFF, body).then((r) => r.data),
    onSuccess: () => {
      setCreateOpen(false);
      setCreateForm(defaultCreate);
      setCreateErr({});
      toast('success', 'Staff account created');
      void qc.invalidateQueries({ queryKey: ['admin', 'staff'] });
    },
    onError: (err) => {
      const msg = extractApiError(err);
      if (msg.toLowerCase().includes('email')) {
        setCreateErr({ email: 'Email already registered.' });
      } else {
        toast('error', 'Could not create staff', msg);
      }
    },
  });

  const update = useMutation({
    mutationFn: ({ id, body }: { id: number; body: StaffUpdateRequest }) =>
      apiClient.put(ENDPOINTS.ADMIN_STAFF_BY_ID(id), body).then((r) => r.data),
    onSuccess: () => {
      setEditTarget(null);
      setEditErr({});
      toast('success', 'Staff account updated');
      void qc.invalidateQueries({ queryKey: ['admin', 'staff'] });
    },
    onError: (err) => {
      const msg = extractApiError(err);
      if (msg.toLowerCase().includes('email')) {
        setEditErr({ email: 'Email already in use.' });
      } else {
        toast('error', 'Could not update staff', msg);
      }
    },
  });

  const deactivate = useMutation({
    mutationFn: (id: number) =>
      apiClient.patch(ENDPOINTS.ADMIN_STAFF_DEACTIVATE(id)).then((r) => r.data),
    onSuccess: () => {
      setDeactivating(null);
      toast('success', 'Staff account deactivated');
      void qc.invalidateQueries({ queryKey: ['admin', 'staff'] });
    },
    onError: (err) => {
      setDeactivating(null);
      const msg = extractApiError(err);
      if (msg.toLowerCase().includes('self')) {
        toast('error', 'Cannot deactivate your own account');
      } else {
        toast('error', 'Deactivation failed', msg);
      }
    },
  });

  function openEdit(u: StaffUser) {
    setEditTarget(u);
    setEditForm({ name: u.name, email: u.email, role: u.role });
    setEditErr({});
  }

  function validateCreate(): boolean {
    const errs: Record<string, string> = {};
    if (!createForm.name.trim()) errs.name = 'Name is required.';
    if (!createForm.email.trim()) errs.email = 'Email is required.';
    if (!createForm.password) errs.password = 'Password is required.';
    else if (createForm.password.length < 6) errs.password = 'Password must be at least 6 characters.';
    setCreateErr(errs);
    return Object.keys(errs).length === 0;
  }

  function validateEdit(): boolean {
    const errs: Record<string, string> = {};
    if (editForm.name !== undefined && editForm.name.trim() === '') errs.name = 'Name cannot be empty.';
    if (editForm.email !== undefined && editForm.email.trim() === '') errs.email = 'Email cannot be empty.';
    setEditErr(errs);
    return Object.keys(errs).length === 0;
  }

  function submitCreate(e: React.FormEvent) {
    e.preventDefault();
    if (!validateCreate()) return;
    create.mutate(createForm);
  }

  function submitEdit(e: React.FormEvent) {
    e.preventDefault();
    if (!editTarget || !validateEdit()) return;
    const body: StaffUpdateRequest = {};
    if (editForm.name !== editTarget.name) body.name = editForm.name;
    if (editForm.email !== editTarget.email) body.email = editForm.email;
    if (editForm.role !== editTarget.role) body.role = editForm.role;
    update.mutate({ id: editTarget.id, body });
  }

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-xl font-semibold text-gray-900">Staff Accounts</h1>
          <p className="text-sm text-gray-500">Manage staff and admin users</p>
        </div>
        <Button size="sm" onClick={() => { setCreateForm(defaultCreate); setCreateErr({}); setCreateOpen(true); }}>
          <Plus className="h-4 w-4" />Add Staff
        </Button>
      </div>

      <Card padding="none">
        {isLoading ? (
          <div className="flex justify-center py-16"><Spinner /></div>
        ) : error ? (
          <ErrorState title="Could not load staff" message={extractApiError(error)} onRetry={() => void refetch()} />
        ) : !data?.data.length ? (
          <EmptyState title="No staff accounts" description="Create the first staff account using the Add Staff button." />
        ) : (
          <>
            <Table>
              <TableHead>
                <tr>
                  <TableHeadCell>Name</TableHeadCell>
                  <TableHeadCell>Email</TableHeadCell>
                  <TableHeadCell>Role</TableHeadCell>
                  <TableHeadCell>Status</TableHeadCell>
                  <TableHeadCell>Created</TableHeadCell>
                  <TableHeadCell>Actions</TableHeadCell>
                </tr>
              </TableHead>
              <TableBody>
                {data.data.map((u) => (
                  <TableRow key={u.id}>
                    <TableCell className="font-medium text-gray-900">{u.name}</TableCell>
                    <TableCell className="text-gray-500">{u.email}</TableCell>
                    <TableCell>
                      <Badge variant={u.role === 'ADMIN' ? 'danger' : 'info'}>{u.role}</Badge>
                    </TableCell>
                    <TableCell>
                      <Badge variant={u.status === 'ACTIVE' ? 'success' : 'neutral'}>{u.status}</Badge>
                    </TableCell>
                    <TableCell className="text-gray-500">{formatDate(u.created_at)}</TableCell>
                    <TableCell>
                      <div className="flex items-center gap-2">
                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={() => openEdit(u)}
                          aria-label={`Edit ${u.name}`}
                        >
                          <Pencil className="h-3.5 w-3.5" />
                        </Button>
                        {u.status === 'ACTIVE' && (
                          <Button
                            variant="ghost"
                            size="sm"
                            onClick={() => setDeactivating(u.id)}
                          >
                            Deactivate
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

      {/* Create Staff Dialog */}
      <Dialog open={createOpen} onOpenChange={(open) => !open && setCreateOpen(false)}>
        <DialogContent title="Add Staff Account" description="Create a new staff or admin user.">
          <form onSubmit={submitCreate} className="space-y-4 mt-2">
            <div className={fieldClass}>
              <label htmlFor="create-name" className={labelClass}>Full Name</label>
              <input
                id="create-name"
                type="text"
                className={inputClass}
                value={createForm.name}
                onChange={(e) => setCreateForm((f) => ({ ...f, name: e.target.value }))}
                placeholder="e.g. Ravi Kumar"
                autoComplete="off"
              />
              {createErr.name && <p className="text-xs text-red-600">{createErr.name}</p>}
            </div>
            <div className={fieldClass}>
              <label htmlFor="create-email" className={labelClass}>Email</label>
              <input
                id="create-email"
                type="email"
                className={inputClass}
                value={createForm.email}
                onChange={(e) => setCreateForm((f) => ({ ...f, email: e.target.value }))}
                placeholder="staff@thapar.edu"
                autoComplete="off"
              />
              {createErr.email && <p className="text-xs text-red-600">{createErr.email}</p>}
            </div>
            <div className={fieldClass}>
              <label htmlFor="create-password" className={labelClass}>Password</label>
              <input
                id="create-password"
                type="password"
                className={inputClass}
                value={createForm.password}
                onChange={(e) => setCreateForm((f) => ({ ...f, password: e.target.value }))}
                placeholder="Minimum 6 characters"
                autoComplete="new-password"
              />
              {createErr.password && <p className="text-xs text-red-600">{createErr.password}</p>}
            </div>
            <div className={fieldClass}>
              <label htmlFor="create-role" className={labelClass}>Role</label>
              <select
                id="create-role"
                className={inputClass}
                value={createForm.role}
                onChange={(e) => setCreateForm((f) => ({ ...f, role: e.target.value as UserRole }))}
              >
                {ROLES.map((r) => <option key={r} value={r}>{r}</option>)}
              </select>
            </div>
            <div className="flex justify-end gap-2 pt-2">
              <Button
                type="button"
                variant="secondary"
                onClick={() => setCreateOpen(false)}
                disabled={create.isPending}
              >
                Cancel
              </Button>
              <Button type="submit" loading={create.isPending}>
                Create
              </Button>
            </div>
          </form>
        </DialogContent>
      </Dialog>

      {/* Edit Staff Dialog */}
      <Dialog open={editTarget !== null} onOpenChange={(open) => !open && setEditTarget(null)}>
        <DialogContent title="Edit Staff Account" description="Update name, email, or role.">
          <form onSubmit={submitEdit} className="space-y-4 mt-2">
            <div className={fieldClass}>
              <label htmlFor="edit-name" className={labelClass}>Full Name</label>
              <input
                id="edit-name"
                type="text"
                className={inputClass}
                value={editForm.name}
                onChange={(e) => setEditForm((f) => ({ ...f, name: e.target.value }))}
              />
              {editErr.name && <p className="text-xs text-red-600">{editErr.name}</p>}
            </div>
            <div className={fieldClass}>
              <label htmlFor="edit-email" className={labelClass}>Email</label>
              <input
                id="edit-email"
                type="email"
                className={inputClass}
                value={editForm.email}
                onChange={(e) => setEditForm((f) => ({ ...f, email: e.target.value }))}
              />
              {editErr.email && <p className="text-xs text-red-600">{editErr.email}</p>}
            </div>
            <div className={fieldClass}>
              <label htmlFor="edit-role" className={labelClass}>Role</label>
              <select
                id="edit-role"
                className={inputClass}
                value={editForm.role}
                onChange={(e) => setEditForm((f) => ({ ...f, role: e.target.value as UserRole }))}
              >
                {ROLES.map((r) => <option key={r} value={r}>{r}</option>)}
              </select>
            </div>
            <div className="flex justify-end gap-2 pt-2">
              <Button
                type="button"
                variant="secondary"
                onClick={() => setEditTarget(null)}
                disabled={update.isPending}
              >
                Cancel
              </Button>
              <Button type="submit" loading={update.isPending}>
                Save
              </Button>
            </div>
          </form>
        </DialogContent>
      </Dialog>

      {/* Deactivate Confirm Dialog */}
      <ConfirmDialog
        open={deactivating !== null}
        onOpenChange={(open) => !open && setDeactivating(null)}
        title="Deactivate staff account?"
        description="The user will no longer be able to sign in. This action can be reversed by re-creating the account."
        confirmLabel="Deactivate"
        variant="danger"
        loading={deactivate.isPending}
        onConfirm={() => deactivating !== null && deactivate.mutate(deactivating)}
      />
    </div>
  );
}
