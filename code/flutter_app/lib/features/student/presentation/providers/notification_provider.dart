import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/auth_provider.dart';
import '../../data/notification_remote_source.dart';
import '../../domain/models/notification_model.dart';

final notificationRemoteSourceProvider = Provider<NotificationRemoteSource>((ref) {
  return NotificationRemoteSource(ref.read(dioProvider));
});

final unreadCountProvider = FutureProvider<int>((ref) {
  return ref.read(notificationRemoteSourceProvider).getUnreadCount();
});

final notificationListProvider =
    AsyncNotifierProvider<NotificationListNotifier, List<NotificationModel>>(
  NotificationListNotifier.new,
);

class NotificationListNotifier extends AsyncNotifier<List<NotificationModel>> {
  @override
  Future<List<NotificationModel>> build() async {
    final res = await ref.read(notificationRemoteSourceProvider).listNotifications(limit: 50);
    return res.data;
  }

  Future<void> markRead(int notificationId) async {
    await ref.read(notificationRemoteSourceProvider).markRead(notificationId);
    state = AsyncData(
      state.valueOrNull?.map((n) {
        if (n.id == notificationId) return n.copyWith(isRead: true);
        return n;
      }).toList() ?? [],
    );
    ref.invalidate(unreadCountProvider);
  }

  Future<void> markAllRead() async {
    await ref.read(notificationRemoteSourceProvider).markAllRead();
    state = AsyncData(
      state.valueOrNull?.map((n) => n.copyWith(isRead: true)).toList() ?? [],
    );
    ref.invalidate(unreadCountProvider);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    ref.invalidate(unreadCountProvider);
  }
}
