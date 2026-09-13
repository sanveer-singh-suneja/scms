export const ENDPOINTS = {
  // Auth
  STAFF_LOGIN: '/auth/staff/login',
  AUTH_ME_STAFF: '/auth/me/staff',

  // Inventory (admin write, staff read)
  INVENTORY: '/inventory',
  INVENTORY_BY_ID: (id: number) => `/inventory/${id}`,
  INVENTORY_RETIRE: (id: number) => `/inventory/${id}/retire`,

  // Equipment (read)
  EQUIPMENT: '/equipment',
  EQUIPMENT_BY_ID: (id: number) => `/equipment/${id}`,
  EQUIPMENT_AVAILABILITY: (id: number) => `/equipment/${id}/availability`,

  // Slots (admin)
  ADMIN_SLOTS: '/admin/slots',
  ADMIN_SLOT_BY_ID: (id: number) => `/admin/slots/${id}`,
  ADMIN_SLOT_DEACTIVATE: (id: number) => `/admin/slots/${id}/deactivate`,
  ADMIN_SLOT_RUN_ALLOCATION: (id: number) => `/admin/slots/${id}/run-allocation`,

  // Bookings
  BOOKINGS: '/bookings',
  BOOKING_BY_ID: (id: number) => `/bookings/${id}`,
  ADMIN_BOOKINGS: '/admin/bookings',

  // Transactions
  TRANSACTIONS: '/transactions',
  TRANSACTION_BY_ID: (id: number) => `/transactions/${id}`,
  TRANSACTION_RETURN: (id: number) => `/transactions/${id}/return`,
  ADMIN_TRANSACTIONS: '/admin/transactions',

  // Admin — Defaulters
  ADMIN_DEFAULTERS: '/admin/defaulters',
  ADMIN_DEFAULTER_BY_ID: (id: number) => `/admin/defaulters/${id}`,
  ADMIN_DEFAULTER_RESOLVE: (id: number) => `/admin/defaulters/${id}/resolve`,

  // Admin — Analytics
  ANALYTICS_OVERVIEW: '/admin/analytics/overview',
  ANALYTICS_EQUIPMENT: '/admin/analytics/equipment',
  ANALYTICS_BOOKINGS: '/admin/analytics/bookings',
  ANALYTICS_USAGE_TRENDS: '/admin/analytics/usage-trends',
  ANALYTICS_PEAK_HOURS: '/admin/analytics/peak-hours',
  ANALYTICS_DAMAGE_STATS: '/admin/analytics/damage-stats',

  // Admin — Fairness config
  FAIRNESS_CONFIG: '/admin/fairness-config',

  // Admin — Staff management
  ADMIN_STAFF: '/admin/staff',
  ADMIN_STAFF_BY_ID: (id: number) => `/admin/staff/${id}`,
  ADMIN_STAFF_DEACTIVATE: (id: number) => `/admin/staff/${id}/deactivate`,

  // Staff — Queue
  STAFF_QUEUE: '/staff/queue',

  // QR
  QR_VALIDATE_STUDENT: '/qr/validate/student',
  QR_VALIDATE_EQUIPMENT: '/qr/validate/equipment',
} as const;
