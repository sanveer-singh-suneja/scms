import { describe, it, expect } from 'vitest';
import { formatDate, formatDateTime, formatTime } from '@/utils/format';

describe('format utilities', () => {
  it('formatDate returns dd MMM yyyy', () => {
    expect(formatDate('2024-09-13T10:00:00Z')).toBe('13 Sep 2024');
  });

  it('formatDateTime includes year and time separator', () => {
    const result = formatDateTime('2024-09-13T10:30:00Z');
    expect(result).toContain('2024');
    expect(result).toMatch(/\d{2}:\d{2}/);
  });

  it('formatTime converts 14:30:00 to 2:30 PM', () => {
    expect(formatTime('14:30:00')).toBe('2:30 PM');
  });

  it('formatTime converts 09:00 to 9:00 AM', () => {
    expect(formatTime('09:00')).toBe('9:00 AM');
  });

  it('formatTime converts 12:00 to 12:00 PM', () => {
    expect(formatTime('12:00')).toBe('12:00 PM');
  });
});
