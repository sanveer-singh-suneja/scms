import type { EquipmentCondition } from './equipment';

export type TransactionStatus = 'ISSUED' | 'RETURNED' | 'RETURNED_DAMAGED' | 'OVERDUE';
export type DefaulterStatus = 'ACTIVE' | 'NOTIFIED' | 'RESOLVED';

export interface Transaction {
  id: number;
  booking_id?: number;
  student_id: number;
  equipment_id: number;
  equipment_name?: string;
  issued_by: number;
  issued_at: string;
  due_at: string;
  returned_at?: string;
  condition_on_return?: EquipmentCondition;
  damage_report?: string;
  status: TransactionStatus;
  returned_to?: number;
}

export interface Defaulter {
  id: number;
  student_id: number;
  student_name?: string;
  transaction_id: number;
  overdue_days: number;
  status: DefaulterStatus;
  detected_at: string;
  resolved_at?: string;
}
