// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingSlotInfoImpl _$$BookingSlotInfoImplFromJson(
  Map<String, dynamic> json,
) => _$BookingSlotInfoImpl(
  id: (json['id'] as num).toInt(),
  date: json['date'] as String,
  startTime: json['start_time'] as String,
  endTime: json['end_time'] as String,
  bookingCutoffAt: json['booking_cutoff_at'] as String,
);

Map<String, dynamic> _$$BookingSlotInfoImplToJson(
  _$BookingSlotInfoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'date': instance.date,
  'start_time': instance.startTime,
  'end_time': instance.endTime,
  'booking_cutoff_at': instance.bookingCutoffAt,
};

_$BookingEquipmentInfoImpl _$$BookingEquipmentInfoImplFromJson(
  Map<String, dynamic> json,
) => _$BookingEquipmentInfoImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
);

Map<String, dynamic> _$$BookingEquipmentInfoImplToJson(
  _$BookingEquipmentInfoImpl instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

_$BookingModelImpl _$$BookingModelImplFromJson(Map<String, dynamic> json) =>
    _$BookingModelImpl(
      id: (json['id'] as num).toInt(),
      slot: json['slot'] == null
          ? null
          : BookingSlotInfo.fromJson(json['slot'] as Map<String, dynamic>),
      equipment: json['equipment'] == null
          ? null
          : BookingEquipmentInfo.fromJson(
              json['equipment'] as Map<String, dynamic>,
            ),
      status: json['status'] as String,
      priorityScore: (json['priority_score'] as num?)?.toDouble(),
      queuePosition: (json['queue_position'] as num?)?.toInt(),
      createdAt: json['created_at'] as String,
      allocatedAt: json['allocated_at'] as String?,
      bookingCutoffAt: json['booking_cutoff_at'] as String?,
    );

Map<String, dynamic> _$$BookingModelImplToJson(_$BookingModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slot': instance.slot,
      'equipment': instance.equipment,
      'status': instance.status,
      'priority_score': instance.priorityScore,
      'queue_position': instance.queuePosition,
      'created_at': instance.createdAt,
      'allocated_at': instance.allocatedAt,
      'booking_cutoff_at': instance.bookingCutoffAt,
    };

_$QueuePositionImpl _$$QueuePositionImplFromJson(Map<String, dynamic> json) =>
    _$QueuePositionImpl(
      bookingId: (json['booking_id'] as num).toInt(),
      status: json['status'] as String,
      queuePosition: (json['queue_position'] as num?)?.toInt(),
      totalWaitlisted: (json['total_waitlisted'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$QueuePositionImplToJson(_$QueuePositionImpl instance) =>
    <String, dynamic>{
      'booking_id': instance.bookingId,
      'status': instance.status,
      'queue_position': instance.queuePosition,
      'total_waitlisted': instance.totalWaitlisted,
    };
