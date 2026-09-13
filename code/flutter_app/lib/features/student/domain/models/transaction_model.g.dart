// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionModelImpl _$$TransactionModelImplFromJson(
  Map<String, dynamic> json,
) => _$TransactionModelImpl(
  id: (json['id'] as num).toInt(),
  bookingId: (json['booking_id'] as num?)?.toInt(),
  studentId: (json['student_id'] as num).toInt(),
  equipmentId: (json['equipment_id'] as num).toInt(),
  equipmentName: json['equipment_name'] as String?,
  issuedAt: json['issued_at'] as String,
  dueAt: json['due_at'] as String,
  returnedAt: json['returned_at'] as String?,
  status: json['status'] as String,
  conditionOnReturn: json['condition_on_return'] as String?,
  damageReport: json['damage_report'] as String?,
  issuedBy: (json['issued_by'] as num).toInt(),
  returnedTo: (json['returned_to'] as num?)?.toInt(),
);

Map<String, dynamic> _$$TransactionModelImplToJson(
  _$TransactionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'booking_id': instance.bookingId,
  'student_id': instance.studentId,
  'equipment_id': instance.equipmentId,
  'equipment_name': instance.equipmentName,
  'issued_at': instance.issuedAt,
  'due_at': instance.dueAt,
  'returned_at': instance.returnedAt,
  'status': instance.status,
  'condition_on_return': instance.conditionOnReturn,
  'damage_report': instance.damageReport,
  'issued_by': instance.issuedBy,
  'returned_to': instance.returnedTo,
};
