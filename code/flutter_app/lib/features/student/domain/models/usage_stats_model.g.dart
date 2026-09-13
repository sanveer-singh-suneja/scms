// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usage_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UsageStatsModelImpl _$$UsageStatsModelImplFromJson(
  Map<String, dynamic> json,
) => _$UsageStatsModelImpl(
  sessionsLast7Days: (json['sessions_last_7_days'] as num).toInt(),
  lastSessionAt: json['last_session_at'] as String?,
  totalSessions: (json['total_sessions'] as num).toInt(),
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$$UsageStatsModelImplToJson(
  _$UsageStatsModelImpl instance,
) => <String, dynamic>{
  'sessions_last_7_days': instance.sessionsLast7Days,
  'last_session_at': instance.lastSessionAt,
  'total_sessions': instance.totalSessions,
  'updated_at': instance.updatedAt,
};
