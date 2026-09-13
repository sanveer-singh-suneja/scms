import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/widgets/empty_state.dart';
import '../../../../app/widgets/error_state.dart';
import '../../domain/models/notification_model.dart';
import '../providers/notification_provider.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifAsync = ref.watch(notificationListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          notifAsync.when(
            data: (notifs) => notifs.any((n) => !n.isRead)
                ? TextButton(
                    onPressed: () =>
                        ref.read(notificationListProvider.notifier).markAllRead(),
                    child: const Text('Mark all read',
                        style: TextStyle(color: Colors.white)),
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: notifAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorState(
          message: 'Could not load notifications',
          onRetry: () => ref.invalidate(notificationListProvider),
        ),
        data: (notifs) {
          if (notifs.isEmpty) {
            return const EmptyState(
              icon: Icons.notifications_none,
              message: 'No notifications yet.',
            );
          }
          return RefreshIndicator(
            onRefresh: () =>
                ref.read(notificationListProvider.notifier).refresh(),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: notifs.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (_, i) => _NotifTile(notif: notifs[i]),
            ),
          );
        },
      ),
    );
  }
}

class _NotifTile extends ConsumerWidget {
  const _NotifTile({required this.notif});
  final NotificationModel notif;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      tileColor: notif.isRead ? null : AppColors.primary.withValues(alpha: 0.04),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _typeColor(notif.type).withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(_typeIcon(notif.type),
            color: _typeColor(notif.type), size: 18),
      ),
      title: Text(
        notif.title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight:
                  notif.isRead ? FontWeight.normal : FontWeight.w600,
            ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notif.message,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            notif.createdAt.split('T').first,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.textHint),
          ),
        ],
      ),
      trailing: notif.isRead
          ? null
          : Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
      onTap: () {
        if (!notif.isRead) {
          ref.read(notificationListProvider.notifier).markRead(notif.id);
        }
      },
    );
  }

  Color _typeColor(String t) => switch (t) {
        'BOOKING_CONFIRMED' => AppColors.statusConfirmed,
        'BOOKING_WAITLISTED' => AppColors.statusWaitlisted,
        'BOOKING_CANCELLED' => AppColors.statusCancelled,
        'RETURN_REMINDER' => AppColors.warning,
        'SLOT_ALLOCATED' => AppColors.success,
        _ => AppColors.info,
      };

  IconData _typeIcon(String t) => switch (t) {
        'BOOKING_CONFIRMED' => Icons.check_circle_outline,
        'BOOKING_WAITLISTED' => Icons.people_outline,
        'BOOKING_CANCELLED' => Icons.cancel_outlined,
        'RETURN_REMINDER' => Icons.timer_outlined,
        'SLOT_ALLOCATED' => Icons.sports,
        _ => Icons.notifications_outlined,
      };
}
