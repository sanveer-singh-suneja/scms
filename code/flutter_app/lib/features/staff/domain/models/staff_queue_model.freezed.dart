// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_queue_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QueueStudentRef _$QueueStudentRefFromJson(Map<String, dynamic> json) {
  return _QueueStudentRef.fromJson(json);
}

/// @nodoc
mixin _$QueueStudentRef {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_id')
  String? get studentId => throw _privateConstructorUsedError;

  /// Serializes this QueueStudentRef to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueueStudentRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueueStudentRefCopyWith<QueueStudentRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueStudentRefCopyWith<$Res> {
  factory $QueueStudentRefCopyWith(
    QueueStudentRef value,
    $Res Function(QueueStudentRef) then,
  ) = _$QueueStudentRefCopyWithImpl<$Res, QueueStudentRef>;
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(name: 'student_id') String? studentId,
  });
}

/// @nodoc
class _$QueueStudentRefCopyWithImpl<$Res, $Val extends QueueStudentRef>
    implements $QueueStudentRefCopyWith<$Res> {
  _$QueueStudentRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueueStudentRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? studentId = freezed,
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
            studentId: freezed == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QueueStudentRefImplCopyWith<$Res>
    implements $QueueStudentRefCopyWith<$Res> {
  factory _$$QueueStudentRefImplCopyWith(
    _$QueueStudentRefImpl value,
    $Res Function(_$QueueStudentRefImpl) then,
  ) = __$$QueueStudentRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(name: 'student_id') String? studentId,
  });
}

/// @nodoc
class __$$QueueStudentRefImplCopyWithImpl<$Res>
    extends _$QueueStudentRefCopyWithImpl<$Res, _$QueueStudentRefImpl>
    implements _$$QueueStudentRefImplCopyWith<$Res> {
  __$$QueueStudentRefImplCopyWithImpl(
    _$QueueStudentRefImpl _value,
    $Res Function(_$QueueStudentRefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueueStudentRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? studentId = freezed,
  }) {
    return _then(
      _$QueueStudentRefImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        studentId: freezed == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QueueStudentRefImpl implements _QueueStudentRef {
  const _$QueueStudentRefImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'student_id') this.studentId,
  });

  factory _$QueueStudentRefImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueueStudentRefImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'student_id')
  final String? studentId;

  @override
  String toString() {
    return 'QueueStudentRef(id: $id, name: $name, studentId: $studentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueStudentRefImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, studentId);

  /// Create a copy of QueueStudentRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueStudentRefImplCopyWith<_$QueueStudentRefImpl> get copyWith =>
      __$$QueueStudentRefImplCopyWithImpl<_$QueueStudentRefImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QueueStudentRefImplToJson(this);
  }
}

abstract class _QueueStudentRef implements QueueStudentRef {
  const factory _QueueStudentRef({
    required final int id,
    required final String name,
    @JsonKey(name: 'student_id') final String? studentId,
  }) = _$QueueStudentRefImpl;

  factory _QueueStudentRef.fromJson(Map<String, dynamic> json) =
      _$QueueStudentRefImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'student_id')
  String? get studentId;

  /// Create a copy of QueueStudentRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueStudentRefImplCopyWith<_$QueueStudentRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QueueEquipmentRef _$QueueEquipmentRefFromJson(Map<String, dynamic> json) {
  return _QueueEquipmentRef.fromJson(json);
}

/// @nodoc
mixin _$QueueEquipmentRef {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this QueueEquipmentRef to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueueEquipmentRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueueEquipmentRefCopyWith<QueueEquipmentRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueEquipmentRefCopyWith<$Res> {
  factory $QueueEquipmentRefCopyWith(
    QueueEquipmentRef value,
    $Res Function(QueueEquipmentRef) then,
  ) = _$QueueEquipmentRefCopyWithImpl<$Res, QueueEquipmentRef>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$QueueEquipmentRefCopyWithImpl<$Res, $Val extends QueueEquipmentRef>
    implements $QueueEquipmentRefCopyWith<$Res> {
  _$QueueEquipmentRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueueEquipmentRef
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
abstract class _$$QueueEquipmentRefImplCopyWith<$Res>
    implements $QueueEquipmentRefCopyWith<$Res> {
  factory _$$QueueEquipmentRefImplCopyWith(
    _$QueueEquipmentRefImpl value,
    $Res Function(_$QueueEquipmentRefImpl) then,
  ) = __$$QueueEquipmentRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$QueueEquipmentRefImplCopyWithImpl<$Res>
    extends _$QueueEquipmentRefCopyWithImpl<$Res, _$QueueEquipmentRefImpl>
    implements _$$QueueEquipmentRefImplCopyWith<$Res> {
  __$$QueueEquipmentRefImplCopyWithImpl(
    _$QueueEquipmentRefImpl _value,
    $Res Function(_$QueueEquipmentRefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueueEquipmentRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$QueueEquipmentRefImpl(
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
class _$QueueEquipmentRefImpl implements _QueueEquipmentRef {
  const _$QueueEquipmentRefImpl({required this.id, required this.name});

  factory _$QueueEquipmentRefImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueueEquipmentRefImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'QueueEquipmentRef(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueEquipmentRefImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of QueueEquipmentRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueEquipmentRefImplCopyWith<_$QueueEquipmentRefImpl> get copyWith =>
      __$$QueueEquipmentRefImplCopyWithImpl<_$QueueEquipmentRefImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QueueEquipmentRefImplToJson(this);
  }
}

abstract class _QueueEquipmentRef implements QueueEquipmentRef {
  const factory _QueueEquipmentRef({
    required final int id,
    required final String name,
  }) = _$QueueEquipmentRefImpl;

  factory _QueueEquipmentRef.fromJson(Map<String, dynamic> json) =
      _$QueueEquipmentRefImpl.fromJson;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of QueueEquipmentRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueEquipmentRefImplCopyWith<_$QueueEquipmentRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QueueSlotRef _$QueueSlotRefFromJson(Map<String, dynamic> json) {
  return _QueueSlotRef.fromJson(json);
}

/// @nodoc
mixin _$QueueSlotRef {
  @JsonKey(name: 'start_time')
  String get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_time')
  String get endTime => throw _privateConstructorUsedError;

  /// Serializes this QueueSlotRef to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueueSlotRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueueSlotRefCopyWith<QueueSlotRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueSlotRefCopyWith<$Res> {
  factory $QueueSlotRefCopyWith(
    QueueSlotRef value,
    $Res Function(QueueSlotRef) then,
  ) = _$QueueSlotRefCopyWithImpl<$Res, QueueSlotRef>;
  @useResult
  $Res call({
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String endTime,
  });
}

/// @nodoc
class _$QueueSlotRefCopyWithImpl<$Res, $Val extends QueueSlotRef>
    implements $QueueSlotRefCopyWith<$Res> {
  _$QueueSlotRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueueSlotRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? startTime = null, Object? endTime = null}) {
    return _then(
      _value.copyWith(
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as String,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QueueSlotRefImplCopyWith<$Res>
    implements $QueueSlotRefCopyWith<$Res> {
  factory _$$QueueSlotRefImplCopyWith(
    _$QueueSlotRefImpl value,
    $Res Function(_$QueueSlotRefImpl) then,
  ) = __$$QueueSlotRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String endTime,
  });
}

/// @nodoc
class __$$QueueSlotRefImplCopyWithImpl<$Res>
    extends _$QueueSlotRefCopyWithImpl<$Res, _$QueueSlotRefImpl>
    implements _$$QueueSlotRefImplCopyWith<$Res> {
  __$$QueueSlotRefImplCopyWithImpl(
    _$QueueSlotRefImpl _value,
    $Res Function(_$QueueSlotRefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueueSlotRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? startTime = null, Object? endTime = null}) {
    return _then(
      _$QueueSlotRefImpl(
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as String,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QueueSlotRefImpl implements _QueueSlotRef {
  const _$QueueSlotRefImpl({
    @JsonKey(name: 'start_time') required this.startTime,
    @JsonKey(name: 'end_time') required this.endTime,
  });

  factory _$QueueSlotRefImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueueSlotRefImplFromJson(json);

  @override
  @JsonKey(name: 'start_time')
  final String startTime;
  @override
  @JsonKey(name: 'end_time')
  final String endTime;

  @override
  String toString() {
    return 'QueueSlotRef(startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueSlotRefImpl &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, startTime, endTime);

  /// Create a copy of QueueSlotRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueSlotRefImplCopyWith<_$QueueSlotRefImpl> get copyWith =>
      __$$QueueSlotRefImplCopyWithImpl<_$QueueSlotRefImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QueueSlotRefImplToJson(this);
  }
}

abstract class _QueueSlotRef implements QueueSlotRef {
  const factory _QueueSlotRef({
    @JsonKey(name: 'start_time') required final String startTime,
    @JsonKey(name: 'end_time') required final String endTime,
  }) = _$QueueSlotRefImpl;

  factory _QueueSlotRef.fromJson(Map<String, dynamic> json) =
      _$QueueSlotRefImpl.fromJson;

  @override
  @JsonKey(name: 'start_time')
  String get startTime;
  @override
  @JsonKey(name: 'end_time')
  String get endTime;

  /// Create a copy of QueueSlotRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueSlotRefImplCopyWith<_$QueueSlotRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StaffBookingEntry _$StaffBookingEntryFromJson(Map<String, dynamic> json) {
  return _StaffBookingEntry.fromJson(json);
}

/// @nodoc
mixin _$StaffBookingEntry {
  @JsonKey(name: 'booking_id')
  int get bookingId => throw _privateConstructorUsedError;
  QueueStudentRef get student => throw _privateConstructorUsedError;
  QueueEquipmentRef get equipment => throw _privateConstructorUsedError;
  QueueSlotRef get slot => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this StaffBookingEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StaffBookingEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffBookingEntryCopyWith<StaffBookingEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffBookingEntryCopyWith<$Res> {
  factory $StaffBookingEntryCopyWith(
    StaffBookingEntry value,
    $Res Function(StaffBookingEntry) then,
  ) = _$StaffBookingEntryCopyWithImpl<$Res, StaffBookingEntry>;
  @useResult
  $Res call({
    @JsonKey(name: 'booking_id') int bookingId,
    QueueStudentRef student,
    QueueEquipmentRef equipment,
    QueueSlotRef slot,
    String status,
  });

  $QueueStudentRefCopyWith<$Res> get student;
  $QueueEquipmentRefCopyWith<$Res> get equipment;
  $QueueSlotRefCopyWith<$Res> get slot;
}

/// @nodoc
class _$StaffBookingEntryCopyWithImpl<$Res, $Val extends StaffBookingEntry>
    implements $StaffBookingEntryCopyWith<$Res> {
  _$StaffBookingEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffBookingEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingId = null,
    Object? student = null,
    Object? equipment = null,
    Object? slot = null,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            bookingId: null == bookingId
                ? _value.bookingId
                : bookingId // ignore: cast_nullable_to_non_nullable
                      as int,
            student: null == student
                ? _value.student
                : student // ignore: cast_nullable_to_non_nullable
                      as QueueStudentRef,
            equipment: null == equipment
                ? _value.equipment
                : equipment // ignore: cast_nullable_to_non_nullable
                      as QueueEquipmentRef,
            slot: null == slot
                ? _value.slot
                : slot // ignore: cast_nullable_to_non_nullable
                      as QueueSlotRef,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of StaffBookingEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QueueStudentRefCopyWith<$Res> get student {
    return $QueueStudentRefCopyWith<$Res>(_value.student, (value) {
      return _then(_value.copyWith(student: value) as $Val);
    });
  }

  /// Create a copy of StaffBookingEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QueueEquipmentRefCopyWith<$Res> get equipment {
    return $QueueEquipmentRefCopyWith<$Res>(_value.equipment, (value) {
      return _then(_value.copyWith(equipment: value) as $Val);
    });
  }

  /// Create a copy of StaffBookingEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QueueSlotRefCopyWith<$Res> get slot {
    return $QueueSlotRefCopyWith<$Res>(_value.slot, (value) {
      return _then(_value.copyWith(slot: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StaffBookingEntryImplCopyWith<$Res>
    implements $StaffBookingEntryCopyWith<$Res> {
  factory _$$StaffBookingEntryImplCopyWith(
    _$StaffBookingEntryImpl value,
    $Res Function(_$StaffBookingEntryImpl) then,
  ) = __$$StaffBookingEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'booking_id') int bookingId,
    QueueStudentRef student,
    QueueEquipmentRef equipment,
    QueueSlotRef slot,
    String status,
  });

  @override
  $QueueStudentRefCopyWith<$Res> get student;
  @override
  $QueueEquipmentRefCopyWith<$Res> get equipment;
  @override
  $QueueSlotRefCopyWith<$Res> get slot;
}

/// @nodoc
class __$$StaffBookingEntryImplCopyWithImpl<$Res>
    extends _$StaffBookingEntryCopyWithImpl<$Res, _$StaffBookingEntryImpl>
    implements _$$StaffBookingEntryImplCopyWith<$Res> {
  __$$StaffBookingEntryImplCopyWithImpl(
    _$StaffBookingEntryImpl _value,
    $Res Function(_$StaffBookingEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffBookingEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingId = null,
    Object? student = null,
    Object? equipment = null,
    Object? slot = null,
    Object? status = null,
  }) {
    return _then(
      _$StaffBookingEntryImpl(
        bookingId: null == bookingId
            ? _value.bookingId
            : bookingId // ignore: cast_nullable_to_non_nullable
                  as int,
        student: null == student
            ? _value.student
            : student // ignore: cast_nullable_to_non_nullable
                  as QueueStudentRef,
        equipment: null == equipment
            ? _value.equipment
            : equipment // ignore: cast_nullable_to_non_nullable
                  as QueueEquipmentRef,
        slot: null == slot
            ? _value.slot
            : slot // ignore: cast_nullable_to_non_nullable
                  as QueueSlotRef,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StaffBookingEntryImpl implements _StaffBookingEntry {
  const _$StaffBookingEntryImpl({
    @JsonKey(name: 'booking_id') required this.bookingId,
    required this.student,
    required this.equipment,
    required this.slot,
    required this.status,
  });

  factory _$StaffBookingEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffBookingEntryImplFromJson(json);

  @override
  @JsonKey(name: 'booking_id')
  final int bookingId;
  @override
  final QueueStudentRef student;
  @override
  final QueueEquipmentRef equipment;
  @override
  final QueueSlotRef slot;
  @override
  final String status;

  @override
  String toString() {
    return 'StaffBookingEntry(bookingId: $bookingId, student: $student, equipment: $equipment, slot: $slot, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffBookingEntryImpl &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.student, student) || other.student == student) &&
            (identical(other.equipment, equipment) ||
                other.equipment == equipment) &&
            (identical(other.slot, slot) || other.slot == slot) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, bookingId, student, equipment, slot, status);

  /// Create a copy of StaffBookingEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffBookingEntryImplCopyWith<_$StaffBookingEntryImpl> get copyWith =>
      __$$StaffBookingEntryImplCopyWithImpl<_$StaffBookingEntryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffBookingEntryImplToJson(this);
  }
}

abstract class _StaffBookingEntry implements StaffBookingEntry {
  const factory _StaffBookingEntry({
    @JsonKey(name: 'booking_id') required final int bookingId,
    required final QueueStudentRef student,
    required final QueueEquipmentRef equipment,
    required final QueueSlotRef slot,
    required final String status,
  }) = _$StaffBookingEntryImpl;

  factory _StaffBookingEntry.fromJson(Map<String, dynamic> json) =
      _$StaffBookingEntryImpl.fromJson;

  @override
  @JsonKey(name: 'booking_id')
  int get bookingId;
  @override
  QueueStudentRef get student;
  @override
  QueueEquipmentRef get equipment;
  @override
  QueueSlotRef get slot;
  @override
  String get status;

  /// Create a copy of StaffBookingEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffBookingEntryImplCopyWith<_$StaffBookingEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StaffTransactionEntry _$StaffTransactionEntryFromJson(
  Map<String, dynamic> json,
) {
  return _StaffTransactionEntry.fromJson(json);
}

/// @nodoc
mixin _$StaffTransactionEntry {
  @JsonKey(name: 'transaction_id')
  int get transactionId => throw _privateConstructorUsedError;
  QueueStudentRef get student => throw _privateConstructorUsedError;
  QueueEquipmentRef get equipment => throw _privateConstructorUsedError;
  @JsonKey(name: 'issued_at')
  String get issuedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'due_at')
  String get dueAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this StaffTransactionEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StaffTransactionEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffTransactionEntryCopyWith<StaffTransactionEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffTransactionEntryCopyWith<$Res> {
  factory $StaffTransactionEntryCopyWith(
    StaffTransactionEntry value,
    $Res Function(StaffTransactionEntry) then,
  ) = _$StaffTransactionEntryCopyWithImpl<$Res, StaffTransactionEntry>;
  @useResult
  $Res call({
    @JsonKey(name: 'transaction_id') int transactionId,
    QueueStudentRef student,
    QueueEquipmentRef equipment,
    @JsonKey(name: 'issued_at') String issuedAt,
    @JsonKey(name: 'due_at') String dueAt,
    String status,
  });

  $QueueStudentRefCopyWith<$Res> get student;
  $QueueEquipmentRefCopyWith<$Res> get equipment;
}

/// @nodoc
class _$StaffTransactionEntryCopyWithImpl<
  $Res,
  $Val extends StaffTransactionEntry
>
    implements $StaffTransactionEntryCopyWith<$Res> {
  _$StaffTransactionEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffTransactionEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? student = null,
    Object? equipment = null,
    Object? issuedAt = null,
    Object? dueAt = null,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            transactionId: null == transactionId
                ? _value.transactionId
                : transactionId // ignore: cast_nullable_to_non_nullable
                      as int,
            student: null == student
                ? _value.student
                : student // ignore: cast_nullable_to_non_nullable
                      as QueueStudentRef,
            equipment: null == equipment
                ? _value.equipment
                : equipment // ignore: cast_nullable_to_non_nullable
                      as QueueEquipmentRef,
            issuedAt: null == issuedAt
                ? _value.issuedAt
                : issuedAt // ignore: cast_nullable_to_non_nullable
                      as String,
            dueAt: null == dueAt
                ? _value.dueAt
                : dueAt // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of StaffTransactionEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QueueStudentRefCopyWith<$Res> get student {
    return $QueueStudentRefCopyWith<$Res>(_value.student, (value) {
      return _then(_value.copyWith(student: value) as $Val);
    });
  }

  /// Create a copy of StaffTransactionEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QueueEquipmentRefCopyWith<$Res> get equipment {
    return $QueueEquipmentRefCopyWith<$Res>(_value.equipment, (value) {
      return _then(_value.copyWith(equipment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StaffTransactionEntryImplCopyWith<$Res>
    implements $StaffTransactionEntryCopyWith<$Res> {
  factory _$$StaffTransactionEntryImplCopyWith(
    _$StaffTransactionEntryImpl value,
    $Res Function(_$StaffTransactionEntryImpl) then,
  ) = __$$StaffTransactionEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'transaction_id') int transactionId,
    QueueStudentRef student,
    QueueEquipmentRef equipment,
    @JsonKey(name: 'issued_at') String issuedAt,
    @JsonKey(name: 'due_at') String dueAt,
    String status,
  });

  @override
  $QueueStudentRefCopyWith<$Res> get student;
  @override
  $QueueEquipmentRefCopyWith<$Res> get equipment;
}

/// @nodoc
class __$$StaffTransactionEntryImplCopyWithImpl<$Res>
    extends
        _$StaffTransactionEntryCopyWithImpl<$Res, _$StaffTransactionEntryImpl>
    implements _$$StaffTransactionEntryImplCopyWith<$Res> {
  __$$StaffTransactionEntryImplCopyWithImpl(
    _$StaffTransactionEntryImpl _value,
    $Res Function(_$StaffTransactionEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffTransactionEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? student = null,
    Object? equipment = null,
    Object? issuedAt = null,
    Object? dueAt = null,
    Object? status = null,
  }) {
    return _then(
      _$StaffTransactionEntryImpl(
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as int,
        student: null == student
            ? _value.student
            : student // ignore: cast_nullable_to_non_nullable
                  as QueueStudentRef,
        equipment: null == equipment
            ? _value.equipment
            : equipment // ignore: cast_nullable_to_non_nullable
                  as QueueEquipmentRef,
        issuedAt: null == issuedAt
            ? _value.issuedAt
            : issuedAt // ignore: cast_nullable_to_non_nullable
                  as String,
        dueAt: null == dueAt
            ? _value.dueAt
            : dueAt // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StaffTransactionEntryImpl implements _StaffTransactionEntry {
  const _$StaffTransactionEntryImpl({
    @JsonKey(name: 'transaction_id') required this.transactionId,
    required this.student,
    required this.equipment,
    @JsonKey(name: 'issued_at') required this.issuedAt,
    @JsonKey(name: 'due_at') required this.dueAt,
    required this.status,
  });

  factory _$StaffTransactionEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffTransactionEntryImplFromJson(json);

  @override
  @JsonKey(name: 'transaction_id')
  final int transactionId;
  @override
  final QueueStudentRef student;
  @override
  final QueueEquipmentRef equipment;
  @override
  @JsonKey(name: 'issued_at')
  final String issuedAt;
  @override
  @JsonKey(name: 'due_at')
  final String dueAt;
  @override
  final String status;

  @override
  String toString() {
    return 'StaffTransactionEntry(transactionId: $transactionId, student: $student, equipment: $equipment, issuedAt: $issuedAt, dueAt: $dueAt, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffTransactionEntryImpl &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.student, student) || other.student == student) &&
            (identical(other.equipment, equipment) ||
                other.equipment == equipment) &&
            (identical(other.issuedAt, issuedAt) ||
                other.issuedAt == issuedAt) &&
            (identical(other.dueAt, dueAt) || other.dueAt == dueAt) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    transactionId,
    student,
    equipment,
    issuedAt,
    dueAt,
    status,
  );

  /// Create a copy of StaffTransactionEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffTransactionEntryImplCopyWith<_$StaffTransactionEntryImpl>
  get copyWith =>
      __$$StaffTransactionEntryImplCopyWithImpl<_$StaffTransactionEntryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffTransactionEntryImplToJson(this);
  }
}

abstract class _StaffTransactionEntry implements StaffTransactionEntry {
  const factory _StaffTransactionEntry({
    @JsonKey(name: 'transaction_id') required final int transactionId,
    required final QueueStudentRef student,
    required final QueueEquipmentRef equipment,
    @JsonKey(name: 'issued_at') required final String issuedAt,
    @JsonKey(name: 'due_at') required final String dueAt,
    required final String status,
  }) = _$StaffTransactionEntryImpl;

  factory _StaffTransactionEntry.fromJson(Map<String, dynamic> json) =
      _$StaffTransactionEntryImpl.fromJson;

  @override
  @JsonKey(name: 'transaction_id')
  int get transactionId;
  @override
  QueueStudentRef get student;
  @override
  QueueEquipmentRef get equipment;
  @override
  @JsonKey(name: 'issued_at')
  String get issuedAt;
  @override
  @JsonKey(name: 'due_at')
  String get dueAt;
  @override
  String get status;

  /// Create a copy of StaffTransactionEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffTransactionEntryImplCopyWith<_$StaffTransactionEntryImpl>
  get copyWith => throw _privateConstructorUsedError;
}

StaffQueueModel _$StaffQueueModelFromJson(Map<String, dynamic> json) {
  return _StaffQueueModel.fromJson(json);
}

/// @nodoc
mixin _$StaffQueueModel {
  @JsonKey(name: 'confirmed_bookings_today')
  List<StaffBookingEntry> get confirmedBookingsToday =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'open_transactions')
  List<StaffTransactionEntry> get openTransactions =>
      throw _privateConstructorUsedError;

  /// Serializes this StaffQueueModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StaffQueueModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffQueueModelCopyWith<StaffQueueModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffQueueModelCopyWith<$Res> {
  factory $StaffQueueModelCopyWith(
    StaffQueueModel value,
    $Res Function(StaffQueueModel) then,
  ) = _$StaffQueueModelCopyWithImpl<$Res, StaffQueueModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'confirmed_bookings_today')
    List<StaffBookingEntry> confirmedBookingsToday,
    @JsonKey(name: 'open_transactions')
    List<StaffTransactionEntry> openTransactions,
  });
}

/// @nodoc
class _$StaffQueueModelCopyWithImpl<$Res, $Val extends StaffQueueModel>
    implements $StaffQueueModelCopyWith<$Res> {
  _$StaffQueueModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffQueueModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? confirmedBookingsToday = null,
    Object? openTransactions = null,
  }) {
    return _then(
      _value.copyWith(
            confirmedBookingsToday: null == confirmedBookingsToday
                ? _value.confirmedBookingsToday
                : confirmedBookingsToday // ignore: cast_nullable_to_non_nullable
                      as List<StaffBookingEntry>,
            openTransactions: null == openTransactions
                ? _value.openTransactions
                : openTransactions // ignore: cast_nullable_to_non_nullable
                      as List<StaffTransactionEntry>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StaffQueueModelImplCopyWith<$Res>
    implements $StaffQueueModelCopyWith<$Res> {
  factory _$$StaffQueueModelImplCopyWith(
    _$StaffQueueModelImpl value,
    $Res Function(_$StaffQueueModelImpl) then,
  ) = __$$StaffQueueModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'confirmed_bookings_today')
    List<StaffBookingEntry> confirmedBookingsToday,
    @JsonKey(name: 'open_transactions')
    List<StaffTransactionEntry> openTransactions,
  });
}

/// @nodoc
class __$$StaffQueueModelImplCopyWithImpl<$Res>
    extends _$StaffQueueModelCopyWithImpl<$Res, _$StaffQueueModelImpl>
    implements _$$StaffQueueModelImplCopyWith<$Res> {
  __$$StaffQueueModelImplCopyWithImpl(
    _$StaffQueueModelImpl _value,
    $Res Function(_$StaffQueueModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffQueueModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? confirmedBookingsToday = null,
    Object? openTransactions = null,
  }) {
    return _then(
      _$StaffQueueModelImpl(
        confirmedBookingsToday: null == confirmedBookingsToday
            ? _value._confirmedBookingsToday
            : confirmedBookingsToday // ignore: cast_nullable_to_non_nullable
                  as List<StaffBookingEntry>,
        openTransactions: null == openTransactions
            ? _value._openTransactions
            : openTransactions // ignore: cast_nullable_to_non_nullable
                  as List<StaffTransactionEntry>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StaffQueueModelImpl implements _StaffQueueModel {
  const _$StaffQueueModelImpl({
    @JsonKey(name: 'confirmed_bookings_today')
    required final List<StaffBookingEntry> confirmedBookingsToday,
    @JsonKey(name: 'open_transactions')
    required final List<StaffTransactionEntry> openTransactions,
  }) : _confirmedBookingsToday = confirmedBookingsToday,
       _openTransactions = openTransactions;

  factory _$StaffQueueModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffQueueModelImplFromJson(json);

  final List<StaffBookingEntry> _confirmedBookingsToday;
  @override
  @JsonKey(name: 'confirmed_bookings_today')
  List<StaffBookingEntry> get confirmedBookingsToday {
    if (_confirmedBookingsToday is EqualUnmodifiableListView)
      return _confirmedBookingsToday;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_confirmedBookingsToday);
  }

  final List<StaffTransactionEntry> _openTransactions;
  @override
  @JsonKey(name: 'open_transactions')
  List<StaffTransactionEntry> get openTransactions {
    if (_openTransactions is EqualUnmodifiableListView)
      return _openTransactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_openTransactions);
  }

  @override
  String toString() {
    return 'StaffQueueModel(confirmedBookingsToday: $confirmedBookingsToday, openTransactions: $openTransactions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffQueueModelImpl &&
            const DeepCollectionEquality().equals(
              other._confirmedBookingsToday,
              _confirmedBookingsToday,
            ) &&
            const DeepCollectionEquality().equals(
              other._openTransactions,
              _openTransactions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_confirmedBookingsToday),
    const DeepCollectionEquality().hash(_openTransactions),
  );

  /// Create a copy of StaffQueueModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffQueueModelImplCopyWith<_$StaffQueueModelImpl> get copyWith =>
      __$$StaffQueueModelImplCopyWithImpl<_$StaffQueueModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffQueueModelImplToJson(this);
  }
}

abstract class _StaffQueueModel implements StaffQueueModel {
  const factory _StaffQueueModel({
    @JsonKey(name: 'confirmed_bookings_today')
    required final List<StaffBookingEntry> confirmedBookingsToday,
    @JsonKey(name: 'open_transactions')
    required final List<StaffTransactionEntry> openTransactions,
  }) = _$StaffQueueModelImpl;

  factory _StaffQueueModel.fromJson(Map<String, dynamic> json) =
      _$StaffQueueModelImpl.fromJson;

  @override
  @JsonKey(name: 'confirmed_bookings_today')
  List<StaffBookingEntry> get confirmedBookingsToday;
  @override
  @JsonKey(name: 'open_transactions')
  List<StaffTransactionEntry> get openTransactions;

  /// Create a copy of StaffQueueModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffQueueModelImplCopyWith<_$StaffQueueModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
