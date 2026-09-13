import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/domain/auth_models.dart';
import '../../features/auth/presentation/auth_provider.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/staff/domain/models/qr_validation_model.dart';
import '../../features/staff/presentation/screens/issue_confirm_screen.dart';
import '../../features/staff/presentation/screens/return_process_screen.dart';
import '../../features/staff/presentation/screens/staff_home_screen.dart';
import '../../features/staff/presentation/screens/staff_inventory_screen.dart';
import '../../features/staff/presentation/screens/staff_profile_screen.dart';
import '../../features/staff/presentation/screens/staff_queue_screen.dart';
import '../../features/staff/presentation/screens/staff_scan_screen.dart';
import '../../features/staff/presentation/screens/staff_shell.dart';
import '../../features/staff/presentation/screens/student_validation_screen.dart';
import '../../features/student/presentation/screens/booking_detail_screen.dart';
import '../../features/student/presentation/screens/bookings_screen.dart';
import '../../features/student/presentation/screens/equipment_detail_screen.dart';
import '../../features/student/presentation/screens/equipment_list_screen.dart';
import '../../features/student/presentation/screens/history_screen.dart';
import '../../features/student/presentation/screens/notifications_screen.dart';
import '../../features/student/presentation/screens/profile_screen.dart';
import '../../features/student/presentation/screens/student_home_screen.dart';
import '../../features/student/presentation/screens/student_shell.dart';
import '../../features/student/presentation/screens/transaction_detail_screen.dart';
import '../../features/qr/presentation/screens/student_qr_screen.dart';
import 'routes.dart';

// ── RouterNotifier: triggers redirect evaluation on auth changes ───────────────

class _RouterNotifier extends ChangeNotifier {
  _RouterNotifier(this._ref) {
    _ref.listen<AsyncValue<AuthUser?>>(authProvider, (_, _) {
      notifyListeners();
    });
  }

  final Ref _ref;
}

final routerNotifierProvider = Provider<_RouterNotifier>((ref) {
  return _RouterNotifier(ref);
});

// ── GoRouter ──────────────────────────────────────────────────────────────────

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider);

  return GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: notifier,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isLoading = authState.isLoading;
      final user = authState.valueOrNull;
      final loc = state.matchedLocation;

      if (isLoading) return null;

      final isPublic = loc == Routes.splash ||
          loc == Routes.login ||
          loc == Routes.register;

      // Not logged in → send to login
      if (user == null && !isPublic) return Routes.login;

      // Already logged in → redirect away from public pages
      if (user != null && isPublic && loc != Routes.splash) {
        return user.role == 'STUDENT' ? Routes.studentHome : Routes.staffHome;
      }

      // Role-based route protection
      if (user != null) {
        final isStaffRoute = loc.startsWith('/staff/');
        final isStudentRoute = loc.startsWith('/student/');
        if (isStaffRoute && user.role == 'STUDENT') {
          return Routes.studentHome;
        }
        if (isStudentRoute &&
            (user.role == 'STAFF' || user.role == 'ADMIN')) {
          return Routes.staffHome;
        }
      }

      return null;
    },
    routes: [
      // ── Public ──────────────────────────────────────────────────────────
      GoRoute(
        path: Routes.splash,
        builder: (_, _) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (_, _) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.register,
        builder: (_, _) => const RegisterScreen(),
      ),

      // ── Student shell (bottom nav) ───────────────────────────────────────
      ShellRoute(
        builder: (_, _, child) => StudentShell(child: child),
        routes: [
          GoRoute(
            path: Routes.studentHome,
            builder: (_, _) => const StudentHomeScreen(),
          ),
          GoRoute(
            path: Routes.studentEquipment,
            builder: (_, _) => const EquipmentListScreen(),
          ),
          GoRoute(
            path: Routes.studentQr,
            builder: (_, _) => const StudentQrScreen(),
          ),
          GoRoute(
            path: Routes.studentBookings,
            builder: (_, _) => const BookingsScreen(),
          ),
          GoRoute(
            path: Routes.studentProfile,
            builder: (_, _) => const ProfileScreen(),
          ),
        ],
      ),

      // ── Student detail / full-page screens (no bottom nav) ──────────────
      GoRoute(
        path: '/student/equipment/:id',
        builder: (_, state) => EquipmentDetailScreen(
          equipmentId: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: '/student/bookings/:id',
        builder: (_, state) => BookingDetailScreen(
          bookingId: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: Routes.studentHistory,
        builder: (_, _) => const HistoryScreen(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (_, state) => TransactionDetailScreen(
              transactionId: int.parse(state.pathParameters['id']!),
            ),
          ),
        ],
      ),
      GoRoute(
        path: Routes.studentNotifications,
        builder: (_, _) => const NotificationsScreen(),
      ),

      // ── Staff shell (bottom nav) ─────────────────────────────────────────
      ShellRoute(
        builder: (_, _, child) => StaffShell(child: child),
        routes: [
          GoRoute(
            path: Routes.staffHome,
            builder: (_, _) => const StaffHomeScreen(),
          ),
          GoRoute(
            path: Routes.staffScan,
            builder: (_, _) => const StaffScanScreen(),
          ),
          GoRoute(
            path: Routes.staffQueue,
            builder: (_, _) => const StaffQueueScreen(),
          ),
          GoRoute(
            path: Routes.staffInventory,
            builder: (_, _) => const StaffInventoryScreen(),
          ),
          GoRoute(
            path: Routes.staffProfile,
            builder: (_, _) => const StaffProfileScreen(),
          ),
        ],
      ),

      // ── Staff detail screens (no bottom nav) ─────────────────────────────
      GoRoute(
        path: Routes.staffValidate,
        builder: (_, state) =>
            StudentValidationScreen(result: state.extra as QrValidationResult),
      ),
      GoRoute(
        path: Routes.staffIssue,
        builder: (_, state) =>
            IssueConfirmScreen(result: state.extra as QrValidationResult),
      ),
      GoRoute(
        path: Routes.staffReturn,
        builder: (_, state) =>
            ReturnProcessScreen(transaction: state.extra as QrTransactionInfo),
      ),
    ],
  );
});
