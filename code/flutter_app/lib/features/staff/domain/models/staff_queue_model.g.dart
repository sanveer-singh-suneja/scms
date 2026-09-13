// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_queue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueueStudentRefImpl _$$QueueStudentRefImplFromJson(
  Map<String, dynamic> json,
) => _$QueueStudentRefImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  studentId: json['student_id'] as String?,
);

Map<String, dynamic> _$$QueueStudentRefImplToJson(
  _$QueueStudentRefImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'student_id': instance.studentId,
};

_$QueueEquipmentRefImpl _$$QueueEquipmentRefImplFromJson(
  Map<String, dynamic> json,
) => _$QueueEquipmentRefImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
);

Map<String, dynamic> _$$QueueEquipmentRefImplToJson(
  _$QueueEquipmentRefImpl instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

_$QueueSlotRefImpl _$$QueueSlotRefImplFromJson(Map<String, dynamic> json) =>
    _$QueueSlotRefImpl(
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
    );

Map<String, dynamic> _$$QueueSlotRefImplToJson(_$QueueSlotRefImpl instance) =>
    <String, dynamic>{
      'start_time': instance.startTime,
      'end_time': instance.endTime,
    };

_$StaffBookingEntryImpl _$$StaffBookingEntryImplFromJson(
  Map<String, dynamic> json,
) => _$StaffBookingEntryImpl(
  bookingId: (json['booking_id'] as num).toInt(),
  student: QueueStudentRef.fromJson(json['student'] as Map<String, dynamic>),
  equipment: QueueEquipmentRef.fromJson(
    json['equipment'] as Map<String, dynamic>,
  ),
  slot: QueueSlotRef.fromJson(json['slot'] as Map<String, dynamic>),
  status: json['status'] as String,
);

Map<String, dynamic> _$$StaffBookingEntryImplToJson(
  _$StaffBookingEntryImpl instance,
) => <String, dynamic>{
  'booking_id': instance.bookingId,
  'student': instance.student,
  'equipment': instance.equipment,
  'slot': instance.slot,
  'status': instance.status,
};

_$StaffTransactionEntryImpl _$$StaffTransactionEntryImplFromJson(
  Map<String, dynamic> json,
) => _$StaffTransactionEntryImpl(
  transactionId: (json['transaction_id'] as num).toInt(),
  student: QueueStudentRef.fromJson(json['student'] as Map<String, dynamic>),
  equipment: QueueEquipmentRef.fromJson(
    json['equipment'] as Map<String, dynamic>,
  ),
  issuedAt: json['issued_at'] as String,
  dueAt: json['due_at'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$$StaffTransactionEntryImplToJson(
  _$StaffTransactionEntryImpl instance,
) => <String, dynamic>{
  'transaction_id': instance.transactionId,
  'student': instance.student,
  'equipment': instance.equipment,
  'issued_at': instance.issuedAt,
  'due_at': instance.dueAt,
  'status': instance.status,
};

_$StaffQueueModelImpl _$$StaffQueueModelImplFromJson(
  Map<String, dynamic> json,
) => _$StaffQueueModelImpl(
  confirmedBookingsToday: (json['confirmed_bookings_today'] as List<dynamic>)
      .map((e) => StaffBookingEntry.fromJson(e as Map<String, dynamic>))
      .toList(),
  openTransactions: (json['open_transactions'] as List<dynamic>)
      .map((e) => StaffTransactionEntry.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$StaffQueueModelImplToJson(
  _$StaffQueueModelImpl instance,
) => <String, dynamic>{
  'confirmed_bookings_today': instance.confirmedBookingsToday,
  'open_transactions': instance.openTransactions,
};
