import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_model.freezed.dart';
part 'booking_model.g.dart';

@freezed
class BookingSlotInfo with _$BookingSlotInfo {
  const factory BookingSlotInfo({
    required int id,
    required String date,
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'end_time') required String endTime,
    @JsonKey(name: 'booking_cutoff_at') required String bookingCutoffAt,
  }) = _BookingSlotInfo;

  factory BookingSlotInfo.fromJson(Map<String, dynamic> json) =>
      _$BookingSlotInfoFromJson(json);
}

@freezed
class BookingEquipmentInfo with _$BookingEquipmentInfo {
  const factory BookingEquipmentInfo({
    required int id,
    required String name,
  }) = _BookingEquipmentInfo;

  factory BookingEquipmentInfo.fromJson(Map<String, dynamic> json) =>
      _$BookingEquipmentInfoFromJson(json);
}

@freezed
class BookingModel with _$BookingModel {
  const factory BookingModel({
    required int id,
    BookingSlotInfo? slot,
    BookingEquipmentInfo? equipment,
    required String status,
    @JsonKey(name: 'priority_score') double? priorityScore,
    @JsonKey(name: 'queue_position') int? queuePosition,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'allocated_at') String? allocatedAt,
    @JsonKey(name: 'booking_cutoff_at') String? bookingCutoffAt,
  }) = _BookingModel;

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);
}

@freezed
class QueuePosition with _$QueuePosition {
  const factory QueuePosition({
    @JsonKey(name: 'booking_id') required int bookingId,
    required String status,
    @JsonKey(name: 'queue_position') int? queuePosition,
    @JsonKey(name: 'total_waitlisted') int? totalWaitlisted,
  }) = _QueuePosition;

  factory QueuePosition.fromJson(Map<String, dynamic> json) =>
      _$QueuePositionFromJson(json);
}
