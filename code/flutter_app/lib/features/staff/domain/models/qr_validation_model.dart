import 'package:freezed_annotation/freezed_annotation.dart';

part 'qr_validation_model.freezed.dart';
part 'qr_validation_model.g.dart';

@freezed
class QrStudentInfo with _$QrStudentInfo {
  const factory QrStudentInfo({
    required int id,
    required String name,
    @JsonKey(name: 'student_id') required String studentId,
    String? department,
    String? status,
  }) = _QrStudentInfo;

  factory QrStudentInfo.fromJson(Map<String, dynamic> json) =>
      _$QrStudentInfoFromJson(json);
}

@freezed
class QrEquipmentRef with _$QrEquipmentRef {
  const factory QrEquipmentRef({
    required int id,
    required String name,
  }) = _QrEquipmentRef;

  factory QrEquipmentRef.fromJson(Map<String, dynamic> json) =>
      _$QrEquipmentRefFromJson(json);
}

@freezed
class QrSlotRef with _$QrSlotRef {
  const factory QrSlotRef({
    int? id,
    String? date,
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'end_time') required String endTime,
  }) = _QrSlotRef;

  factory QrSlotRef.fromJson(Map<String, dynamic> json) =>
      _$QrSlotRefFromJson(json);
}

@freezed
class QrBookingInfo with _$QrBookingInfo {
  const factory QrBookingInfo({
    required int id,
    required QrEquipmentRef equipment,
    QrSlotRef? slot,
    required String status,
  }) = _QrBookingInfo;

  factory QrBookingInfo.fromJson(Map<String, dynamic> json) =>
      _$QrBookingInfoFromJson(json);
}

@freezed
class QrTransactionInfo with _$QrTransactionInfo {
  const factory QrTransactionInfo({
    required int id,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'equipment_id') int? equipmentId,
    @JsonKey(name: 'equipment_name') String? equipmentName,
    @JsonKey(name: 'issued_at') required String issuedAt,
    @JsonKey(name: 'due_at') required String dueAt,
    required String status,
    @JsonKey(name: 'issued_by') int? issuedBy,
  }) = _QrTransactionInfo;

  factory QrTransactionInfo.fromJson(Map<String, dynamic> json) =>
      _$QrTransactionInfoFromJson(json);
}

@freezed
class QrValidationResult with _$QrValidationResult {
  const factory QrValidationResult({
    required QrStudentInfo student,
    @JsonKey(name: 'current_booking') QrBookingInfo? currentBooking,
    @JsonKey(name: 'open_transaction') QrTransactionInfo? openTransaction,
  }) = _QrValidationResult;

  factory QrValidationResult.fromJson(Map<String, dynamic> json) =>
      _$QrValidationResultFromJson(json);
}
