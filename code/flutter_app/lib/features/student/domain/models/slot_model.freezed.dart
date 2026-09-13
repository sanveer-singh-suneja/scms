// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SlotModel _$SlotModelFromJson(Map<String, dynamic> json) {
  return _SlotModel.fromJson(json);
}

/// @nodoc
mixin _$SlotModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'equipment_id')
  int get equipmentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'equipment_name')
  String? get equipmentName => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_time')
  String get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_time')
  String get endTime => throw _privateConstructorUsedError;
  int get capacity => throw _privateConstructorUsedError;
  @JsonKey(name: 'available_count')
  int get availableCount => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_cutoff_at')
  String get bookingCutoffAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'allocation_run_at')
  String? get allocationRunAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this SlotModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SlotModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SlotModelCopyWith<SlotModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SlotModelCopyWith<$Res> {
  factory $SlotModelCopyWith(SlotModel value, $Res Function(SlotModel) then) =
      _$SlotModelCopyWithImpl<$Res, SlotModel>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'equipment_id') int equipmentId,
    @JsonKey(name: 'equipment_name') String? equipmentName,
    String date,
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String endTime,
    int capacity,
    @JsonKey(name: 'available_count') int availableCount,
    String status,
    @JsonKey(name: 'booking_cutoff_at') String bookingCutoffAt,
    @JsonKey(name: 'allocation_run_at') String? allocationRunAt,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class _$SlotModelCopyWithImpl<$Res, $Val extends SlotModel>
    implements $SlotModelCopyWith<$Res> {
  _$SlotModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SlotModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? equipmentId = null,
    Object? equipmentName = freezed,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? capacity = null,
    Object? availableCount = null,
    Object? status = null,
    Object? bookingCutoffAt = null,
    Object? allocationRunAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            equipmentId: null == equipmentId
                ? _value.equipmentId
                : equipmentId // ignore: cast_nullable_to_non_nullable
                      as int,
            equipmentName: freezed == equipmentName
                ? _value.equipmentName
                : equipmentName // ignore: cast_nullable_to_non_nullable
                      as String?,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as String,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as String,
            capacity: null == capacity
                ? _value.capacity
                : capacity // ignore: cast_nullable_to_non_nullable
                      as int,
            availableCount: null == availableCount
                ? _value.availableCount
                : availableCount // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            bookingCutoffAt: null == bookingCutoffAt
                ? _value.bookingCutoffAt
                : bookingCutoffAt // ignore: cast_nullable_to_non_nullable
                      as String,
            allocationRunAt: freezed == allocationRunAt
                ? _value.allocationRunAt
                : allocationRunAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SlotModelImplCopyWith<$Res>
    implements $SlotModelCopyWith<$Res> {
  factory _$$SlotModelImplCopyWith(
    _$SlotModelImpl value,
    $Res Function(_$SlotModelImpl) then,
  ) = __$$SlotModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'equipment_id') int equipmentId,
    @JsonKey(name: 'equipment_name') String? equipmentName,
    String date,
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String endTime,
    int capacity,
    @JsonKey(name: 'available_count') int availableCount,
    String status,
    @JsonKey(name: 'booking_cutoff_at') String bookingCutoffAt,
    @JsonKey(name: 'allocation_run_at') String? allocationRunAt,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class __$$SlotModelImplCopyWithImpl<$Res>
    extends _$SlotModelCopyWithImpl<$Res, _$SlotModelImpl>
    implements _$$SlotModelImplCopyWith<$Res> {
  __$$SlotModelImplCopyWithImpl(
    _$SlotModelImpl _value,
    $Res Function(_$SlotModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SlotModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? equipmentId = null,
    Object? equipmentName = freezed,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? capacity = null,
    Object? availableCount = null,
    Object? status = null,
    Object? bookingCutoffAt = null,
    Object? allocationRunAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$SlotModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        equipmentId: null == equipmentId
            ? _value.equipmentId
            : equipmentId // ignore: cast_nullable_to_non_nullable
                  as int,
        equipmentName: freezed == equipmentName
            ? _value.equipmentName
            : equipmentName // ignore: cast_nullable_to_non_nullable
                  as String?,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as String,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as String,
        capacity: null == capacity
            ? _value.capacity
            : capacity // ignore: cast_nullable_to_non_nullable
                  as int,
        availableCount: null == availableCount
            ? _value.availableCount
            : availableCount // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingCutoffAt: null == bookingCutoffAt
            ? _value.bookingCutoffAt
            : bookingCutoffAt // ignore: cast_nullable_to_non_nullable
                  as String,
        allocationRunAt: freezed == allocationRunAt
            ? _value.allocationRunAt
            : allocationRunAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SlotModelImpl implements _SlotModel {
  const _$SlotModelImpl({
    required this.id,
    @JsonKey(name: 'equipment_id') required this.equipmentId,
    @JsonKey(name: 'equipment_name') this.equipmentName,
    required this.date,
    @JsonKey(name: 'start_time') required this.startTime,
    @JsonKey(name: 'end_time') required this.endTime,
    required this.capacity,
    @JsonKey(name: 'available_count') required this.availableCount,
    required this.status,
    @JsonKey(name: 'booking_cutoff_at') required this.bookingCutoffAt,
    @JsonKey(name: 'allocation_run_at') this.allocationRunAt,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$SlotModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SlotModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'equipment_id')
  final int equipmentId;
  @override
  @JsonKey(name: 'equipment_name')
  final String? equipmentName;
  @override
  final String date;
  @override
  @JsonKey(name: 'start_time')
  final String startTime;
  @override
  @JsonKey(name: 'end_time')
  final String endTime;
  @override
  final int capacity;
  @override
  @JsonKey(name: 'available_count')
  final int availableCount;
  @override
  final String status;
  @override
  @JsonKey(name: 'booking_cutoff_at')
  final String bookingCutoffAt;
  @override
  @JsonKey(name: 'allocation_run_at')
  final String? allocationRunAt;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @override
  String toString() {
    return 'SlotModel(id: $id, equipmentId: $equipmentId, equipmentName: $equipmentName, date: $date, startTime: $startTime, endTime: $endTime, capacity: $capacity, availableCount: $availableCount, status: $status, bookingCutoffAt: $bookingCutoffAt, allocationRunAt: $allocationRunAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SlotModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.equipmentId, equipmentId) ||
                other.equipmentId == equipmentId) &&
            (identical(other.equipmentName, equipmentName) ||
                other.equipmentName == equipmentName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.availableCount, availableCount) ||
                other.availableCount == availableCount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.bookingCutoffAt, bookingCutoffAt) ||
                other.bookingCutoffAt == bookingCutoffAt) &&
            (identical(other.allocationRunAt, allocationRunAt) ||
                other.allocationRunAt == allocationRunAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    equipmentId,
    equipmentName,
    date,
    startTime,
    endTime,
    capacity,
    availableCount,
    status,
    bookingCutoffAt,
    allocationRunAt,
    createdAt,
  );

  /// Create a copy of SlotModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SlotModelImplCopyWith<_$SlotModelImpl> get copyWith =>
      __$$SlotModelImplCopyWithImpl<_$SlotModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SlotModelImplToJson(this);
  }
}

abstract class _SlotModel implements SlotModel {
  const factory _SlotModel({
    required final int id,
    @JsonKey(name: 'equipment_id') required final int equipmentId,
    @JsonKey(name: 'equipment_name') final String? equipmentName,
    required final String date,
    @JsonKey(name: 'start_time') required final String startTime,
    @JsonKey(name: 'end_time') required final String endTime,
    required final int capacity,
    @JsonKey(name: 'available_count') required final int availableCount,
    required final String status,
    @JsonKey(name: 'booking_cutoff_at') required final String bookingCutoffAt,
    @JsonKey(name: 'allocation_run_at') final String? allocationRunAt,
    @JsonKey(name: 'created_at') final String? createdAt,
  }) = _$SlotModelImpl;

  factory _SlotModel.fromJson(Map<String, dynamic> json) =
      _$SlotModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'equipment_id')
  int get equipmentId;
  @override
  @JsonKey(name: 'equipment_name')
  String? get equipmentName;
  @override
  String get date;
  @override
  @JsonKey(name: 'start_time')
  String get startTime;
  @override
  @JsonKey(name: 'end_time')
  String get endTime;
  @override
  int get capacity;
  @override
  @JsonKey(name: 'available_count')
  int get availableCount;
  @override
  String get status;
  @override
  @JsonKey(name: 'booking_cutoff_at')
  String get bookingCutoffAt;
  @override
  @JsonKey(name: 'allocation_run_at')
  String? get allocationRunAt;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;

  /// Create a copy of SlotModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SlotModelImplCopyWith<_$SlotModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
