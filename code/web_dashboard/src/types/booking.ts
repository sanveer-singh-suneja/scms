export type BookingStatus =
  | 'REQUESTED'
  | 'CONFIRMED'
  | 'WAITLISTED'
  | 'CANCELLED'
  | 'NO_SHOW'
  | 'COMPLETED';

export interface Booking {
  id: number;
  student_id: number;
  slot_id: number;
  equipment_id: number;
  status: BookingStatus;
  queue_position?: number;
  priority_score?: number | string;
  created_at: string;
  allocated_at?: string;
}

// Slot types moved to src/types/slot.ts — re-exported for backward compat.
export type { SlotStatus, Slot } from './slot';
