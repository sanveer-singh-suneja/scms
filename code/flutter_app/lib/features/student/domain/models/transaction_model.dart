import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required int id,
    @JsonKey(name: 'booking_id') int? bookingId,
    @JsonKey(name: 'student_id') required int studentId,
    @JsonKey(name: 'equipment_id') required int equipmentId,
    @JsonKey(name: 'equipment_name') String? equipmentName,
    @JsonKey(name: 'issued_at') required String issuedAt,
    @JsonKey(name: 'due_at') required String dueAt,
    @JsonKey(name: 'returned_at') String? returnedAt,
    required String status,
    @JsonKey(name: 'condition_on_return') String? conditionOnReturn,
    @JsonKey(name: 'damage_report') String? damageReport,
    @JsonKey(name: 'issued_by') required int issuedBy,
    @JsonKey(name: 'returned_to') int? returnedTo,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}
