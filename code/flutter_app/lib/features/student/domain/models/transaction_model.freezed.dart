// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  return _TransactionModel.fromJson(json);
}

/// @nodoc
mixin _$TransactionModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_id')
  int? get bookingId => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_id')
  int get studentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'equipment_id')
  int get equipmentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'equipment_name')
  String? get equipmentName => throw _privateConstructorUsedError;
  @JsonKey(name: 'issued_at')
  String get issuedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'due_at')
  String get dueAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'returned_at')
  String? get returnedAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'condition_on_return')
  String? get conditionOnReturn => throw _privateConstructorUsedError;
  @JsonKey(name: 'damage_report')
  String? get damageReport => throw _privateConstructorUsedError;
  @JsonKey(name: 'issued_by')
  int get issuedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'returned_to')
  int? get returnedTo => throw _privateConstructorUsedError;

  /// Serializes this TransactionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionModelCopyWith<TransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionModelCopyWith<$Res> {
  factory $TransactionModelCopyWith(
    TransactionModel value,
    $Res Function(TransactionModel) then,
  ) = _$TransactionModelCopyWithImpl<$Res, TransactionModel>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'booking_id') int? bookingId,
    @JsonKey(name: 'student_id') int studentId,
    @JsonKey(name: 'equipment_id') int equipmentId,
    @JsonKey(name: 'equipment_name') String? equipmentName,
    @JsonKey(name: 'issued_at') String issuedAt,
    @JsonKey(name: 'due_at') String dueAt,
    @JsonKey(name: 'returned_at') String? returnedAt,
    String status,
    @JsonKey(name: 'condition_on_return') String? conditionOnReturn,
    @JsonKey(name: 'damage_report') String? damageReport,
    @JsonKey(name: 'issued_by') int issuedBy,
    @JsonKey(name: 'returned_to') int? returnedTo,
  });
}

/// @nodoc
class _$TransactionModelCopyWithImpl<$Res, $Val extends TransactionModel>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookingId = freezed,
    Object? studentId = null,
    Object? equipmentId = null,
    Object? equipmentName = freezed,
    Object? issuedAt = null,
    Object? dueAt = null,
    Object? returnedAt = freezed,
    Object? status = null,
    Object? conditionOnReturn = freezed,
    Object? damageReport = freezed,
    Object? issuedBy = null,
    Object? returnedTo = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            bookingId: freezed == bookingId
                ? _value.bookingId
                : bookingId // ignore: cast_nullable_to_non_nullable
                      as int?,
            studentId: null == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as int,
            equipmentId: null == equipmentId
                ? _value.equipmentId
                : equipmentId // ignore: cast_nullable_to_non_nullable
                      as int,
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
            returnedAt: freezed == returnedAt
                ? _value.returnedAt
                : returnedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            conditionOnReturn: freezed == conditionOnReturn
                ? _value.conditionOnReturn
                : conditionOnReturn // ignore: cast_nullable_to_non_nullable
                      as String?,
            damageReport: freezed == damageReport
                ? _value.damageReport
                : damageReport // ignore: cast_nullable_to_non_nullable
                      as String?,
            issuedBy: null == issuedBy
                ? _value.issuedBy
                : issuedBy // ignore: cast_nullable_to_non_nullable
                      as int,
            returnedTo: freezed == returnedTo
                ? _value.returnedTo
                : returnedTo // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TransactionModelImplCopyWith<$Res>
    implements $TransactionModelCopyWith<$Res> {
  factory _$$TransactionModelImplCopyWith(
    _$TransactionModelImpl value,
    $Res Function(_$TransactionModelImpl) then,
  ) = __$$TransactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'booking_id') int? bookingId,
    @JsonKey(name: 'student_id') int studentId,
    @JsonKey(name: 'equipment_id') int equipmentId,
    @JsonKey(name: 'equipment_name') String? equipmentName,
    @JsonKey(name: 'issued_at') String issuedAt,
    @JsonKey(name: 'due_at') String dueAt,
    @JsonKey(name: 'returned_at') String? returnedAt,
    String status,
    @JsonKey(name: 'condition_on_return') String? conditionOnReturn,
    @JsonKey(name: 'damage_report') String? damageReport,
    @JsonKey(name: 'issued_by') int issuedBy,
    @JsonKey(name: 'returned_to') int? returnedTo,
  });
}

/// @nodoc
class __$$TransactionModelImplCopyWithImpl<$Res>
    extends _$TransactionModelCopyWithImpl<$Res, _$TransactionModelImpl>
    implements _$$TransactionModelImplCopyWith<$Res> {
  __$$TransactionModelImplCopyWithImpl(
    _$TransactionModelImpl _value,
    $Res Function(_$TransactionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookingId = freezed,
    Object? studentId = null,
    Object? equipmentId = null,
    Object? equipmentName = freezed,
    Object? issuedAt = null,
    Object? dueAt = null,
    Object? returnedAt = freezed,
    Object? status = null,
    Object? conditionOnReturn = freezed,
    Object? damageReport = freezed,
    Object? issuedBy = null,
    Object? returnedTo = freezed,
  }) {
    return _then(
      _$TransactionModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        bookingId: freezed == bookingId
            ? _value.bookingId
            : bookingId // ignore: cast_nullable_to_non_nullable
                  as int?,
        studentId: null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int,
        equipmentId: null == equipmentId
            ? _value.equipmentId
            : equipmentId // ignore: cast_nullable_to_non_nullable
                  as int,
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
        returnedAt: freezed == returnedAt
            ? _value.returnedAt
            : returnedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        conditionOnReturn: freezed == conditionOnReturn
            ? _value.conditionOnReturn
            : conditionOnReturn // ignore: cast_nullable_to_non_nullable
                  as String?,
        damageReport: freezed == damageReport
            ? _value.damageReport
            : damageReport // ignore: cast_nullable_to_non_nullable
                  as String?,
        issuedBy: null == issuedBy
            ? _value.issuedBy
            : issuedBy // ignore: cast_nullable_to_non_nullable
                  as int,
        returnedTo: freezed == returnedTo
            ? _value.returnedTo
            : returnedTo // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionModelImpl implements _TransactionModel {
  const _$TransactionModelImpl({
    required this.id,
    @JsonKey(name: 'booking_id') this.bookingId,
    @JsonKey(name: 'student_id') required this.studentId,
    @JsonKey(name: 'equipment_id') required this.equipmentId,
    @JsonKey(name: 'equipment_name') this.equipmentName,
    @JsonKey(name: 'issued_at') required this.issuedAt,
    @JsonKey(name: 'due_at') required this.dueAt,
    @JsonKey(name: 'returned_at') this.returnedAt,
    required this.status,
    @JsonKey(name: 'condition_on_return') this.conditionOnReturn,
    @JsonKey(name: 'damage_report') this.damageReport,
    @JsonKey(name: 'issued_by') required this.issuedBy,
    @JsonKey(name: 'returned_to') this.returnedTo,
  });

  factory _$TransactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'booking_id')
  final int? bookingId;
  @override
  @JsonKey(name: 'student_id')
  final int studentId;
  @override
  @JsonKey(name: 'equipment_id')
  final int equipmentId;
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
  @JsonKey(name: 'returned_at')
  final String? returnedAt;
  @override
  final String status;
  @override
  @JsonKey(name: 'condition_on_return')
  final String? conditionOnReturn;
  @override
  @JsonKey(name: 'damage_report')
  final String? damageReport;
  @override
  @JsonKey(name: 'issued_by')
  final int issuedBy;
  @override
  @JsonKey(name: 'returned_to')
  final int? returnedTo;

  @override
  String toString() {
    return 'TransactionModel(id: $id, bookingId: $bookingId, studentId: $studentId, equipmentId: $equipmentId, equipmentName: $equipmentName, issuedAt: $issuedAt, dueAt: $dueAt, returnedAt: $returnedAt, status: $status, conditionOnReturn: $conditionOnReturn, damageReport: $damageReport, issuedBy: $issuedBy, returnedTo: $returnedTo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.equipmentId, equipmentId) ||
                other.equipmentId == equipmentId) &&
            (identical(other.equipmentName, equipmentName) ||
                other.equipmentName == equipmentName) &&
            (identical(other.issuedAt, issuedAt) ||
                other.issuedAt == issuedAt) &&
            (identical(other.dueAt, dueAt) || other.dueAt == dueAt) &&
            (identical(other.returnedAt, returnedAt) ||
                other.returnedAt == returnedAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.conditionOnReturn, conditionOnReturn) ||
                other.conditionOnReturn == conditionOnReturn) &&
            (identical(other.damageReport, damageReport) ||
                other.damageReport == damageReport) &&
            (identical(other.issuedBy, issuedBy) ||
                other.issuedBy == issuedBy) &&
            (identical(other.returnedTo, returnedTo) ||
                other.returnedTo == returnedTo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    bookingId,
    studentId,
    equipmentId,
    equipmentName,
    issuedAt,
    dueAt,
    returnedAt,
    status,
    conditionOnReturn,
    damageReport,
    issuedBy,
    returnedTo,
  );

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      __$$TransactionModelImplCopyWithImpl<_$TransactionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionModelImplToJson(this);
  }
}

abstract class _TransactionModel implements TransactionModel {
  const factory _TransactionModel({
    required final int id,
    @JsonKey(name: 'booking_id') final int? bookingId,
    @JsonKey(name: 'student_id') required final int studentId,
    @JsonKey(name: 'equipment_id') required final int equipmentId,
    @JsonKey(name: 'equipment_name') final String? equipmentName,
    @JsonKey(name: 'issued_at') required final String issuedAt,
    @JsonKey(name: 'due_at') required final String dueAt,
    @JsonKey(name: 'returned_at') final String? returnedAt,
    required final String status,
    @JsonKey(name: 'condition_on_return') final String? conditionOnReturn,
    @JsonKey(name: 'damage_report') final String? damageReport,
    @JsonKey(name: 'issued_by') required final int issuedBy,
    @JsonKey(name: 'returned_to') final int? returnedTo,
  }) = _$TransactionModelImpl;

  factory _TransactionModel.fromJson(Map<String, dynamic> json) =
      _$TransactionModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'booking_id')
  int? get bookingId;
  @override
  @JsonKey(name: 'student_id')
  int get studentId;
  @override
  @JsonKey(name: 'equipment_id')
  int get equipmentId;
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
  @JsonKey(name: 'returned_at')
  String? get returnedAt;
  @override
  String get status;
  @override
  @JsonKey(name: 'condition_on_return')
  String? get conditionOnReturn;
  @override
  @JsonKey(name: 'damage_report')
  String? get damageReport;
  @override
  @JsonKey(name: 'issued_by')
  int get issuedBy;
  @override
  @JsonKey(name: 'returned_to')
  int? get returnedTo;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
