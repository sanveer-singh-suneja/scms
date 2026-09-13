// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'equipment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EquipmentModel _$EquipmentModelFromJson(Map<String, dynamic> json) {
  return _EquipmentModel.fromJson(json);
}

/// @nodoc
mixin _$EquipmentModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get condition => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'qr_code')
  String? get qrCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'added_at')
  String? get addedAt => throw _privateConstructorUsedError;

  /// Serializes this EquipmentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EquipmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EquipmentModelCopyWith<EquipmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EquipmentModelCopyWith<$Res> {
  factory $EquipmentModelCopyWith(
    EquipmentModel value,
    $Res Function(EquipmentModel) then,
  ) = _$EquipmentModelCopyWithImpl<$Res, EquipmentModel>;
  @useResult
  $Res call({
    int id,
    String name,
    String category,
    String status,
    String condition,
    String? location,
    String? notes,
    @JsonKey(name: 'qr_code') String? qrCode,
    @JsonKey(name: 'added_at') String? addedAt,
  });
}

/// @nodoc
class _$EquipmentModelCopyWithImpl<$Res, $Val extends EquipmentModel>
    implements $EquipmentModelCopyWith<$Res> {
  _$EquipmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EquipmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? status = null,
    Object? condition = null,
    Object? location = freezed,
    Object? notes = freezed,
    Object? qrCode = freezed,
    Object? addedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            condition: null == condition
                ? _value.condition
                : condition // ignore: cast_nullable_to_non_nullable
                      as String,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            qrCode: freezed == qrCode
                ? _value.qrCode
                : qrCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            addedAt: freezed == addedAt
                ? _value.addedAt
                : addedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EquipmentModelImplCopyWith<$Res>
    implements $EquipmentModelCopyWith<$Res> {
  factory _$$EquipmentModelImplCopyWith(
    _$EquipmentModelImpl value,
    $Res Function(_$EquipmentModelImpl) then,
  ) = __$$EquipmentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String category,
    String status,
    String condition,
    String? location,
    String? notes,
    @JsonKey(name: 'qr_code') String? qrCode,
    @JsonKey(name: 'added_at') String? addedAt,
  });
}

/// @nodoc
class __$$EquipmentModelImplCopyWithImpl<$Res>
    extends _$EquipmentModelCopyWithImpl<$Res, _$EquipmentModelImpl>
    implements _$$EquipmentModelImplCopyWith<$Res> {
  __$$EquipmentModelImplCopyWithImpl(
    _$EquipmentModelImpl _value,
    $Res Function(_$EquipmentModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EquipmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? status = null,
    Object? condition = null,
    Object? location = freezed,
    Object? notes = freezed,
    Object? qrCode = freezed,
    Object? addedAt = freezed,
  }) {
    return _then(
      _$EquipmentModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        condition: null == condition
            ? _value.condition
            : condition // ignore: cast_nullable_to_non_nullable
                  as String,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        qrCode: freezed == qrCode
            ? _value.qrCode
            : qrCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        addedAt: freezed == addedAt
            ? _value.addedAt
            : addedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EquipmentModelImpl implements _EquipmentModel {
  const _$EquipmentModelImpl({
    required this.id,
    required this.name,
    required this.category,
    required this.status,
    required this.condition,
    this.location,
    this.notes,
    @JsonKey(name: 'qr_code') this.qrCode,
    @JsonKey(name: 'added_at') this.addedAt,
  });

  factory _$EquipmentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EquipmentModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String category;
  @override
  final String status;
  @override
  final String condition;
  @override
  final String? location;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'qr_code')
  final String? qrCode;
  @override
  @JsonKey(name: 'added_at')
  final String? addedAt;

  @override
  String toString() {
    return 'EquipmentModel(id: $id, name: $name, category: $category, status: $status, condition: $condition, location: $location, notes: $notes, qrCode: $qrCode, addedAt: $addedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EquipmentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.qrCode, qrCode) || other.qrCode == qrCode) &&
            (identical(other.addedAt, addedAt) || other.addedAt == addedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    category,
    status,
    condition,
    location,
    notes,
    qrCode,
    addedAt,
  );

  /// Create a copy of EquipmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EquipmentModelImplCopyWith<_$EquipmentModelImpl> get copyWith =>
      __$$EquipmentModelImplCopyWithImpl<_$EquipmentModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EquipmentModelImplToJson(this);
  }
}

abstract class _EquipmentModel implements EquipmentModel {
  const factory _EquipmentModel({
    required final int id,
    required final String name,
    required final String category,
    required final String status,
    required final String condition,
    final String? location,
    final String? notes,
    @JsonKey(name: 'qr_code') final String? qrCode,
    @JsonKey(name: 'added_at') final String? addedAt,
  }) = _$EquipmentModelImpl;

  factory _EquipmentModel.fromJson(Map<String, dynamic> json) =
      _$EquipmentModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get category;
  @override
  String get status;
  @override
  String get condition;
  @override
  String? get location;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'qr_code')
  String? get qrCode;
  @override
  @JsonKey(name: 'added_at')
  String? get addedAt;

  /// Create a copy of EquipmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EquipmentModelImplCopyWith<_$EquipmentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SlotAvailability _$SlotAvailabilityFromJson(Map<String, dynamic> json) {
  return _SlotAvailability.fromJson(json);
}

/// @nodoc
mixin _$SlotAvailability {
  @JsonKey(name: 'slot_id')
  int get id => throw _privateConstructorUsedError;
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

  /// Serializes this SlotAvailability to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SlotAvailability
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SlotAvailabilityCopyWith<SlotAvailability> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SlotAvailabilityCopyWith<$Res> {
  factory $SlotAvailabilityCopyWith(
    SlotAvailability value,
    $Res Function(SlotAvailability) then,
  ) = _$SlotAvailabilityCopyWithImpl<$Res, SlotAvailability>;
  @useResult
  $Res call({
    @JsonKey(name: 'slot_id') int id,
    String date,
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String endTime,
    int capacity,
    @JsonKey(name: 'available_count') int availableCount,
    String status,
    @JsonKey(name: 'booking_cutoff_at') String bookingCutoffAt,
  });
}

/// @nodoc
class _$SlotAvailabilityCopyWithImpl<$Res, $Val extends SlotAvailability>
    implements $SlotAvailabilityCopyWith<$Res> {
  _$SlotAvailabilityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SlotAvailability
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? capacity = null,
    Object? availableCount = null,
    Object? status = null,
    Object? bookingCutoffAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SlotAvailabilityImplCopyWith<$Res>
    implements $SlotAvailabilityCopyWith<$Res> {
  factory _$$SlotAvailabilityImplCopyWith(
    _$SlotAvailabilityImpl value,
    $Res Function(_$SlotAvailabilityImpl) then,
  ) = __$$SlotAvailabilityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'slot_id') int id,
    String date,
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String endTime,
    int capacity,
    @JsonKey(name: 'available_count') int availableCount,
    String status,
    @JsonKey(name: 'booking_cutoff_at') String bookingCutoffAt,
  });
}

/// @nodoc
class __$$SlotAvailabilityImplCopyWithImpl<$Res>
    extends _$SlotAvailabilityCopyWithImpl<$Res, _$SlotAvailabilityImpl>
    implements _$$SlotAvailabilityImplCopyWith<$Res> {
  __$$SlotAvailabilityImplCopyWithImpl(
    _$SlotAvailabilityImpl _value,
    $Res Function(_$SlotAvailabilityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SlotAvailability
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? capacity = null,
    Object? availableCount = null,
    Object? status = null,
    Object? bookingCutoffAt = null,
  }) {
    return _then(
      _$SlotAvailabilityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SlotAvailabilityImpl implements _SlotAvailability {
  const _$SlotAvailabilityImpl({
    @JsonKey(name: 'slot_id') required this.id,
    required this.date,
    @JsonKey(name: 'start_time') required this.startTime,
    @JsonKey(name: 'end_time') required this.endTime,
    required this.capacity,
    @JsonKey(name: 'available_count') required this.availableCount,
    required this.status,
    @JsonKey(name: 'booking_cutoff_at') required this.bookingCutoffAt,
  });

  factory _$SlotAvailabilityImpl.fromJson(Map<String, dynamic> json) =>
      _$$SlotAvailabilityImplFromJson(json);

  @override
  @JsonKey(name: 'slot_id')
  final int id;
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
  String toString() {
    return 'SlotAvailability(id: $id, date: $date, startTime: $startTime, endTime: $endTime, capacity: $capacity, availableCount: $availableCount, status: $status, bookingCutoffAt: $bookingCutoffAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SlotAvailabilityImpl &&
            (identical(other.id, id) || other.id == id) &&
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
                other.bookingCutoffAt == bookingCutoffAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    date,
    startTime,
    endTime,
    capacity,
    availableCount,
    status,
    bookingCutoffAt,
  );

  /// Create a copy of SlotAvailability
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SlotAvailabilityImplCopyWith<_$SlotAvailabilityImpl> get copyWith =>
      __$$SlotAvailabilityImplCopyWithImpl<_$SlotAvailabilityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SlotAvailabilityImplToJson(this);
  }
}

abstract class _SlotAvailability implements SlotAvailability {
  const factory _SlotAvailability({
    @JsonKey(name: 'slot_id') required final int id,
    required final String date,
    @JsonKey(name: 'start_time') required final String startTime,
    @JsonKey(name: 'end_time') required final String endTime,
    required final int capacity,
    @JsonKey(name: 'available_count') required final int availableCount,
    required final String status,
    @JsonKey(name: 'booking_cutoff_at') required final String bookingCutoffAt,
  }) = _$SlotAvailabilityImpl;

  factory _SlotAvailability.fromJson(Map<String, dynamic> json) =
      _$SlotAvailabilityImpl.fromJson;

  @override
  @JsonKey(name: 'slot_id')
  int get id;
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

  /// Create a copy of SlotAvailability
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SlotAvailabilityImplCopyWith<_$SlotAvailabilityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
