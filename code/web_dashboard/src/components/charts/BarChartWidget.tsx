import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  Legend,
} from 'recharts';
import { Spinner } from '@/components/ui/Spinner';
import { ErrorState } from '@/components/ui/EmptyState';

interface BarChartWidgetProps {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  data: any[];
  bars: { key: string; label: string; color?: string }[];
  xKey: string;
  title: string;
  height?: number;
  isLoading?: boolean;
  error?: string;
}

const DEFAULT_COLORS = ['#0284c7', '#22c55e', '#f59e0b', '#ef4444', '#8b5cf6'];

export function BarChartWidget({
  data,
  bars,
  xKey,
  title,
  height = 280,
  isLoading,
  error,
}: BarChartWidgetProps) {
  return (
    <div className="rounded-lg border border-gray-200 bg-white p-5 shadow-card">
      <h3 className="mb-4 text-sm font-semibold text-gray-900">{title}</h3>
      {isLoading ? (
        <div className="flex items-center justify-center" style={{ height }}>
          <Spinner />
        </div>
      ) : error ? (
        <ErrorState title="Chart unavailable" message={error} />
      ) : (
        <ResponsiveContainer width="100%" height={height}>
          <BarChart data={data} margin={{ top: 4, right: 8, left: -8, bottom: 0 }}>
            <CartesianGrid strokeDasharray="3 3" stroke="#f3f4f6" />
            <XAxis
              dataKey={xKey}
              tick={{ fontSize: 11, fill: '#6b7280' }}
              axisLine={false}
              tickLine={false}
            />
            <YAxis
              tick={{ fontSize: 11, fill: '#6b7280' }}
              axisLine={false}
              tickLine={false}
              allowDecimals={false}
            />
            <Tooltip
              contentStyle={{
                borderRadius: '6px',
                border: '1px solid #e5e7eb',
                fontSize: '12px',
              }}
            />
            {bars.length > 1 && <Legend wrapperStyle={{ fontSize: '12px' }} />}
            {bars.map((bar, i) => (
              <Bar
                key={bar.key}
                dataKey={bar.key}
                name={bar.label}
                fill={bar.color ?? DEFAULT_COLORS[i % DEFAULT_COLORS.length]}
                radius={[3, 3, 0, 0]}
              />
            ))}
          </BarChart>
        </ResponsiveContainer>
      )}
    </div>
  );
}
