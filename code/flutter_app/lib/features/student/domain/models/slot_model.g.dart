// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SlotModelImpl _$$SlotModelImplFromJson(Map<String, dynamic> json) =>
    _$SlotModelImpl(
      id: (json['id'] as num).toInt(),
      equipmentId: (json['equipment_id'] as num).toInt(),
      equipmentName: json['equipment_name'] as String?,
      date: json['date'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      capacity: (json['capacity'] as num).toInt(),
      availableCount: (json['available_count'] as num).toInt(),
      status: json['status'] as String,
      bookingCutoffAt: json['booking_cutoff_at'] as String,
      allocationRunAt: json['allocation_run_at'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$$SlotModelImplToJson(_$SlotModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'equipment_id': instance.equipmentId,
      'equipment_name': instance.equipmentName,
      'date': instance.date,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'capacity': instance.capacity,
      'available_count': instance.availableCount,
      'status': instance.status,
      'booking_cutoff_at': instance.bookingCutoffAt,
      'allocation_run_at': instance.allocationRunAt,
      'created_at': instance.createdAt,
    };
