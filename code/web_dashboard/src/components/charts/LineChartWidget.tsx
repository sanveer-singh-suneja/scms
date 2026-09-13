import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  Legend,
} from 'recharts';
import { Spinner } from '@/components/ui/Spinner';
import { ErrorState } from '@/components/ui/EmptyState';

interface LineChartWidgetProps {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  data: any[];
  lines: { key: string; label: string; color?: string }[];
  xKey: string;
  title: string;
  height?: number;
  isLoading?: boolean;
  error?: string;
}

const DEFAULT_COLORS = ['#0284c7', '#22c55e', '#f59e0b'];

export function LineChartWidget({
  data,
  lines,
  xKey,
  title,
  height = 280,
  isLoading,
  error,
}: LineChartWidgetProps) {
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
          <LineChart data={data} margin={{ top: 4, right: 8, left: -8, bottom: 0 }}>
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
            {lines.length > 1 && <Legend wrapperStyle={{ fontSize: '12px' }} />}
            {lines.map((line, i) => (
              <Line
                key={line.key}
                type="monotone"
                dataKey={line.key}
                name={line.label}
                stroke={line.color ?? DEFAULT_COLORS[i % DEFAULT_COLORS.length]}
                strokeWidth={2}
                dot={false}
                activeDot={{ r: 4 }}
              />
            ))}
          </LineChart>
        </ResponsiveContainer>
      )}
    </div>
  );
}
