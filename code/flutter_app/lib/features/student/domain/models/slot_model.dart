import 'package:freezed_annotation/freezed_annotation.dart';

part 'slot_model.freezed.dart';
part 'slot_model.g.dart';

@freezed
class SlotModel with _$SlotModel {
  const factory SlotModel({
    required int id,
    @JsonKey(name: 'equipment_id') required int equipmentId,
    @JsonKey(name: 'equipment_name') String? equipmentName,
    required String date,
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'end_time') required String endTime,
    required int capacity,
    @JsonKey(name: 'available_count') required int availableCount,
    required String status,
    @JsonKey(name: 'booking_cutoff_at') required String bookingCutoffAt,
    @JsonKey(name: 'allocation_run_at') String? allocationRunAt,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _SlotModel;

  factory SlotModel.fromJson(Map<String, dynamic> json) =>
      _$SlotModelFromJson(json);
}
