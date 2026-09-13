// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'usage_stats_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UsageStatsModel _$UsageStatsModelFromJson(Map<String, dynamic> json) {
  return _UsageStatsModel.fromJson(json);
}

/// @nodoc
mixin _$UsageStatsModel {
  @JsonKey(name: 'sessions_last_7_days')
  int get sessionsLast7Days => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_session_at')
  String? get lastSessionAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sessions')
  int get totalSessions => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UsageStatsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UsageStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UsageStatsModelCopyWith<UsageStatsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsageStatsModelCopyWith<$Res> {
  factory $UsageStatsModelCopyWith(
    UsageStatsModel value,
    $Res Function(UsageStatsModel) then,
  ) = _$UsageStatsModelCopyWithImpl<$Res, UsageStatsModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'sessions_last_7_days') int sessionsLast7Days,
    @JsonKey(name: 'last_session_at') String? lastSessionAt,
    @JsonKey(name: 'total_sessions') int totalSessions,
    @JsonKey(name: 'updated_at') String? updatedAt,
  });
}

/// @nodoc
class _$UsageStatsModelCopyWithImpl<$Res, $Val extends UsageStatsModel>
    implements $UsageStatsModelCopyWith<$Res> {
  _$UsageStatsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsageStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionsLast7Days = null,
    Object? lastSessionAt = freezed,
    Object? totalSessions = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            sessionsLast7Days: null == sessionsLast7Days
                ? _value.sessionsLast7Days
                : sessionsLast7Days // ignore: cast_nullable_to_non_nullable
                      as int,
            lastSessionAt: freezed == lastSessionAt
                ? _value.lastSessionAt
                : lastSessionAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            totalSessions: null == totalSessions
                ? _value.totalSessions
                : totalSessions // ignore: cast_nullable_to_non_nullable
                      as int,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UsageStatsModelImplCopyWith<$Res>
    implements $UsageStatsModelCopyWith<$Res> {
  factory _$$UsageStatsModelImplCopyWith(
    _$UsageStatsModelImpl value,
    $Res Function(_$UsageStatsModelImpl) then,
  ) = __$$UsageStatsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'sessions_last_7_days') int sessionsLast7Days,
    @JsonKey(name: 'last_session_at') String? lastSessionAt,
    @JsonKey(name: 'total_sessions') int totalSessions,
    @JsonKey(name: 'updated_at') String? updatedAt,
  });
}

/// @nodoc
class __$$UsageStatsModelImplCopyWithImpl<$Res>
    extends _$UsageStatsModelCopyWithImpl<$Res, _$UsageStatsModelImpl>
    implements _$$UsageStatsModelImplCopyWith<$Res> {
  __$$UsageStatsModelImplCopyWithImpl(
    _$UsageStatsModelImpl _value,
    $Res Function(_$UsageStatsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UsageStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionsLast7Days = null,
    Object? lastSessionAt = freezed,
    Object? totalSessions = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$UsageStatsModelImpl(
        sessionsLast7Days: null == sessionsLast7Days
            ? _value.sessionsLast7Days
            : sessionsLast7Days // ignore: cast_nullable_to_non_nullable
                  as int,
        lastSessionAt: freezed == lastSessionAt
            ? _value.lastSessionAt
            : lastSessionAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalSessions: null == totalSessions
            ? _value.totalSessions
            : totalSessions // ignore: cast_nullable_to_non_nullable
                  as int,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UsageStatsModelImpl implements _UsageStatsModel {
  const _$UsageStatsModelImpl({
    @JsonKey(name: 'sessions_last_7_days') required this.sessionsLast7Days,
    @JsonKey(name: 'last_session_at') this.lastSessionAt,
    @JsonKey(name: 'total_sessions') required this.totalSessions,
    @JsonKey(name: 'updated_at') this.updatedAt,
  });

  factory _$UsageStatsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UsageStatsModelImplFromJson(json);

  @override
  @JsonKey(name: 'sessions_last_7_days')
  final int sessionsLast7Days;
  @override
  @JsonKey(name: 'last_session_at')
  final String? lastSessionAt;
  @override
  @JsonKey(name: 'total_sessions')
  final int totalSessions;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'UsageStatsModel(sessionsLast7Days: $sessionsLast7Days, lastSessionAt: $lastSessionAt, totalSessions: $totalSessions, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsageStatsModelImpl &&
            (identical(other.sessionsLast7Days, sessionsLast7Days) ||
                other.sessionsLast7Days == sessionsLast7Days) &&
            (identical(other.lastSessionAt, lastSessionAt) ||
                other.lastSessionAt == lastSessionAt) &&
            (identical(other.totalSessions, totalSessions) ||
                other.totalSessions == totalSessions) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    sessionsLast7Days,
    lastSessionAt,
    totalSessions,
    updatedAt,
  );

  /// Create a copy of UsageStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsageStatsModelImplCopyWith<_$UsageStatsModelImpl> get copyWith =>
      __$$UsageStatsModelImplCopyWithImpl<_$UsageStatsModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UsageStatsModelImplToJson(this);
  }
}

abstract class _UsageStatsModel implements UsageStatsModel {
  const factory _UsageStatsModel({
    @JsonKey(name: 'sessions_last_7_days') required final int sessionsLast7Days,
    @JsonKey(name: 'last_session_at') final String? lastSessionAt,
    @JsonKey(name: 'total_sessions') required final int totalSessions,
    @JsonKey(name: 'updated_at') final String? updatedAt,
  }) = _$UsageStatsModelImpl;

  factory _UsageStatsModel.fromJson(Map<String, dynamic> json) =
      _$UsageStatsModelImpl.fromJson;

  @override
  @JsonKey(name: 'sessions_last_7_days')
  int get sessionsLast7Days;
  @override
  @JsonKey(name: 'last_session_at')
  String? get lastSessionAt;
  @override
  @JsonKey(name: 'total_sessions')
  int get totalSessions;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;

  /// Create a copy of UsageStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsageStatsModelImplCopyWith<_$UsageStatsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
