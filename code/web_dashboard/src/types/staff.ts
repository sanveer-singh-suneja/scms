export type UserStatus = 'ACTIVE' | 'INACTIVE';
export type UserRole = 'STAFF' | 'ADMIN';

export interface StaffUser {
  id: number;
  name: string;
  email: string;
  role: UserRole;
  status: UserStatus;
  created_at: string;
}

export interface StaffCreateRequest {
  name: string;
  email: string;
  password: string;
  role: UserRole;
}

export interface StaffUpdateRequest {
  name?: string;
  email?: string;
  role?: UserRole;
}
