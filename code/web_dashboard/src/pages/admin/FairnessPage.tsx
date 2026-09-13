import { useEffect, useState } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { apiClient } from '@/api/client';
import { ENDPOINTS } from '@/api/endpoints';
import type { FairnessConfig } from '@/types/analytics';
import type { ApiResponse } from '@/types/common';
import { Card, CardHeader, CardTitle } from '@/components/ui/Card';
import { Button } from '@/components/ui/Button';
import { Input } from '@/components/ui/Input';
import { Spinner } from '@/components/ui/Spinner';
import { ErrorState } from '@/components/ui/EmptyState';
import { extractApiError } from '@/features/auth/AuthContext';
import { useToast } from '@/components/ui/Toast';
import { formatDateTime } from '@/utils/format';

export function FairnessPage() {
  const qc = useQueryClient();
  const { toast } = useToast();

  const { data, isLoading, error } = useQuery({
    queryKey: ['admin', 'fairness-config'],
    queryFn: () =>
      apiClient
        .get<ApiResponse<FairnessConfig>>(ENDPOINTS.FAIRNESS_CONFIG)
        .then((r) => r.data.data),
  });

  const [form, setForm] = useState({ daily_usage_cap: 2, recency_threshold_days: 2, recency_weight: 0.50 });

  useEffect(() => {
    if (data) {
      setForm({
        daily_usage_cap: data.daily_usage_cap,
        recency_threshold_days: data.recency_threshold_days,
        recency_weight: data.recency_weight,
      });
    }
  }, [data]);

  const update = useMutation({
    mutationFn: (values: typeof form) =>
      apiClient.put<ApiResponse<FairnessConfig>>(ENDPOINTS.FAIRNESS_CONFIG, values).then((r) => r.data.data),
    onSuccess: () => {
      toast('success', 'Fairness config updated');
      void qc.invalidateQueries({ queryKey: ['admin', 'fairness-config'] });
    },
    onError: (err) => {
      toast('error', 'Update failed', extractApiError(err));
    },
  });

  if (isLoading) return <div className="flex justify-center py-20"><Spinner size="lg" /></div>;
  if (error) return <ErrorState title="Could not load fairness config" message={extractApiError(error)} />;

  return (
    <div className="space-y-6 max-w-lg">
      <div>
        <h1 className="text-xl font-semibold text-gray-900">Fairness Configuration</h1>
        <p className="text-sm text-gray-500">Configure the batch allocation fairness parameters</p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Allocation Parameters</CardTitle>
          {data && (
            <div className="text-xs text-gray-400 space-y-0.5">
              <p>Last updated {formatDateTime(data.updated_at)}</p>
              {data.updated_by !== null && (
                <p>Last updated by staff #{data.updated_by}</p>
              )}
            </div>
          )}
        </CardHeader>

        <form
          onSubmit={(e) => {
            e.preventDefault();
            update.mutate(form);
          }}
          className="space-y-4"
        >
          <Input
            label="Daily Usage Cap"
            type="number"
            min={1}
            max={10}
            value={form.daily_usage_cap}
            onChange={(e) => setForm((f) => ({ ...f, daily_usage_cap: parseInt(e.target.value) || 1 }))}
            hint="Maximum sessions per student per day"
          />
          <Input
            label="Recency Threshold (days)"
            type="number"
            min={1}
            max={30}
            value={form.recency_threshold_days}
            onChange={(e) => setForm((f) => ({ ...f, recency_threshold_days: parseInt(e.target.value) || 7 }))}
            hint="Days of inactivity that boost priority"
          />
          <Input
            label="Recency Weight"
            type="number"
            min={0}
            max={1}
            step={0.05}
            value={form.recency_weight}
            onChange={(e) => setForm((f) => ({ ...f, recency_weight: parseFloat(e.target.value) || 0 }))}
            hint="Weight applied to recency component of priority score (0–1)"
          />
          <div className="pt-2">
            <Button type="submit" loading={update.isPending}>
              Save Configuration
            </Button>
          </div>
        </form>
      </Card>

      <Card>
        <CardTitle>Formula Reference</CardTitle>
        <div className="mt-3 space-y-2 text-sm text-gray-600">
          <p><code className="text-xs bg-gray-100 px-1 rounded">priority_score = S_norm + P_recency</code></p>
          <p>Lower score = higher allocation priority.</p>
          <p><code className="text-xs bg-gray-100 px-1 rounded">S_norm</code> = sessions_7d / max(max_in_batch, 1)</p>
          <p><code className="text-xs bg-gray-100 px-1 rounded">P_recency</code> = max(0, (threshold - days_since_last) × weight)</p>
          <p className="text-xs text-gray-400 pt-1">Backend is the sole executor of allocation. This config only adjusts parameters.</p>
        </div>
      </Card>
    </div>
  );
}
