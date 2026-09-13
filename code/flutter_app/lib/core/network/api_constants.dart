abstract final class ApiEndpoints {
  static const String studentRegister = '/api/auth/student/register';
  static const String studentLogin = '/api/auth/student/login';
  static const String staffLogin = '/api/auth/staff/login';
  static const String authMe = '/api/auth/me';
  static const String authMeStaff = '/api/auth/me/staff';

  static const String studentQr = '/api/students/qr';
  static const String usageStats = '/api/students/usage-stats';

  static const String equipment = '/api/equipment';
  static String equipmentById(int id) => '/api/equipment/$id';
  static String equipmentAvailability(int id) => '/api/equipment/$id/availability';

  static const String slots = '/api/slots';
  static String slotById(int id) => '/api/slots/$id';

  static const String bookings = '/api/bookings';
  static String bookingById(int id) => '/api/bookings/$id';
  static String bookingQueuePosition(int id) => '/api/bookings/$id/queue-position';
  static String bookingPriority(int id) => '/api/bookings/$id/priority';

  static const String qrValidateStudent = '/api/qr/validate/student';
  static const String qrValidateEquipment = '/api/qr/validate/equipment';

  static const String transactionIssue = '/api/transactions/issue';
  static String transactionReturn(int id) => '/api/transactions/$id/return';
  static const String transactions = '/api/transactions';
  static String transactionById(int id) => '/api/transactions/$id';
  static String transactionDamage(int id) => '/api/transactions/$id/damage';

  static const String notifications = '/api/notifications';
  static const String notificationsUnreadCount = '/api/notifications/unread-count';
  static const String notificationsMarkAllRead = '/api/notifications/mark-all-read';
  static String notificationRead(int id) => '/api/notifications/$id/read';

  static const String staffQueue = '/api/staff/queue';
  static const String inventory = '/api/inventory';
}
