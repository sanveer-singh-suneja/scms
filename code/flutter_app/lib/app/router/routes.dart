abstract final class Routes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';

  // ── Student shell tabs ────────────────────────────────────────────────────
  static const studentHome = '/student/home';
  static const studentEquipment = '/student/equipment';
  static const studentQr = '/student/qr';
  static const studentBookings = '/student/bookings';
  static const studentProfile = '/student/profile';

  // ── Student full-screen routes (outside shell, push over tabs) ───────────
  static const studentHistory = '/student/history';
  static const studentNotifications = '/student/notifications';

  // ── Staff shell tabs ──────────────────────────────────────────────────────
  static const staffHome = '/staff/home';
  static const staffScan = '/staff/scan';
  static const staffQueue = '/staff/queue';
  static const staffInventory = '/staff/inventory';
  static const staffProfile = '/staff/profile';

  // ── Staff detail screens (outside shell, no bottom nav) ──────────────────
  static const staffValidate = '/staff/validate';
  static const staffIssue = '/staff/issue';
  static const staffReturn = '/staff/return';
}
