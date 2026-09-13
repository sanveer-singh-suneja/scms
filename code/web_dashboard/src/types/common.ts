export interface ApiError {
  code: string;
  message: string;
}

export interface ApiResponse<T> {
  success: boolean;
  data: T;
}

// Mirrors backend StandardResponse.list_ok — uses `limit` and `totalPages`.
export interface PaginatedResponse<T> {
  success: boolean;
  data: T[];
  pagination: {
    total: number;
    page: number;
    limit: number;
    totalPages: number;
  };
}

// UI Pagination component shape (perPage is the display alias for limit).
export interface Pagination {
  page: number;
  perPage: number;
  total: number;
  totalPages: number;
}

export type SortDirection = 'asc' | 'desc';

export interface TableSort {
  key: string;
  direction: SortDirection;
}

export interface TableFilters {
  [key: string]: string | number | boolean | undefined;
}
