// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EquipmentModelImpl _$$EquipmentModelImplFromJson(Map<String, dynamic> json) =>
    _$EquipmentModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      category: json['category'] as String,
      status: json['status'] as String,
      condition: json['condition'] as String,
      location: json['location'] as String?,
      notes: json['notes'] as String?,
      qrCode: json['qr_code'] as String?,
      addedAt: json['added_at'] as String?,
    );

Map<String, dynamic> _$$EquipmentModelImplToJson(
  _$EquipmentModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'category': instance.category,
  'status': instance.status,
  'condition': instance.condition,
  'location': instance.location,
  'notes': instance.notes,
  'qr_code': instance.qrCode,
  'added_at': instance.addedAt,
};

_$SlotAvailabilityImpl _$$SlotAvailabilityImplFromJson(
  Map<String, dynamic> json,
) => _$SlotAvailabilityImpl(
  id: (json['slot_id'] as num).toInt(),
  date: json['date'] as String,
  startTime: json['start_time'] as String,
  endTime: json['end_time'] as String,
  capacity: (json['capacity'] as num).toInt(),
  availableCount: (json['available_count'] as num).toInt(),
  status: json['status'] as String,
  bookingCutoffAt: json['booking_cutoff_at'] as String,
);

Map<String, dynamic> _$$SlotAvailabilityImplToJson(
  _$SlotAvailabilityImpl instance,
) => <String, dynamic>{
  'slot_id': instance.id,
  'date': instance.date,
  'start_time': instance.startTime,
  'end_time': instance.endTime,
  'capacity': instance.capacity,
  'available_count': instance.availableCount,
  'status': instance.status,
  'booking_cutoff_at': instance.bookingCutoffAt,
};
