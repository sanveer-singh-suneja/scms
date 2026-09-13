import 'package:freezed_annotation/freezed_annotation.dart';

part 'usage_stats_model.freezed.dart';
part 'usage_stats_model.g.dart';

@freezed
class UsageStatsModel with _$UsageStatsModel {
  const factory UsageStatsModel({
    @JsonKey(name: 'sessions_last_7_days') required int sessionsLast7Days,
    @JsonKey(name: 'last_session_at') String? lastSessionAt,
    @JsonKey(name: 'total_sessions') required int totalSessions,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _UsageStatsModel;

  factory UsageStatsModel.fromJson(Map<String, dynamic> json) =>
      _$UsageStatsModelFromJson(json);
}
