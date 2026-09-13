// Mirrors backend app/schemas/equipment.py and app/models/enums.py exactly.

export type EquipmentStatus = 'AVAILABLE' | 'BOOKED' | 'ISSUED' | 'MAINTENANCE' | 'RETIRED';
export type EquipmentCondition = 'GOOD' | 'FAIR' | 'DAMAGED';

export interface Equipment {
  id: number;
  name: string;
  category: string;
  qr_code: string;
  status: EquipmentStatus;
  condition: EquipmentCondition;
  location: string | null;
  notes: string | null;
  added_at: string;
}

export interface EquipmentCreateRequest {
  name: string;
  category: string;
  qr_code: string;
  location?: string;
  notes?: string;
}

export interface EquipmentUpdateRequest {
  name?: string;
  category?: string;
  location?: string;
  notes?: string;
  status?: EquipmentStatus;
  condition?: EquipmentCondition;
}
