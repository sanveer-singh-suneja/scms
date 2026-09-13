import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/widgets/app_card.dart';
import '../../../../app/widgets/empty_state.dart';
import '../../../../app/widgets/error_state.dart';
import '../../../../app/widgets/status_badge.dart';
import '../../../auth/presentation/auth_provider.dart';
import '../providers/booking_provider.dart';
import '../providers/notification_provider.dart';
import '../providers/student_provider.dart';
import '../../domain/models/booking_model.dart';

class StudentHomeScreen extends ConsumerWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final activeBookings = ref.watch(activeBookingsProvider);
    final unreadCount = ref.watch(unreadCountProvider).valueOrNull ?? 0;
    final stats = ref.watch(usageStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good ${_greeting()}, ${user?.name.split(' ').first ?? ''}',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
            ),
            const Text(
              'SCMS',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 11,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                onPressed: () => context.go(Routes.studentNotifications),
              ),
              if (unreadCount > 0)
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(activeBookingsProvider);
          ref.invalidate(unreadCountProvider);
          ref.invalidate(usageStatsProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Stats row
            _StatsRow(stats: stats),
            const SizedBox(height: 20),

            // Quick actions
            Text('Quick Actions',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            _QuickActionsGrid(),
            const SizedBox(height: 20),

            // Active bookings
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('My Bookings',
                    style: Theme.of(context).textTheme.titleMedium),
                TextButton(
                  onPressed: () => context.go(Routes.studentBookings),
                  child: const Text('See all'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            activeBookings.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (e, _) => ErrorState(
                message: 'Could not load bookings',
                onRetry: () => ref.invalidate(activeBookingsProvider),
              ),
              data: (bookings) {
                if (bookings.isEmpty) {
                  return EmptyState(
                    icon: Icons.bookmark_border,
                    message: 'No active bookings.\nBrowse equipment to book a slot.',
                    action: () => context.go(Routes.studentEquipment),
                    actionLabel: 'Browse Equipment',
                  );
                }
                return Column(
                  children: bookings
                      .take(3)
                      .map((b) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _BookingCard(booking: b),
                          ))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'morning';
    if (h < 17) return 'afternoon';
    return 'evening';
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.stats});
  final AsyncValue stats;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'Sessions (7 days)',
            value: stats.when(
              loading: () => '—',
              error: (_, _) => '—',
              data: (s) => '${s.sessionsLast7Days}',
            ),
            icon: Icons.trending_up,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            label: 'Total Sessions',
            value: stats.when(
              loading: () => '—',
              error: (_, _) => '—',
              data: (s) => '${s.totalSessions}',
            ),
            icon: Icons.sports,
            color: AppColors.accent,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActionsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final actions = [
      _Action('Book Equipment', Icons.add_circle_outline, AppColors.primary,
          () => context.go(Routes.studentEquipment)),
      _Action('My QR Code', Icons.qr_code, AppColors.accent,
          () => context.go(Routes.studentQr)),
      _Action('History', Icons.history, AppColors.info,
          () => context.go(Routes.studentHistory)),
      _Action('Notifications', Icons.notifications_outlined, AppColors.success,
          () => context.go(Routes.studentNotifications)),
    ];

    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 8,
      mainAxisSpacing: 4,
      children: actions.map((a) => _QuickAction(action: a)).toList(),
    );
  }
}

class _Action {
  const _Action(this.label, this.icon, this.color, this.onTap);
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.action});
  final _Action action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: action.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: action.color.withValues(alpha: 0.25)),
            ),
            child: Icon(action.icon, color: action.color, size: 24),
          ),
          const SizedBox(height: 6),
          Text(
            action.label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  const _BookingCard({required this.booking});
  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => context.go('${Routes.studentBookings}/${booking.id}'),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.sports, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.equipment?.name ?? 'Equipment',
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (booking.slot != null)
                  Text(
                    '${booking.slot!.date}  ${booking.slot!.startTime} – ${booking.slot!.endTime}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          StatusBadge.bookingStatus(booking.status),
        ],
      ),
    );
  }
}
