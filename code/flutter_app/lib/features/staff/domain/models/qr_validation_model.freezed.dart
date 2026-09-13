// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_validation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QrStudentInfo _$QrStudentInfoFromJson(Map<String, dynamic> json) {
  return _QrStudentInfo.fromJson(json);
}

/// @nodoc
mixin _$QrStudentInfo {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_id')
  String get studentId => throw _privateConstructorUsedError;
  String? get department => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  /// Serializes this QrStudentInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QrStudentInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QrStudentInfoCopyWith<QrStudentInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QrStudentInfoCopyWith<$Res> {
  factory $QrStudentInfoCopyWith(
    QrStudentInfo value,
    $Res Function(QrStudentInfo) then,
  ) = _$QrStudentInfoCopyWithImpl<$Res, QrStudentInfo>;
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(name: 'student_id') String studentId,
    String? department,
    String? status,
  });
}

/// @nodoc
class _$QrStudentInfoCopyWithImpl<$Res, $Val extends QrStudentInfo>
    implements $QrStudentInfoCopyWith<$Res> {
  _$QrStudentInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QrStudentInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? studentId = null,
    Object? department = freezed,
    Object? status = freezed,
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
            studentId: null == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as String,
            department: freezed == department
                ? _value.department
                : department // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QrStudentInfoImplCopyWith<$Res>
    implements $QrStudentInfoCopyWith<$Res> {
  factory _$$QrStudentInfoImplCopyWith(
    _$QrStudentInfoImpl value,
    $Res Function(_$QrStudentInfoImpl) then,
  ) = __$$QrStudentInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(name: 'student_id') String studentId,
    String? department,
    String? status,
  });
}

/// @nodoc
class __$$QrStudentInfoImplCopyWithImpl<$Res>
    extends _$QrStudentInfoCopyWithImpl<$Res, _$QrStudentInfoImpl>
    implements _$$QrStudentInfoImplCopyWith<$Res> {
  __$$QrStudentInfoImplCopyWithImpl(
    _$QrStudentInfoImpl _value,
    $Res Function(_$QrStudentInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QrStudentInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? studentId = null,
    Object? department = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _$QrStudentInfoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        studentId: null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as String,
        department: freezed == department
            ? _value.department
            : department // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QrStudentInfoImpl implements _QrStudentInfo {
  const _$QrStudentInfoImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'student_id') required this.studentId,
    this.department,
    this.status,
  });

  factory _$QrStudentInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$QrStudentInfoImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'student_id')
  final String studentId;
  @override
  final String? department;
  @override
  final String? status;

  @override
  String toString() {
    return 'QrStudentInfo(id: $id, name: $name, studentId: $studentId, department: $department, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QrStudentInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, studentId, department, status);

  /// Create a copy of QrStudentInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QrStudentInfoImplCopyWith<_$QrStudentInfoImpl> get copyWith =>
      __$$QrStudentInfoImplCopyWithImpl<_$QrStudentInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QrStudentInfoImplToJson(this);
  }
}

abstract class _QrStudentInfo implements QrStudentInfo {
  const factory _QrStudentInfo({
    required final int id,
    required final String name,
    @JsonKey(name: 'student_id') required final String studentId,
    final String? department,
    final String? status,
  }) = _$QrStudentInfoImpl;

  factory _QrStudentInfo.fromJson(Map<String, dynamic> json) =
      _$QrStudentInfoImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'student_id')
  String get studentId;
  @override
  String? get department;
  @override
  String? get status;

  /// Create a copy of QrStudentInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QrStudentInfoImplCopyWith<_$QrStudentInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QrEquipmentRef _$QrEquipmentRefFromJson(Map<String, dynamic> json) {
  return _QrEquipmentRef.fromJson(json);
}

/// @nodoc
mixin _$QrEquipmentRef {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this QrEquipmentRef to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QrEquipmentRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QrEquipmentRefCopyWith<QrEquipmentRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QrEquipmentRefCopyWith<$Res> {
  factory $QrEquipmentRefCopyWith(
    QrEquipmentRef value,
    $Res Function(QrEquipmentRef) then,
  ) = _$QrEquipmentRefCopyWithImpl<$Res, QrEquipmentRef>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$QrEquipmentRefCopyWithImpl<$Res, $Val extends QrEquipmentRef>
    implements $QrEquipmentRefCopyWith<$Res> {
  _$QrEquipmentRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QrEquipmentRef
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
abstract class _$$QrEquipmentRefImplCopyWith<$Res>
    implements $QrEquipmentRefCopyWith<$Res> {
  factory _$$QrEquipmentRefImplCopyWith(
    _$QrEquipmentRefImpl value,
    $Res Function(_$QrEquipmentRefImpl) then,
  ) = __$$QrEquipmentRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$QrEquipmentRefImplCopyWithImpl<$Res>
    extends _$QrEquipmentRefCopyWithImpl<$Res, _$QrEquipmentRefImpl>
    implements _$$QrEquipmentRefImplCopyWith<$Res> {
  __$$QrEquipmentRefImplCopyWithImpl(
    _$QrEquipmentRefImpl _value,
    $Res Function(_$QrEquipmentRefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QrEquipmentRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$QrEquipmentRefImpl(
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
class _$QrEquipmentRefImpl implements _QrEquipmentRef {
  const _$QrEquipmentRefImpl({required this.id, required this.name});

  factory _$QrEquipmentRefImpl.fromJson(Map<String, dynamic> json) =>
      _$$QrEquipmentRefImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'QrEquipmentRef(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QrEquipmentRefImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of QrEquipmentRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QrEquipmentRefImplCopyWith<_$QrEquipmentRefImpl> get copyWith =>
      __$$QrEquipmentRefImplCopyWithImpl<_$QrEquipmentRefImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QrEquipmentRefImplToJson(this);
  }
}

abstract class _QrEquipmentRef implements QrEquipmentRef {
  const factory _QrEquipmentRef({
    required final int id,
    required final String name,
  }) = _$QrEquipmentRefImpl;

  factory _QrEquipmentRef.fromJson(Map<String, dynamic> json) =
      _$QrEquipmentRefImpl.fromJson;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of QrEquipmentRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QrEquipmentRefImplCopyWith<_$QrEquipmentRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QrSlotRef _$QrSlotRefFromJson(Map<String, dynamic> json) {
  return _QrSlotRef.fromJson(json);
}

/// @nodoc
mixin _$QrSlotRef {
  int? get id => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_time')
  String get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_time')
  String get endTime => throw _privateConstructorUsedError;

  /// Serializes this QrSlotRef to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QrSlotRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QrSlotRefCopyWith<QrSlotRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QrSlotRefCopyWith<$Res> {
  factory $QrSlotRefCopyWith(QrSlotRef value, $Res Function(QrSlotRef) then) =
      _$QrSlotRefCopyWithImpl<$Res, QrSlotRef>;
  @useResult
  $Res call({
    int? id,
    String? date,
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String endTime,
  });
}

/// @nodoc
class _$QrSlotRefCopyWithImpl<$Res, $Val extends QrSlotRef>
    implements $QrSlotRefCopyWith<$Res> {
  _$QrSlotRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QrSlotRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? date = freezed,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            date: freezed == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$QrSlotRefImplCopyWith<$Res>
    implements $QrSlotRefCopyWith<$Res> {
  factory _$$QrSlotRefImplCopyWith(
    _$QrSlotRefImpl value,
    $Res Function(_$QrSlotRefImpl) then,
  ) = __$$QrSlotRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    String? date,
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String endTime,
  });
}

/// @nodoc
class __$$QrSlotRefImplCopyWithImpl<$Res>
    extends _$QrSlotRefCopyWithImpl<$Res, _$QrSlotRefImpl>
    implements _$$QrSlotRefImplCopyWith<$Res> {
  __$$QrSlotRefImplCopyWithImpl(
    _$QrSlotRefImpl _value,
    $Res Function(_$QrSlotRefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QrSlotRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? date = freezed,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(
      _$QrSlotRefImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        date: freezed == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$QrSlotRefImpl implements _QrSlotRef {
  const _$QrSlotRefImpl({
    this.id,
    this.date,
    @JsonKey(name: 'start_time') required this.startTime,
    @JsonKey(name: 'end_time') required this.endTime,
  });

  factory _$QrSlotRefImpl.fromJson(Map<String, dynamic> json) =>
      _$$QrSlotRefImplFromJson(json);

  @override
  final int? id;
  @override
  final String? date;
  @override
  @JsonKey(name: 'start_time')
  final String startTime;
  @override
  @JsonKey(name: 'end_time')
  final String endTime;

  @override
  String toString() {
    return 'QrSlotRef(id: $id, date: $date, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QrSlotRefImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, date, startTime, endTime);

  /// Create a copy of QrSlotRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QrSlotRefImplCopyWith<_$QrSlotRefImpl> get copyWith =>
      __$$QrSlotRefImplCopyWithImpl<_$QrSlotRefImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QrSlotRefImplToJson(this);
  }
}

abstract class _QrSlotRef implements QrSlotRef {
  const factory _QrSlotRef({
    final int? id,
    final String? date,
    @JsonKey(name: 'start_time') required final String startTime,
    @JsonKey(name: 'end_time') required final String endTime,
  }) = _$QrSlotRefImpl;

  factory _QrSlotRef.fromJson(Map<String, dynamic> json) =
      _$QrSlotRefImpl.fromJson;

  @override
  int? get id;
  @override
  String? get date;
  @override
  @JsonKey(name: 'start_time')
  String get startTime;
  @override
  @JsonKey(name: 'end_time')
  String get endTime;

  /// Create a copy of QrSlotRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QrSlotRefImplCopyWith<_$QrSlotRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QrBookingInfo _$QrBookingInfoFromJson(Map<String, dynamic> json) {
  return _QrBookingInfo.fromJson(json);
}

/// @nodoc
mixin _$QrBookingInfo {
  int get id => throw _privateConstructorUsedError;
  QrEquipmentRef get equipment => throw _privateConstructorUsedError;
  QrSlotRef? get slot => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this QrBookingInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QrBookingInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QrBookingInfoCopyWith<QrBookingInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QrBookingInfoCopyWith<$Res> {
  factory $QrBookingInfoCopyWith(
    QrBookingInfo value,
    $Res Function(QrBookingInfo) then,
  ) = _$QrBookingInfoCopyWithImpl<$Res, QrBookingInfo>;
  @useResult
  $Res call({int id, QrEquipmentRef equipment, QrSlotRef? slot, String status});

  $QrEquipmentRefCopyWith<$Res> get equipment;
  $QrSlotRefCopyWith<$Res>? get slot;
}

/// @nodoc
class _$QrBookingInfoCopyWithImpl<$Res, $Val extends QrBookingInfo>
    implements $QrBookingInfoCopyWith<$Res> {
  _$QrBookingInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QrBookingInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? equipment = null,
    Object? slot = freezed,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            equipment: null == equipment
                ? _value.equipment
                : equipment // ignore: cast_nullable_to_non_nullable
                      as QrEquipmentRef,
            slot: freezed == slot
                ? _value.slot
                : slot // ignore: cast_nullable_to_non_nullable
                      as QrSlotRef?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of QrBookingInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QrEquipmentRefCopyWith<$Res> get equipment {
    return $QrEquipmentRefCopyWith<$Res>(_value.equipment, (value) {
      return _then(_value.copyWith(equipment: value) as $Val);
    });
  }

  /// Create a copy of QrBookingInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QrSlotRefCopyWith<$Res>? get slot {
    if (_value.slot == null) {
      return null;
    }

    return $QrSlotRefCopyWith<$Res>(_value.slot!, (value) {
      return _then(_value.copyWith(slot: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QrBookingInfoImplCopyWith<$Res>
    implements $QrBookingInfoCopyWith<$Res> {
  factory _$$QrBookingInfoImplCopyWith(
    _$QrBookingInfoImpl value,
    $Res Function(_$QrBookingInfoImpl) then,
  ) = __$$QrBookingInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, QrEquipmentRef equipment, QrSlotRef? slot, String status});

  @override
  $QrEquipmentRefCopyWith<$Res> get equipment;
  @override
  $QrSlotRefCopyWith<$Res>? get slot;
}

/// @nodoc
class __$$QrBookingInfoImplCopyWithImpl<$Res>
    extends _$QrBookingInfoCopyWithImpl<$Res, _$QrBookingInfoImpl>
    implements _$$QrBookingInfoImplCopyWith<$Res> {
  __$$QrBookingInfoImplCopyWithImpl(
    _$QrBookingInfoImpl _value,
    $Res Function(_$QrBookingInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QrBookingInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? equipment = null,
    Object? slot = freezed,
    Object? status = null,
  }) {
    return _then(
      _$QrBookingInfoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        equipment: null == equipment
            ? _value.equipment
            : equipment // ignore: cast_nullable_to_non_nullable
                  as QrEquipmentRef,
        slot: freezed == slot
            ? _value.slot
            : slot // ignore: cast_nullable_to_non_nullable
                  as QrSlotRef?,
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
class _$QrBookingInfoImpl implements _QrBookingInfo {
  const _$QrBookingInfoImpl({
    required this.id,
    required this.equipment,
    this.slot,
    required this.status,
  });

  factory _$QrBookingInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$QrBookingInfoImplFromJson(json);

  @override
  final int id;
  @override
  final QrEquipmentRef equipment;
  @override
  final QrSlotRef? slot;
  @override
  final String status;

  @override
  String toString() {
    return 'QrBookingInfo(id: $id, equipment: $equipment, slot: $slot, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QrBookingInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.equipment, equipment) ||
                other.equipment == equipment) &&
            (identical(other.slot, slot) || other.slot == slot) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, equipment, slot, status);

  /// Create a copy of QrBookingInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QrBookingInfoImplCopyWith<_$QrBookingInfoImpl> get copyWith =>
      __$$QrBookingInfoImplCopyWithImpl<_$QrBookingInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QrBookingInfoImplToJson(this);
  }
}

abstract class _QrBookingInfo implements QrBookingInfo {
  const factory _QrBookingInfo({
    required final int id,
    required final QrEquipmentRef equipment,
    final QrSlotRef? slot,
    required final String status,
  }) = _$QrBookingInfoImpl;

  factory _QrBookingInfo.fromJson(Map<String, dynamic> json) =
      _$QrBookingInfoImpl.fromJson;

  @override
  int get id;
  @override
  QrEquipmentRef get equipment;
  @override
  QrSlotRef? get slot;
  @override
  String get status;

  /// Create a copy of QrBookingInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QrBookingInfoImplCopyWith<_$QrBookingInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QrTransactionInfo _$QrTransactionInfoFromJson(Map<String, dynamic> json) {
  return _QrTransactionInfo.fromJson(json);
}

/// @nodoc
mixin _$QrTransactionInfo {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_id')
  int? get studentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'equipment_id')
  int? get equipmentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'equipment_name')
  String? get equipmentName => throw _privateConstructorUsedError;
  @JsonKey(name: 'issued_at')
  String get issuedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'due_at')
  String get dueAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'issued_by')
  int? get issuedBy => throw _privateConstructorUsedError;

  /// Serializes this QrTransactionInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QrTransactionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QrTransactionInfoCopyWith<QrTransactionInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QrTransactionInfoCopyWith<$Res> {
  factory $QrTransactionInfoCopyWith(
    QrTransactionInfo value,
    $Res Function(QrTransactionInfo) then,
  ) = _$QrTransactionInfoCopyWithImpl<$Res, QrTransactionInfo>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'equipment_id') int? equipmentId,
    @JsonKey(name: 'equipment_name') String? equipmentName,
    @JsonKey(name: 'issued_at') String issuedAt,
    @JsonKey(name: 'due_at') String dueAt,
    String status,
    @JsonKey(name: 'issued_by') int? issuedBy,
  });
}

/// @nodoc
class _$QrTransactionInfoCopyWithImpl<$Res, $Val extends QrTransactionInfo>
    implements $QrTransactionInfoCopyWith<$Res> {
  _$QrTransactionInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QrTransactionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = freezed,
    Object? equipmentId = freezed,
    Object? equipmentName = freezed,
    Object? issuedAt = null,
    Object? dueAt = null,
    Object? status = null,
    Object? issuedBy = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            studentId: freezed == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as int?,
            equipmentId: freezed == equipmentId
                ? _value.equipmentId
                : equipmentId // ignore: cast_nullable_to_non_nullable
                      as int?,
            equipmentName: freezed == equipmentName
                ? _value.equipmentName
                : equipmentName // ignore: cast_nullable_to_non_nullable
                      as String?,
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
            issuedBy: freezed == issuedBy
                ? _value.issuedBy
                : issuedBy // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QrTransactionInfoImplCopyWith<$Res>
    implements $QrTransactionInfoCopyWith<$Res> {
  factory _$$QrTransactionInfoImplCopyWith(
    _$QrTransactionInfoImpl value,
    $Res Function(_$QrTransactionInfoImpl) then,
  ) = __$$QrTransactionInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'equipment_id') int? equipmentId,
    @JsonKey(name: 'equipment_name') String? equipmentName,
    @JsonKey(name: 'issued_at') String issuedAt,
    @JsonKey(name: 'due_at') String dueAt,
    String status,
    @JsonKey(name: 'issued_by') int? issuedBy,
  });
}

/// @nodoc
class __$$QrTransactionInfoImplCopyWithImpl<$Res>
    extends _$QrTransactionInfoCopyWithImpl<$Res, _$QrTransactionInfoImpl>
    implements _$$QrTransactionInfoImplCopyWith<$Res> {
  __$$QrTransactionInfoImplCopyWithImpl(
    _$QrTransactionInfoImpl _value,
    $Res Function(_$QrTransactionInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QrTransactionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = freezed,
    Object? equipmentId = freezed,
    Object? equipmentName = freezed,
    Object? issuedAt = null,
    Object? dueAt = null,
    Object? status = null,
    Object? issuedBy = freezed,
  }) {
    return _then(
      _$QrTransactionInfoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        studentId: freezed == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int?,
        equipmentId: freezed == equipmentId
            ? _value.equipmentId
            : equipmentId // ignore: cast_nullable_to_non_nullable
                  as int?,
        equipmentName: freezed == equipmentName
            ? _value.equipmentName
            : equipmentName // ignore: cast_nullable_to_non_nullable
                  as String?,
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
        issuedBy: freezed == issuedBy
            ? _value.issuedBy
            : issuedBy // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QrTransactionInfoImpl implements _QrTransactionInfo {
  const _$QrTransactionInfoImpl({
    required this.id,
    @JsonKey(name: 'student_id') this.studentId,
    @JsonKey(name: 'equipment_id') this.equipmentId,
    @JsonKey(name: 'equipment_name') this.equipmentName,
    @JsonKey(name: 'issued_at') required this.issuedAt,
    @JsonKey(name: 'due_at') required this.dueAt,
    required this.status,
    @JsonKey(name: 'issued_by') this.issuedBy,
  });

  factory _$QrTransactionInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$QrTransactionInfoImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'student_id')
  final int? studentId;
  @override
  @JsonKey(name: 'equipment_id')
  final int? equipmentId;
  @override
  @JsonKey(name: 'equipment_name')
  final String? equipmentName;
  @override
  @JsonKey(name: 'issued_at')
  final String issuedAt;
  @override
  @JsonKey(name: 'due_at')
  final String dueAt;
  @override
  final String status;
  @override
  @JsonKey(name: 'issued_by')
  final int? issuedBy;

  @override
  String toString() {
    return 'QrTransactionInfo(id: $id, studentId: $studentId, equipmentId: $equipmentId, equipmentName: $equipmentName, issuedAt: $issuedAt, dueAt: $dueAt, status: $status, issuedBy: $issuedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QrTransactionInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.equipmentId, equipmentId) ||
                other.equipmentId == equipmentId) &&
            (identical(other.equipmentName, equipmentName) ||
                other.equipmentName == equipmentName) &&
            (identical(other.issuedAt, issuedAt) ||
                other.issuedAt == issuedAt) &&
            (identical(other.dueAt, dueAt) || other.dueAt == dueAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.issuedBy, issuedBy) ||
                other.issuedBy == issuedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    studentId,
    equipmentId,
    equipmentName,
    issuedAt,
    dueAt,
    status,
    issuedBy,
  );

  /// Create a copy of QrTransactionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QrTransactionInfoImplCopyWith<_$QrTransactionInfoImpl> get copyWith =>
      __$$QrTransactionInfoImplCopyWithImpl<_$QrTransactionInfoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QrTransactionInfoImplToJson(this);
  }
}

abstract class _QrTransactionInfo implements QrTransactionInfo {
  const factory _QrTransactionInfo({
    required final int id,
    @JsonKey(name: 'student_id') final int? studentId,
    @JsonKey(name: 'equipment_id') final int? equipmentId,
    @JsonKey(name: 'equipment_name') final String? equipmentName,
    @JsonKey(name: 'issued_at') required final String issuedAt,
    @JsonKey(name: 'due_at') required final String dueAt,
    required final String status,
    @JsonKey(name: 'issued_by') final int? issuedBy,
  }) = _$QrTransactionInfoImpl;

  factory _QrTransactionInfo.fromJson(Map<String, dynamic> json) =
      _$QrTransactionInfoImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'student_id')
  int? get studentId;
  @override
  @JsonKey(name: 'equipment_id')
  int? get equipmentId;
  @override
  @JsonKey(name: 'equipment_name')
  String? get equipmentName;
  @override
  @JsonKey(name: 'issued_at')
  String get issuedAt;
  @override
  @JsonKey(name: 'due_at')
  String get dueAt;
  @override
  String get status;
  @override
  @JsonKey(name: 'issued_by')
  int? get issuedBy;

  /// Create a copy of QrTransactionInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QrTransactionInfoImplCopyWith<_$QrTransactionInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QrValidationResult _$QrValidationResultFromJson(Map<String, dynamic> json) {
  return _QrValidationResult.fromJson(json);
}

/// @nodoc
mixin _$QrValidationResult {
  QrStudentInfo get student => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_booking')
  QrBookingInfo? get currentBooking => throw _privateConstructorUsedError;
  @JsonKey(name: 'open_transaction')
  QrTransactionInfo? get openTransaction => throw _privateConstructorUsedError;

  /// Serializes this QrValidationResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QrValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QrValidationResultCopyWith<QrValidationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QrValidationResultCopyWith<$Res> {
  factory $QrValidationResultCopyWith(
    QrValidationResult value,
    $Res Function(QrValidationResult) then,
  ) = _$QrValidationResultCopyWithImpl<$Res, QrValidationResult>;
  @useResult
  $Res call({
    QrStudentInfo student,
    @JsonKey(name: 'current_booking') QrBookingInfo? currentBooking,
    @JsonKey(name: 'open_transaction') QrTransactionInfo? openTransaction,
  });

  $QrStudentInfoCopyWith<$Res> get student;
  $QrBookingInfoCopyWith<$Res>? get currentBooking;
  $QrTransactionInfoCopyWith<$Res>? get openTransaction;
}

/// @nodoc
class _$QrValidationResultCopyWithImpl<$Res, $Val extends QrValidationResult>
    implements $QrValidationResultCopyWith<$Res> {
  _$QrValidationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QrValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? student = null,
    Object? currentBooking = freezed,
    Object? openTransaction = freezed,
  }) {
    return _then(
      _value.copyWith(
            student: null == student
                ? _value.student
                : student // ignore: cast_nullable_to_non_nullable
                      as QrStudentInfo,
            currentBooking: freezed == currentBooking
                ? _value.currentBooking
                : currentBooking // ignore: cast_nullable_to_non_nullable
                      as QrBookingInfo?,
            openTransaction: freezed == openTransaction
                ? _value.openTransaction
                : openTransaction // ignore: cast_nullable_to_non_nullable
                      as QrTransactionInfo?,
          )
          as $Val,
    );
  }

  /// Create a copy of QrValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QrStudentInfoCopyWith<$Res> get student {
    return $QrStudentInfoCopyWith<$Res>(_value.student, (value) {
      return _then(_value.copyWith(student: value) as $Val);
    });
  }

  /// Create a copy of QrValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QrBookingInfoCopyWith<$Res>? get currentBooking {
    if (_value.currentBooking == null) {
      return null;
    }

    return $QrBookingInfoCopyWith<$Res>(_value.currentBooking!, (value) {
      return _then(_value.copyWith(currentBooking: value) as $Val);
    });
  }

  /// Create a copy of QrValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QrTransactionInfoCopyWith<$Res>? get openTransaction {
    if (_value.openTransaction == null) {
      return null;
    }

    return $QrTransactionInfoCopyWith<$Res>(_value.openTransaction!, (value) {
      return _then(_value.copyWith(openTransaction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QrValidationResultImplCopyWith<$Res>
    implements $QrValidationResultCopyWith<$Res> {
  factory _$$QrValidationResultImplCopyWith(
    _$QrValidationResultImpl value,
    $Res Function(_$QrValidationResultImpl) then,
  ) = __$$QrValidationResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    QrStudentInfo student,
    @JsonKey(name: 'current_booking') QrBookingInfo? currentBooking,
    @JsonKey(name: 'open_transaction') QrTransactionInfo? openTransaction,
  });

  @override
  $QrStudentInfoCopyWith<$Res> get student;
  @override
  $QrBookingInfoCopyWith<$Res>? get currentBooking;
  @override
  $QrTransactionInfoCopyWith<$Res>? get openTransaction;
}

/// @nodoc
class __$$QrValidationResultImplCopyWithImpl<$Res>
    extends _$QrValidationResultCopyWithImpl<$Res, _$QrValidationResultImpl>
    implements _$$QrValidationResultImplCopyWith<$Res> {
  __$$QrValidationResultImplCopyWithImpl(
    _$QrValidationResultImpl _value,
    $Res Function(_$QrValidationResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QrValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? student = null,
    Object? currentBooking = freezed,
    Object? openTransaction = freezed,
  }) {
    return _then(
      _$QrValidationResultImpl(
        student: null == student
            ? _value.student
            : student // ignore: cast_nullable_to_non_nullable
                  as QrStudentInfo,
        currentBooking: freezed == currentBooking
            ? _value.currentBooking
            : currentBooking // ignore: cast_nullable_to_non_nullable
                  as QrBookingInfo?,
        openTransaction: freezed == openTransaction
            ? _value.openTransaction
            : openTransaction // ignore: cast_nullable_to_non_nullable
                  as QrTransactionInfo?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QrValidationResultImpl implements _QrValidationResult {
  const _$QrValidationResultImpl({
    required this.student,
    @JsonKey(name: 'current_booking') this.currentBooking,
    @JsonKey(name: 'open_transaction') this.openTransaction,
  });

  factory _$QrValidationResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$QrValidationResultImplFromJson(json);

  @override
  final QrStudentInfo student;
  @override
  @JsonKey(name: 'current_booking')
  final QrBookingInfo? currentBooking;
  @override
  @JsonKey(name: 'open_transaction')
  final QrTransactionInfo? openTransaction;

  @override
  String toString() {
    return 'QrValidationResult(student: $student, currentBooking: $currentBooking, openTransaction: $openTransaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QrValidationResultImpl &&
            (identical(other.student, student) || other.student == student) &&
            (identical(other.currentBooking, currentBooking) ||
                other.currentBooking == currentBooking) &&
            (identical(other.openTransaction, openTransaction) ||
                other.openTransaction == openTransaction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, student, currentBooking, openTransaction);

  /// Create a copy of QrValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QrValidationResultImplCopyWith<_$QrValidationResultImpl> get copyWith =>
      __$$QrValidationResultImplCopyWithImpl<_$QrValidationResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QrValidationResultImplToJson(this);
  }
}

abstract class _QrValidationResult implements QrValidationResult {
  const factory _QrValidationResult({
    required final QrStudentInfo student,
    @JsonKey(name: 'current_booking') final QrBookingInfo? currentBooking,
    @JsonKey(name: 'open_transaction') final QrTransactionInfo? openTransaction,
  }) = _$QrValidationResultImpl;

  factory _QrValidationResult.fromJson(Map<String, dynamic> json) =
      _$QrValidationResultImpl.fromJson;

  @override
  QrStudentInfo get student;
  @override
  @JsonKey(name: 'current_booking')
  QrBookingInfo? get currentBooking;
  @override
  @JsonKey(name: 'open_transaction')
  QrTransactionInfo? get openTransaction;

  /// Create a copy of QrValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QrValidationResultImplCopyWith<_$QrValidationResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
