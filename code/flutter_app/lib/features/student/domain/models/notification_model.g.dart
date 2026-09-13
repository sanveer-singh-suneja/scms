// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationModelImpl(
  id: (json['id'] as num).toInt(),
  studentId: (json['student_id'] as num?)?.toInt(),
  type: json['type'] as String,
  title: json['title'] as String,
  message: json['message'] as String,
  isRead: json['is_read'] as bool,
  createdAt: json['created_at'] as String,
  expiresAt: json['expires_at'] as String?,
);

Map<String, dynamic> _$$NotificationModelImplToJson(
  _$NotificationModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'student_id': instance.studentId,
  'type': instance.type,
  'title': instance.title,
  'message': instance.message,
  'is_read': instance.isRead,
  'created_at': instance.createdAt,
  'expires_at': instance.expiresAt,
};
