import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_queue_model.freezed.dart';
part 'staff_queue_model.g.dart';

@freezed
class QueueStudentRef with _$QueueStudentRef {
  const factory QueueStudentRef({
    required int id,
    required String name,
    @JsonKey(name: 'student_id') String? studentId,
  }) = _QueueStudentRef;

  factory QueueStudentRef.fromJson(Map<String, dynamic> json) =>
      _$QueueStudentRefFromJson(json);
}

@freezed
class QueueEquipmentRef with _$QueueEquipmentRef {
  const factory QueueEquipmentRef({
    required int id,
    required String name,
  }) = _QueueEquipmentRef;

  factory QueueEquipmentRef.fromJson(Map<String, dynamic> json) =>
      _$QueueEquipmentRefFromJson(json);
}

@freezed
class QueueSlotRef with _$QueueSlotRef {
  const factory QueueSlotRef({
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'end_time') required String endTime,
  }) = _QueueSlotRef;

  factory QueueSlotRef.fromJson(Map<String, dynamic> json) =>
      _$QueueSlotRefFromJson(json);
}

@freezed
class StaffBookingEntry with _$StaffBookingEntry {
  const factory StaffBookingEntry({
    @JsonKey(name: 'booking_id') required int bookingId,
    required QueueStudentRef student,
    required QueueEquipmentRef equipment,
    required QueueSlotRef slot,
    required String status,
  }) = _StaffBookingEntry;

  factory StaffBookingEntry.fromJson(Map<String, dynamic> json) =>
      _$StaffBookingEntryFromJson(json);
}

@freezed
class StaffTransactionEntry with _$StaffTransactionEntry {
  const factory StaffTransactionEntry({
    @JsonKey(name: 'transaction_id') required int transactionId,
    required QueueStudentRef student,
    required QueueEquipmentRef equipment,
    @JsonKey(name: 'issued_at') required String issuedAt,
    @JsonKey(name: 'due_at') required String dueAt,
    required String status,
  }) = _StaffTransactionEntry;

  factory StaffTransactionEntry.fromJson(Map<String, dynamic> json) =>
      _$StaffTransactionEntryFromJson(json);
}

@freezed
class StaffQueueModel with _$StaffQueueModel {
  const factory StaffQueueModel({
    @JsonKey(name: 'confirmed_bookings_today')
    required List<StaffBookingEntry> confirmedBookingsToday,
    @JsonKey(name: 'open_transactions')
    required List<StaffTransactionEntry> openTransactions,
  }) = _StaffQueueModel;

  factory StaffQueueModel.fromJson(Map<String, dynamic> json) =>
      _$StaffQueueModelFromJson(json);
}
