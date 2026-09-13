import 'package:freezed_annotation/freezed_annotation.dart';

part 'equipment_model.freezed.dart';
part 'equipment_model.g.dart';

@freezed
class EquipmentModel with _$EquipmentModel {
  const factory EquipmentModel({
    required int id,
    required String name,
    required String category,
    required String status,
    required String condition,
    String? location,
    String? notes,
    @JsonKey(name: 'qr_code') String? qrCode,
    @JsonKey(name: 'added_at') String? addedAt,
  }) = _EquipmentModel;

  factory EquipmentModel.fromJson(Map<String, dynamic> json) =>
      _$EquipmentModelFromJson(json);
}

@freezed
class SlotAvailability with _$SlotAvailability {
  const factory SlotAvailability({
    @JsonKey(name: 'slot_id') required int id,
    required String date,
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'end_time') required String endTime,
    required int capacity,
    @JsonKey(name: 'available_count') required int availableCount,
    required String status,
    @JsonKey(name: 'booking_cutoff_at') required String bookingCutoffAt,
  }) = _SlotAvailability;

  factory SlotAvailability.fromJson(Map<String, dynamic> json) =>
      _$SlotAvailabilityFromJson(json);
}
