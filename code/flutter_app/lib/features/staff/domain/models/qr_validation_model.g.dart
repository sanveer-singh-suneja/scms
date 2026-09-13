// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_validation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QrStudentInfoImpl _$$QrStudentInfoImplFromJson(Map<String, dynamic> json) =>
    _$QrStudentInfoImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      studentId: json['student_id'] as String,
      department: json['department'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$QrStudentInfoImplToJson(_$QrStudentInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'student_id': instance.studentId,
      'department': instance.department,
      'status': instance.status,
    };

_$QrEquipmentRefImpl _$$QrEquipmentRefImplFromJson(Map<String, dynamic> json) =>
    _$QrEquipmentRefImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$QrEquipmentRefImplToJson(
  _$QrEquipmentRefImpl instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

_$QrSlotRefImpl _$$QrSlotRefImplFromJson(Map<String, dynamic> json) =>
    _$QrSlotRefImpl(
      id: (json['id'] as num?)?.toInt(),
      date: json['date'] as String?,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
    );

Map<String, dynamic> _$$QrSlotRefImplToJson(_$QrSlotRefImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
    };

_$QrBookingInfoImpl _$$QrBookingInfoImplFromJson(Map<String, dynamic> json) =>
    _$QrBookingInfoImpl(
      id: (json['id'] as num).toInt(),
      equipment: QrEquipmentRef.fromJson(
        json['equipment'] as Map<String, dynamic>,
      ),
      slot: json['slot'] == null
          ? null
          : QrSlotRef.fromJson(json['slot'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$$QrBookingInfoImplToJson(_$QrBookingInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'equipment': instance.equipment,
      'slot': instance.slot,
      'status': instance.status,
    };

_$QrTransactionInfoImpl _$$QrTransactionInfoImplFromJson(
  Map<String, dynamic> json,
) => _$QrTransactionInfoImpl(
  id: (json['id'] as num).toInt(),
  studentId: (json['student_id'] as num?)?.toInt(),
  equipmentId: (json['equipment_id'] as num?)?.toInt(),
  equipmentName: json['equipment_name'] as String?,
  issuedAt: json['issued_at'] as String,
  dueAt: json['due_at'] as String,
  status: json['status'] as String,
  issuedBy: (json['issued_by'] as num?)?.toInt(),
);

Map<String, dynamic> _$$QrTransactionInfoImplToJson(
  _$QrTransactionInfoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'student_id': instance.studentId,
  'equipment_id': instance.equipmentId,
  'equipment_name': instance.equipmentName,
  'issued_at': instance.issuedAt,
  'due_at': instance.dueAt,
  'status': instance.status,
  'issued_by': instance.issuedBy,
};

_$QrValidationResultImpl _$$QrValidationResultImplFromJson(
  Map<String, dynamic> json,
) => _$QrValidationResultImpl(
  student: QrStudentInfo.fromJson(json['student'] as Map<String, dynamic>),
  currentBooking: json['current_booking'] == null
      ? null
      : QrBookingInfo.fromJson(json['current_booking'] as Map<String, dynamic>),
  openTransaction: json['open_transaction'] == null
      ? null
      : QrTransactionInfo.fromJson(
          json['open_transaction'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$$QrValidationResultImplToJson(
  _$QrValidationResultImpl instance,
) => <String, dynamic>{
  'student': instance.student,
  'current_booking': instance.currentBooking,
  'open_transaction': instance.openTransaction,
};
