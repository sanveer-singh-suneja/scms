// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BookingSlotInfo _$BookingSlotInfoFromJson(Map<String, dynamic> json) {
  return _BookingSlotInfo.fromJson(json);
}

/// @nodoc
mixin _$BookingSlotInfo {
  int get id => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_time')
  String get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_time')
  String get endTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_cutoff_at')
  String get bookingCutoffAt => throw _privateConstructorUsedError;

  /// Serializes this BookingSlotInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookingSlotInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingSlotInfoCopyWith<BookingSlotInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingSlotInfoCopyWith<$Res> {
  factory $BookingSlotInfoCopyWith(
    BookingSlotInfo value,
    $Res Function(BookingSlotInfo) then,
  ) = _$BookingSlotInfoCopyWithImpl<$Res, BookingSlotInfo>;
  @useResult
  $Res call({
    int id,
    String date,
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String endTime,
    @JsonKey(name: 'booking_cutoff_at') String bookingCutoffAt,
  });
}

/// @nodoc
class _$BookingSlotInfoCopyWithImpl<$Res, $Val extends BookingSlotInfo>
    implements $BookingSlotInfoCopyWith<$Res> {
  _$BookingSlotInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingSlotInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
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
abstract class _$$BookingSlotInfoImplCopyWith<$Res>
    implements $BookingSlotInfoCopyWith<$Res> {
  factory _$$BookingSlotInfoImplCopyWith(
    _$BookingSlotInfoImpl value,
    $Res Function(_$BookingSlotInfoImpl) then,
  ) = __$$BookingSlotInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String date,
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String endTime,
    @JsonKey(name: 'booking_cutoff_at') String bookingCutoffAt,
  });
}

/// @nodoc
class __$$BookingSlotInfoImplCopyWithImpl<$Res>
    extends _$BookingSlotInfoCopyWithImpl<$Res, _$BookingSlotInfoImpl>
    implements _$$BookingSlotInfoImplCopyWith<$Res> {
  __$$BookingSlotInfoImplCopyWithImpl(
    _$BookingSlotInfoImpl _value,
    $Res Function(_$BookingSlotInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookingSlotInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? bookingCutoffAt = null,
  }) {
    return _then(
      _$BookingSlotInfoImpl(
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
class _$BookingSlotInfoImpl implements _BookingSlotInfo {
  const _$BookingSlotInfoImpl({
    required this.id,
    required this.date,
    @JsonKey(name: 'start_time') required this.startTime,
    @JsonKey(name: 'end_time') required this.endTime,
    @JsonKey(name: 'booking_cutoff_at') required this.bookingCutoffAt,
  });

  factory _$BookingSlotInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingSlotInfoImplFromJson(json);

  @override
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
  @JsonKey(name: 'booking_cutoff_at')
  final String bookingCutoffAt;

  @override
  String toString() {
    return 'BookingSlotInfo(id: $id, date: $date, startTime: $startTime, endTime: $endTime, bookingCutoffAt: $bookingCutoffAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingSlotInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.bookingCutoffAt, bookingCutoffAt) ||
                other.bookingCutoffAt == bookingCutoffAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, date, startTime, endTime, bookingCutoffAt);

  /// Create a copy of BookingSlotInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingSlotInfoImplCopyWith<_$BookingSlotInfoImpl> get copyWith =>
      __$$BookingSlotInfoImplCopyWithImpl<_$BookingSlotInfoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingSlotInfoImplToJson(this);
  }
}

abstract class _BookingSlotInfo implements BookingSlotInfo {
  const factory _BookingSlotInfo({
    required final int id,
    required final String date,
    @JsonKey(name: 'start_time') required final String startTime,
    @JsonKey(name: 'end_time') required final String endTime,
    @JsonKey(name: 'booking_cutoff_at') required final String bookingCutoffAt,
  }) = _$BookingSlotInfoImpl;

  factory _BookingSlotInfo.fromJson(Map<String, dynamic> json) =
      _$BookingSlotInfoImpl.fromJson;

  @override
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
  @JsonKey(name: 'booking_cutoff_at')
  String get bookingCutoffAt;

  /// Create a copy of BookingSlotInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingSlotInfoImplCopyWith<_$BookingSlotInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BookingEquipmentInfo _$BookingEquipmentInfoFromJson(Map<String, dynamic> json) {
  return _BookingEquipmentInfo.fromJson(json);
}

/// @nodoc
mixin _$BookingEquipmentInfo {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this BookingEquipmentInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookingEquipmentInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingEquipmentInfoCopyWith<BookingEquipmentInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingEquipmentInfoCopyWith<$Res> {
  factory $BookingEquipmentInfoCopyWith(
    BookingEquipmentInfo value,
    $Res Function(BookingEquipmentInfo) then,
  ) = _$BookingEquipmentInfoCopyWithImpl<$Res, BookingEquipmentInfo>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$BookingEquipmentInfoCopyWithImpl<
  $Res,
  $Val extends BookingEquipmentInfo
>
    implements $BookingEquipmentInfoCopyWith<$Res> {
  _$BookingEquipmentInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingEquipmentInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BookingEquipmentInfoImplCopyWith<$Res>
    implements $BookingEquipmentInfoCopyWith<$Res> {
  factory _$$BookingEquipmentInfoImplCopyWith(
    _$BookingEquipmentInfoImpl value,
    $Res Function(_$BookingEquipmentInfoImpl) then,
  ) = __$$BookingEquipmentInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$BookingEquipmentInfoImplCopyWithImpl<$Res>
    extends _$BookingEquipmentInfoCopyWithImpl<$Res, _$BookingEquipmentInfoImpl>
    implements _$$BookingEquipmentInfoImplCopyWith<$Res> {
  __$$BookingEquipmentInfoImplCopyWithImpl(
    _$BookingEquipmentInfoImpl _value,
    $Res Function(_$BookingEquipmentInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookingEquipmentInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$BookingEquipmentInfoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingEquipmentInfoImpl implements _BookingEquipmentInfo {
  const _$BookingEquipmentInfoImpl({required this.id, required this.name});

  factory _$BookingEquipmentInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingEquipmentInfoImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'BookingEquipmentInfo(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingEquipmentInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of BookingEquipmentInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingEquipmentInfoImplCopyWith<_$BookingEquipmentInfoImpl>
  get copyWith =>
      __$$BookingEquipmentInfoImplCopyWithImpl<_$BookingEquipmentInfoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingEquipmentInfoImplToJson(this);
  }
}

abstract class _BookingEquipmentInfo implements BookingEquipmentInfo {
  const factory _BookingEquipmentInfo({
    required final int id,
    required final String name,
  }) = _$BookingEquipmentInfoImpl;

  factory _BookingEquipmentInfo.fromJson(Map<String, dynamic> json) =
      _$BookingEquipmentInfoImpl.fromJson;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of BookingEquipmentInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingEquipmentInfoImplCopyWith<_$BookingEquipmentInfoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) {
  return _BookingModel.fromJson(json);
}

/// @nodoc
mixin _$BookingModel {
  int get id => throw _privateConstructorUsedError;
  BookingSlotInfo? get slot => throw _privateConstructorUsedError;
  BookingEquipmentInfo? get equipment => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'priority_score')
  double? get priorityScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'queue_position')
  int? get queuePosition => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'allocated_at')
  String? get allocatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_cutoff_at')
  String? get bookingCutoffAt => throw _privateConstructorUsedError;

  /// Serializes this BookingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingModelCopyWith<BookingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingModelCopyWith<$Res> {
  factory $BookingModelCopyWith(
    BookingModel value,
    $Res Function(BookingModel) then,
  ) = _$BookingModelCopyWithImpl<$Res, BookingModel>;
  @useResult
  $Res call({
    int id,
    BookingSlotInfo? slot,
    BookingEquipmentInfo? equipment,
    String status,
    @JsonKey(name: 'priority_score') double? priorityScore,
    @JsonKey(name: 'queue_position') int? queuePosition,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'allocated_at') String? allocatedAt,
    @JsonKey(name: 'booking_cutoff_at') String? bookingCutoffAt,
  });

  $BookingSlotInfoCopyWith<$Res>? get slot;
  $BookingEquipmentInfoCopyWith<$Res>? get equipment;
}

/// @nodoc
class _$BookingModelCopyWithImpl<$Res, $Val extends BookingModel>
    implements $BookingModelCopyWith<$Res> {
  _$BookingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? slot = freezed,
    Object? equipment = freezed,
    Object? status = null,
    Object? priorityScore = freezed,
    Object? queuePosition = freezed,
    Object? createdAt = null,
    Object? allocatedAt = freezed,
    Object? bookingCutoffAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            slot: freezed == slot
                ? _value.slot
                : slot // ignore: cast_nullable_to_non_nullable
                      as BookingSlotInfo?,
            equipment: freezed == equipment
                ? _value.equipment
                : equipment // ignore: cast_nullable_to_non_nullable
                      as BookingEquipmentInfo?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            priorityScore: freezed == priorityScore
                ? _value.priorityScore
                : priorityScore // ignore: cast_nullable_to_non_nullable
                      as double?,
            queuePosition: freezed == queuePosition
                ? _value.queuePosition
                : queuePosition // ignore: cast_nullable_to_non_nullable
                      as int?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            allocatedAt: freezed == allocatedAt
                ? _value.allocatedAt
                : allocatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            bookingCutoffAt: freezed == bookingCutoffAt
                ? _value.bookingCutoffAt
                : bookingCutoffAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BookingSlotInfoCopyWith<$Res>? get slot {
    if (_value.slot == null) {
      return null;
    }

    return $BookingSlotInfoCopyWith<$Res>(_value.slot!, (value) {
      return _then(_value.copyWith(slot: value) as $Val);
    });
  }

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BookingEquipmentInfoCopyWith<$Res>? get equipment {
    if (_value.equipment == null) {
      return null;
    }

    return $BookingEquipmentInfoCopyWith<$Res>(_value.equipment!, (value) {
      return _then(_value.copyWith(equipment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BookingModelImplCopyWith<$Res>
    implements $BookingModelCopyWith<$Res> {
  factory _$$BookingModelImplCopyWith(
    _$BookingModelImpl value,
    $Res Function(_$BookingModelImpl) then,
  ) = __$$BookingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    BookingSlotInfo? slot,
    BookingEquipmentInfo? equipment,
    String status,
    @JsonKey(name: 'priority_score') double? priorityScore,
    @JsonKey(name: 'queue_position') int? queuePosition,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'allocated_at') String? allocatedAt,
    @JsonKey(name: 'booking_cutoff_at') String? bookingCutoffAt,
  });

  @override
  $BookingSlotInfoCopyWith<$Res>? get slot;
  @override
  $BookingEquipmentInfoCopyWith<$Res>? get equipment;
}

/// @nodoc
class __$$BookingModelImplCopyWithImpl<$Res>
    extends _$BookingModelCopyWithImpl<$Res, _$BookingModelImpl>
    implements _$$BookingModelImplCopyWith<$Res> {
  __$$BookingModelImplCopyWithImpl(
    _$BookingModelImpl _value,
    $Res Function(_$BookingModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? slot = freezed,
    Object? equipment = freezed,
    Object? status = null,
    Object? priorityScore = freezed,
    Object? queuePosition = freezed,
    Object? createdAt = null,
    Object? allocatedAt = freezed,
    Object? bookingCutoffAt = freezed,
  }) {
    return _then(
      _$BookingModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        slot: freezed == slot
            ? _value.slot
            : slot // ignore: cast_nullable_to_non_nullable
                  as BookingSlotInfo?,
        equipment: freezed == equipment
            ? _value.equipment
            : equipment // ignore: cast_nullable_to_non_nullable
                  as BookingEquipmentInfo?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        priorityScore: freezed == priorityScore
            ? _value.priorityScore
            : priorityScore // ignore: cast_nullable_to_non_nullable
                  as double?,
        queuePosition: freezed == queuePosition
            ? _value.queuePosition
            : queuePosition // ignore: cast_nullable_to_non_nullable
                  as int?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        allocatedAt: freezed == allocatedAt
            ? _value.allocatedAt
            : allocatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        bookingCutoffAt: freezed == bookingCutoffAt
            ? _value.bookingCutoffAt
            : bookingCutoffAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingModelImpl implements _BookingModel {
  const _$BookingModelImpl({
    required this.id,
    this.slot,
    this.equipment,
    required this.status,
    @JsonKey(name: 'priority_score') this.priorityScore,
    @JsonKey(name: 'queue_position') this.queuePosition,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'allocated_at') this.allocatedAt,
    @JsonKey(name: 'booking_cutoff_at') this.bookingCutoffAt,
  });

  factory _$BookingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingModelImplFromJson(json);

  @override
  final int id;
  @override
  final BookingSlotInfo? slot;
  @override
  final BookingEquipmentInfo? equipment;
  @override
  final String status;
  @override
  @JsonKey(name: 'priority_score')
  final double? priorityScore;
  @override
  @JsonKey(name: 'queue_position')
  final int? queuePosition;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'allocated_at')
  final String? allocatedAt;
  @override
  @JsonKey(name: 'booking_cutoff_at')
  final String? bookingCutoffAt;

  @override
  String toString() {
    return 'BookingModel(id: $id, slot: $slot, equipment: $equipment, status: $status, priorityScore: $priorityScore, queuePosition: $queuePosition, createdAt: $createdAt, allocatedAt: $allocatedAt, bookingCutoffAt: $bookingCutoffAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.slot, slot) || other.slot == slot) &&
            (identical(other.equipment, equipment) ||
                other.equipment == equipment) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.priorityScore, priorityScore) ||
                other.priorityScore == priorityScore) &&
            (identical(other.queuePosition, queuePosition) ||
                other.queuePosition == queuePosition) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.allocatedAt, allocatedAt) ||
                other.allocatedAt == allocatedAt) &&
            (identical(other.bookingCutoffAt, bookingCutoffAt) ||
                other.bookingCutoffAt == bookingCutoffAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    slot,
    equipment,
    status,
    priorityScore,
    queuePosition,
    createdAt,
    allocatedAt,
    bookingCutoffAt,
  );

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingModelImplCopyWith<_$BookingModelImpl> get copyWith =>
      __$$BookingModelImplCopyWithImpl<_$BookingModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingModelImplToJson(this);
  }
}

abstract class _BookingModel implements BookingModel {
  const factory _BookingModel({
    required final int id,
    final BookingSlotInfo? slot,
    final BookingEquipmentInfo? equipment,
    required final String status,
    @JsonKey(name: 'priority_score') final double? priorityScore,
    @JsonKey(name: 'queue_position') final int? queuePosition,
    @JsonKey(name: 'created_at') required final String createdAt,
    @JsonKey(name: 'allocated_at') final String? allocatedAt,
    @JsonKey(name: 'booking_cutoff_at') final String? bookingCutoffAt,
  }) = _$BookingModelImpl;

  factory _BookingModel.fromJson(Map<String, dynamic> json) =
      _$BookingModelImpl.fromJson;

  @override
  int get id;
  @override
  BookingSlotInfo? get slot;
  @override
  BookingEquipmentInfo? get equipment;
  @override
  String get status;
  @override
  @JsonKey(name: 'priority_score')
  double? get priorityScore;
  @override
  @JsonKey(name: 'queue_position')
  int? get queuePosition;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'allocated_at')
  String? get allocatedAt;
  @override
  @JsonKey(name: 'booking_cutoff_at')
  String? get bookingCutoffAt;

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingModelImplCopyWith<_$BookingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QueuePosition _$QueuePositionFromJson(Map<String, dynamic> json) {
  return _QueuePosition.fromJson(json);
}

/// @nodoc
mixin _$QueuePosition {
  @JsonKey(name: 'booking_id')
  int get bookingId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'queue_position')
  int? get queuePosition => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_waitlisted')
  int? get totalWaitlisted => throw _privateConstructorUsedError;

  /// Serializes this QueuePosition to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueuePosition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueuePositionCopyWith<QueuePosition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueuePositionCopyWith<$Res> {
  factory $QueuePositionCopyWith(
    QueuePosition value,
    $Res Function(QueuePosition) then,
  ) = _$QueuePositionCopyWithImpl<$Res, QueuePosition>;
  @useResult
  $Res call({
    @JsonKey(name: 'booking_id') int bookingId,
    String status,
    @JsonKey(name: 'queue_position') int? queuePosition,
    @JsonKey(name: 'total_waitlisted') int? totalWaitlisted,
  });
}

/// @nodoc
class _$QueuePositionCopyWithImpl<$Res, $Val extends QueuePosition>
    implements $QueuePositionCopyWith<$Res> {
  _$QueuePositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueuePosition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingId = null,
    Object? status = null,
    Object? queuePosition = freezed,
    Object? totalWaitlisted = freezed,
  }) {
    return _then(
      _value.copyWith(
            bookingId: null == bookingId
                ? _value.bookingId
                : bookingId // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            queuePosition: freezed == queuePosition
                ? _value.queuePosition
                : queuePosition // ignore: cast_nullable_to_non_nullable
                      as int?,
            totalWaitlisted: freezed == totalWaitlisted
                ? _value.totalWaitlisted
                : totalWaitlisted // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QueuePositionImplCopyWith<$Res>
    implements $QueuePositionCopyWith<$Res> {
  factory _$$QueuePositionImplCopyWith(
    _$QueuePositionImpl value,
    $Res Function(_$QueuePositionImpl) then,
  ) = __$$QueuePositionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'booking_id') int bookingId,
    String status,
    @JsonKey(name: 'queue_position') int? queuePosition,
    @JsonKey(name: 'total_waitlisted') int? totalWaitlisted,
  });
}

/// @nodoc
class __$$QueuePositionImplCopyWithImpl<$Res>
    extends _$QueuePositionCopyWithImpl<$Res, _$QueuePositionImpl>
    implements _$$QueuePositionImplCopyWith<$Res> {
  __$$QueuePositionImplCopyWithImpl(
    _$QueuePositionImpl _value,
    $Res Function(_$QueuePositionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueuePosition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingId = null,
    Object? status = null,
    Object? queuePosition = freezed,
    Object? totalWaitlisted = freezed,
  }) {
    return _then(
      _$QueuePositionImpl(
        bookingId: null == bookingId
            ? _value.bookingId
            : bookingId // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        queuePosition: freezed == queuePosition
            ? _value.queuePosition
            : queuePosition // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalWaitlisted: freezed == totalWaitlisted
            ? _value.totalWaitlisted
            : totalWaitlisted // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QueuePositionImpl implements _QueuePosition {
  const _$QueuePositionImpl({
    @JsonKey(name: 'booking_id') required this.bookingId,
    required this.status,
    @JsonKey(name: 'queue_position') this.queuePosition,
    @JsonKey(name: 'total_waitlisted') this.totalWaitlisted,
  });

  factory _$QueuePositionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueuePositionImplFromJson(json);

  @override
  @JsonKey(name: 'booking_id')
  final int bookingId;
  @override
  final String status;
  @override
  @JsonKey(name: 'queue_position')
  final int? queuePosition;
  @override
  @JsonKey(name: 'total_waitlisted')
  final int? totalWaitlisted;

  @override
  String toString() {
    return 'QueuePosition(bookingId: $bookingId, status: $status, queuePosition: $queuePosition, totalWaitlisted: $totalWaitlisted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueuePositionImpl &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.queuePosition, queuePosition) ||
                other.queuePosition == queuePosition) &&
            (identical(other.totalWaitlisted, totalWaitlisted) ||
                other.totalWaitlisted == totalWaitlisted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    bookingId,
    status,
    queuePosition,
    totalWaitlisted,
  );

  /// Create a copy of QueuePosition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueuePositionImplCopyWith<_$QueuePositionImpl> get copyWith =>
      __$$QueuePositionImplCopyWithImpl<_$QueuePositionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QueuePositionImplToJson(this);
  }
}

abstract class _QueuePosition implements QueuePosition {
  const factory _QueuePosition({
    @JsonKey(name: 'booking_id') required final int bookingId,
    required final String status,
    @JsonKey(name: 'queue_position') final int? queuePosition,
    @JsonKey(name: 'total_waitlisted') final int? totalWaitlisted,
  }) = _$QueuePositionImpl;

  factory _QueuePosition.fromJson(Map<String, dynamic> json) =
      _$QueuePositionImpl.fromJson;

  @override
  @JsonKey(name: 'booking_id')
  int get bookingId;
  @override
  String get status;
  @override
  @JsonKey(name: 'queue_position')
  int? get queuePosition;
  @override
  @JsonKey(name: 'total_waitlisted')
  int? get totalWaitlisted;

  /// Create a copy of QueuePosition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueuePositionImplCopyWith<_$QueuePositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
