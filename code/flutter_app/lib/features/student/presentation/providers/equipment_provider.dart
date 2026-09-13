import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/auth_provider.dart';
import '../../data/equipment_remote_source.dart';
import '../../domain/models/equipment_model.dart';

final equipmentRemoteSourceProvider = Provider<EquipmentRemoteSource>((ref) {
  return EquipmentRemoteSource(ref.read(dioProvider));
});

// Equipment list — invalidate to refresh
final equipmentListProvider = FutureProvider.family<List<EquipmentModel>, String?>(
  (ref, category) async {
    final src = ref.read(equipmentRemoteSourceProvider);
    final res = await src.listEquipment(category: category, limit: 50);
    return res.data;
  },
);

final equipmentDetailProvider = FutureProvider.family<EquipmentModel, int>(
  (ref, id) => ref.read(equipmentRemoteSourceProvider).getEquipment(id),
);

final equipmentAvailabilityProvider =
    FutureProvider.family<List<SlotAvailability>, int>(
  (ref, equipmentId) =>
      ref.read(equipmentRemoteSourceProvider).getAvailability(equipmentId),
);
