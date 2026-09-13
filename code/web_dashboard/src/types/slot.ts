// Mirrors backend app/schemas/slot.py exactly.

export type SlotStatus = 'OPEN' | 'PENDING_ALLOCATION' | 'FULL' | 'CLOSED';

export interface Slot {
  id: number;
  equipment_id: number;
  equipment_name: string | null;
  date: string;
  start_time: string;
  end_time: string;
  capacity: number;
  available_count: number;
  booking_cutoff_at: string;
  allocation_run_at: string | null;
  status: SlotStatus;
  created_at: string;
}

export interface SlotCreateRequest {
  equipment_id: number;
  date: string;
  start_time: string;
  end_time: string;
  capacity: number;
  booking_cutoff_at: string;
}

export interface SlotUpdateRequest {
  date?: string;
  start_time?: string;
  end_time?: string;
  capacity?: number;
  booking_cutoff_at?: string;
}

export interface AllocationResult {
  slot_id: number;
  allocation_run_at: string | null;
  confirmed_count: number;
  waitlisted_count: number;
  slot_status: SlotStatus;
}

export interface DeactivateResult {
  id: number;
  status: SlotStatus;
  cancelled_bookings: number;
}
