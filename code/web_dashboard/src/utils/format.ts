import { format, formatDistanceToNow, parseISO } from 'date-fns';

export function formatDate(iso: string): string {
  return format(parseISO(iso), 'dd MMM yyyy');
}

export function formatDateTime(iso: string): string {
  return format(parseISO(iso), 'dd MMM yyyy, HH:mm');
}

export function formatTime(timeStr: string): string {
  const [h, m] = timeStr.split(':');
  const hour = parseInt(h, 10);
  const ampm = hour >= 12 ? 'PM' : 'AM';
  const display = hour % 12 || 12;
  return `${display}:${m} ${ampm}`;
}

export function formatHour(hour: number): string {
  const ampm = hour >= 12 ? 'PM' : 'AM';
  const display = hour % 12 || 12;
  return `${display}${ampm}`;
}

export function formatRelative(iso: string): string {
  return formatDistanceToNow(parseISO(iso), { addSuffix: true });
}

export function formatSlotDate(date: string, start: string, end: string): string {
  return `${format(parseISO(date), 'dd MMM yyyy')} · ${formatTime(start)} – ${formatTime(end)}`;
}

export function shortDate(iso: string): string {
  return format(parseISO(iso), 'MMM d');
}
