import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/auth_provider.dart';
import '../../../student/domain/models/equipment_model.dart';
import '../../data/staff_remote_source.dart';
import '../../domain/models/staff_queue_model.dart';

final staffRemoteSourceProvider = Provider<StaffRemoteSource>((ref) {
  return StaffRemoteSource(ref.read(dioProvider));
});

// ── Staff queue ───────────────────────────────────────────────────────────────

class StaffQueueNotifier extends AsyncNotifier<StaffQueueModel> {
  @override
  Future<StaffQueueModel> build() {
    return ref.read(staffRemoteSourceProvider).getQueue();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(staffRemoteSourceProvider).getQueue(),
    );
  }
}

final staffQueueProvider =
    AsyncNotifierProvider<StaffQueueNotifier, StaffQueueModel>(
  StaffQueueNotifier.new,
);

// ── Staff inventory ───────────────────────────────────────────────────────────

class StaffInventoryNotifier extends AsyncNotifier<List<EquipmentModel>> {
  String? _category;

  @override
  Future<List<EquipmentModel>> build() async {
    final resp = await ref.read(staffRemoteSourceProvider).getInventory();
    return resp.data;
  }

  Future<void> filterByCategory(String? category) async {
    _category = category;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final resp = await ref
          .read(staffRemoteSourceProvider)
          .getInventory(category: _category);
      return resp.data;
    });
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final resp = await ref
          .read(staffRemoteSourceProvider)
          .getInventory(category: _category);
      return resp.data;
    });
  }
}

final staffInventoryProvider =
    AsyncNotifierProvider<StaffInventoryNotifier, List<EquipmentModel>>(
  StaffInventoryNotifier.new,
);
