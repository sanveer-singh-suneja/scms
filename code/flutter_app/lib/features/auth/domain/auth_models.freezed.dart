// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) {
  return _LoginRequest.fromJson(json);
}

/// @nodoc
mixin _$LoginRequest {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  /// Serializes this LoginRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginRequestCopyWith<LoginRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginRequestCopyWith<$Res> {
  factory $LoginRequestCopyWith(
    LoginRequest value,
    $Res Function(LoginRequest) then,
  ) = _$LoginRequestCopyWithImpl<$Res, LoginRequest>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class _$LoginRequestCopyWithImpl<$Res, $Val extends LoginRequest>
    implements $LoginRequestCopyWith<$Res> {
  _$LoginRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null, Object? password = null}) {
    return _then(
      _value.copyWith(
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoginRequestImplCopyWith<$Res>
    implements $LoginRequestCopyWith<$Res> {
  factory _$$LoginRequestImplCopyWith(
    _$LoginRequestImpl value,
    $Res Function(_$LoginRequestImpl) then,
  ) = __$$LoginRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$LoginRequestImplCopyWithImpl<$Res>
    extends _$LoginRequestCopyWithImpl<$Res, _$LoginRequestImpl>
    implements _$$LoginRequestImplCopyWith<$Res> {
  __$$LoginRequestImplCopyWithImpl(
    _$LoginRequestImpl _value,
    $Res Function(_$LoginRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null, Object? password = null}) {
    return _then(
      _$LoginRequestImpl(
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginRequestImpl implements _LoginRequest {
  const _$LoginRequestImpl({required this.email, required this.password});

  factory _$LoginRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginRequestImplFromJson(json);

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginRequest(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginRequestImplCopyWith<_$LoginRequestImpl> get copyWith =>
      __$$LoginRequestImplCopyWithImpl<_$LoginRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginRequestImplToJson(this);
  }
}

abstract class _LoginRequest implements LoginRequest {
  const factory _LoginRequest({
    required final String email,
    required final String password,
  }) = _$LoginRequestImpl;

  factory _LoginRequest.fromJson(Map<String, dynamic> json) =
      _$LoginRequestImpl.fromJson;

  @override
  String get email;
  @override
  String get password;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginRequestImplCopyWith<_$LoginRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) {
  return _RegisterRequest.fromJson(json);
}

/// @nodoc
mixin _$RegisterRequest {
  String get name => throw _privateConstructorUsedError;
  String get email =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'student_id')
  String get studentId => throw _privateConstructorUsedError;
  String get department => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  /// Serializes this RegisterRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterRequestCopyWith<RegisterRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterRequestCopyWith<$Res> {
  factory $RegisterRequestCopyWith(
    RegisterRequest value,
    $Res Function(RegisterRequest) then,
  ) = _$RegisterRequestCopyWithImpl<$Res, RegisterRequest>;
  @useResult
  $Res call({
    String name,
    String email,
    @JsonKey(name: 'student_id') String studentId,
    String department,
    String password,
  });
}

/// @nodoc
class _$RegisterRequestCopyWithImpl<$Res, $Val extends RegisterRequest>
    implements $RegisterRequestCopyWith<$Res> {
  _$RegisterRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? studentId = null,
    Object? department = null,
    Object? password = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            studentId: null == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as String,
            department: null == department
                ? _value.department
                : department // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RegisterRequestImplCopyWith<$Res>
    implements $RegisterRequestCopyWith<$Res> {
  factory _$$RegisterRequestImplCopyWith(
    _$RegisterRequestImpl value,
    $Res Function(_$RegisterRequestImpl) then,
  ) = __$$RegisterRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String email,
    @JsonKey(name: 'student_id') String studentId,
    String department,
    String password,
  });
}

/// @nodoc
class __$$RegisterRequestImplCopyWithImpl<$Res>
    extends _$RegisterRequestCopyWithImpl<$Res, _$RegisterRequestImpl>
    implements _$$RegisterRequestImplCopyWith<$Res> {
  __$$RegisterRequestImplCopyWithImpl(
    _$RegisterRequestImpl _value,
    $Res Function(_$RegisterRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? studentId = null,
    Object? department = null,
    Object? password = null,
  }) {
    return _then(
      _$RegisterRequestImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        studentId: null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as String,
        department: null == department
            ? _value.department
            : department // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterRequestImpl implements _RegisterRequest {
  const _$RegisterRequestImpl({
    required this.name,
    required this.email,
    @JsonKey(name: 'student_id') required this.studentId,
    required this.department,
    required this.password,
  });

  factory _$RegisterRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterRequestImplFromJson(json);

  @override
  final String name;
  @override
  final String email;
  // ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'student_id')
  final String studentId;
  @override
  final String department;
  @override
  final String password;

  @override
  String toString() {
    return 'RegisterRequest(name: $name, email: $email, studentId: $studentId, department: $department, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, email, studentId, department, password);

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterRequestImplCopyWith<_$RegisterRequestImpl> get copyWith =>
      __$$RegisterRequestImplCopyWithImpl<_$RegisterRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterRequestImplToJson(this);
  }
}

abstract class _RegisterRequest implements RegisterRequest {
  const factory _RegisterRequest({
    required final String name,
    required final String email,
    @JsonKey(name: 'student_id') required final String studentId,
    required final String department,
    required final String password,
  }) = _$RegisterRequestImpl;

  factory _RegisterRequest.fromJson(Map<String, dynamic> json) =
      _$RegisterRequestImpl.fromJson;

  @override
  String get name;
  @override
  String get email; // ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'student_id')
  String get studentId;
  @override
  String get department;
  @override
  String get password;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterRequestImplCopyWith<_$RegisterRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuthStudent _$AuthStudentFromJson(Map<String, dynamic> json) {
  return _AuthStudent.fromJson(json);
}

/// @nodoc
mixin _$AuthStudent {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'student_id')
  String get studentId => throw _privateConstructorUsedError;
  String get department => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this AuthStudent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthStudent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthStudentCopyWith<AuthStudent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStudentCopyWith<$Res> {
  factory $AuthStudentCopyWith(
    AuthStudent value,
    $Res Function(AuthStudent) then,
  ) = _$AuthStudentCopyWithImpl<$Res, AuthStudent>;
  @useResult
  $Res call({
    int id,
    String name,
    String email,
    @JsonKey(name: 'student_id') String studentId,
    String department,
    String status,
  });
}

/// @nodoc
class _$AuthStudentCopyWithImpl<$Res, $Val extends AuthStudent>
    implements $AuthStudentCopyWith<$Res> {
  _$AuthStudentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthStudent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? studentId = null,
    Object? department = null,
    Object? status = null,
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
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            studentId: null == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as String,
            department: null == department
                ? _value.department
                : department // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthStudentImplCopyWith<$Res>
    implements $AuthStudentCopyWith<$Res> {
  factory _$$AuthStudentImplCopyWith(
    _$AuthStudentImpl value,
    $Res Function(_$AuthStudentImpl) then,
  ) = __$$AuthStudentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String email,
    @JsonKey(name: 'student_id') String studentId,
    String department,
    String status,
  });
}

/// @nodoc
class __$$AuthStudentImplCopyWithImpl<$Res>
    extends _$AuthStudentCopyWithImpl<$Res, _$AuthStudentImpl>
    implements _$$AuthStudentImplCopyWith<$Res> {
  __$$AuthStudentImplCopyWithImpl(
    _$AuthStudentImpl _value,
    $Res Function(_$AuthStudentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthStudent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? studentId = null,
    Object? department = null,
    Object? status = null,
  }) {
    return _then(
      _$AuthStudentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        studentId: null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as String,
        department: null == department
            ? _value.department
            : department // ignore: cast_nullable_to_non_nullable
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
class _$AuthStudentImpl implements _AuthStudent {
  const _$AuthStudentImpl({
    required this.id,
    required this.name,
    required this.email,
    @JsonKey(name: 'student_id') required this.studentId,
    required this.department,
    required this.status,
  });

  factory _$AuthStudentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthStudentImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String email;
  // ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'student_id')
  final String studentId;
  @override
  final String department;
  @override
  final String status;

  @override
  String toString() {
    return 'AuthStudent(id: $id, name: $name, email: $email, studentId: $studentId, department: $department, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStudentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, email, studentId, department, status);

  /// Create a copy of AuthStudent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStudentImplCopyWith<_$AuthStudentImpl> get copyWith =>
      __$$AuthStudentImplCopyWithImpl<_$AuthStudentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthStudentImplToJson(this);
  }
}

abstract class _AuthStudent implements AuthStudent {
  const factory _AuthStudent({
    required final int id,
    required final String name,
    required final String email,
    @JsonKey(name: 'student_id') required final String studentId,
    required final String department,
    required final String status,
  }) = _$AuthStudentImpl;

  factory _AuthStudent.fromJson(Map<String, dynamic> json) =
      _$AuthStudentImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get email; // ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'student_id')
  String get studentId;
  @override
  String get department;
  @override
  String get status;

  /// Create a copy of AuthStudent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStudentImplCopyWith<_$AuthStudentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuthStaffUser _$AuthStaffUserFromJson(Map<String, dynamic> json) {
  return _AuthStaffUser.fromJson(json);
}

/// @nodoc
mixin _$AuthStaffUser {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;

  /// Serializes this AuthStaffUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthStaffUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthStaffUserCopyWith<AuthStaffUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStaffUserCopyWith<$Res> {
  factory $AuthStaffUserCopyWith(
    AuthStaffUser value,
    $Res Function(AuthStaffUser) then,
  ) = _$AuthStaffUserCopyWithImpl<$Res, AuthStaffUser>;
  @useResult
  $Res call({int id, String name, String email, String role});
}

/// @nodoc
class _$AuthStaffUserCopyWithImpl<$Res, $Val extends AuthStaffUser>
    implements $AuthStaffUserCopyWith<$Res> {
  _$AuthStaffUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthStaffUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? role = null,
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
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthStaffUserImplCopyWith<$Res>
    implements $AuthStaffUserCopyWith<$Res> {
  factory _$$AuthStaffUserImplCopyWith(
    _$AuthStaffUserImpl value,
    $Res Function(_$AuthStaffUserImpl) then,
  ) = __$$AuthStaffUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String email, String role});
}

/// @nodoc
class __$$AuthStaffUserImplCopyWithImpl<$Res>
    extends _$AuthStaffUserCopyWithImpl<$Res, _$AuthStaffUserImpl>
    implements _$$AuthStaffUserImplCopyWith<$Res> {
  __$$AuthStaffUserImplCopyWithImpl(
    _$AuthStaffUserImpl _value,
    $Res Function(_$AuthStaffUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthStaffUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? role = null,
  }) {
    return _then(
      _$AuthStaffUserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthStaffUserImpl implements _AuthStaffUser {
  const _$AuthStaffUserImpl({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory _$AuthStaffUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthStaffUserImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String role;

  @override
  String toString() {
    return 'AuthStaffUser(id: $id, name: $name, email: $email, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStaffUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, email, role);

  /// Create a copy of AuthStaffUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStaffUserImplCopyWith<_$AuthStaffUserImpl> get copyWith =>
      __$$AuthStaffUserImplCopyWithImpl<_$AuthStaffUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthStaffUserImplToJson(this);
  }
}

abstract class _AuthStaffUser implements AuthStaffUser {
  const factory _AuthStaffUser({
    required final int id,
    required final String name,
    required final String email,
    required final String role,
  }) = _$AuthStaffUserImpl;

  factory _AuthStaffUser.fromJson(Map<String, dynamic> json) =
      _$AuthStaffUserImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get email;
  @override
  String get role;

  /// Create a copy of AuthStaffUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStaffUserImplCopyWith<_$AuthStaffUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuthUser _$AuthUserFromJson(Map<String, dynamic> json) {
  return _AuthUser.fromJson(json);
}

/// @nodoc
mixin _$AuthUser {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String? get studentId => throw _privateConstructorUsedError;
  String? get department => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  /// Serializes this AuthUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthUserCopyWith<AuthUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthUserCopyWith<$Res> {
  factory $AuthUserCopyWith(AuthUser value, $Res Function(AuthUser) then) =
      _$AuthUserCopyWithImpl<$Res, AuthUser>;
  @useResult
  $Res call({
    int id,
    String name,
    String email,
    String role,
    String? studentId,
    String? department,
    String? status,
  });
}

/// @nodoc
class _$AuthUserCopyWithImpl<$Res, $Val extends AuthUser>
    implements $AuthUserCopyWith<$Res> {
  _$AuthUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? role = null,
    Object? studentId = freezed,
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
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            studentId: freezed == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$AuthUserImplCopyWith<$Res>
    implements $AuthUserCopyWith<$Res> {
  factory _$$AuthUserImplCopyWith(
    _$AuthUserImpl value,
    $Res Function(_$AuthUserImpl) then,
  ) = __$$AuthUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String email,
    String role,
    String? studentId,
    String? department,
    String? status,
  });
}

/// @nodoc
class __$$AuthUserImplCopyWithImpl<$Res>
    extends _$AuthUserCopyWithImpl<$Res, _$AuthUserImpl>
    implements _$$AuthUserImplCopyWith<$Res> {
  __$$AuthUserImplCopyWithImpl(
    _$AuthUserImpl _value,
    $Res Function(_$AuthUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? role = null,
    Object? studentId = freezed,
    Object? department = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _$AuthUserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        studentId: freezed == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$AuthUserImpl implements _AuthUser {
  const _$AuthUserImpl({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.studentId,
    this.department,
    this.status,
  });

  factory _$AuthUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthUserImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String role;
  @override
  final String? studentId;
  @override
  final String? department;
  @override
  final String? status;

  @override
  String toString() {
    return 'AuthUser(id: $id, name: $name, email: $email, role: $role, studentId: $studentId, department: $department, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    email,
    role,
    studentId,
    department,
    status,
  );

  /// Create a copy of AuthUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthUserImplCopyWith<_$AuthUserImpl> get copyWith =>
      __$$AuthUserImplCopyWithImpl<_$AuthUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthUserImplToJson(this);
  }
}

abstract class _AuthUser implements AuthUser {
  const factory _AuthUser({
    required final int id,
    required final String name,
    required final String email,
    required final String role,
    final String? studentId,
    final String? department,
    final String? status,
  }) = _$AuthUserImpl;

  factory _AuthUser.fromJson(Map<String, dynamic> json) =
      _$AuthUserImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get email;
  @override
  String get role;
  @override
  String? get studentId;
  @override
  String? get department;
  @override
  String? get status;

  /// Create a copy of AuthUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthUserImplCopyWith<_$AuthUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StudentAuthResponse _$StudentAuthResponseFromJson(Map<String, dynamic> json) {
  return _StudentAuthResponse.fromJson(json);
}

/// @nodoc
mixin _$StudentAuthResponse {
  String get token => throw _privateConstructorUsedError;
  AuthStudent get student => throw _privateConstructorUsedError;

  /// Serializes this StudentAuthResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StudentAuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentAuthResponseCopyWith<StudentAuthResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentAuthResponseCopyWith<$Res> {
  factory $StudentAuthResponseCopyWith(
    StudentAuthResponse value,
    $Res Function(StudentAuthResponse) then,
  ) = _$StudentAuthResponseCopyWithImpl<$Res, StudentAuthResponse>;
  @useResult
  $Res call({String token, AuthStudent student});

  $AuthStudentCopyWith<$Res> get student;
}

/// @nodoc
class _$StudentAuthResponseCopyWithImpl<$Res, $Val extends StudentAuthResponse>
    implements $StudentAuthResponseCopyWith<$Res> {
  _$StudentAuthResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentAuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? token = null, Object? student = null}) {
    return _then(
      _value.copyWith(
            token: null == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String,
            student: null == student
                ? _value.student
                : student // ignore: cast_nullable_to_non_nullable
                      as AuthStudent,
          )
          as $Val,
    );
  }

  /// Create a copy of StudentAuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthStudentCopyWith<$Res> get student {
    return $AuthStudentCopyWith<$Res>(_value.student, (value) {
      return _then(_value.copyWith(student: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StudentAuthResponseImplCopyWith<$Res>
    implements $StudentAuthResponseCopyWith<$Res> {
  factory _$$StudentAuthResponseImplCopyWith(
    _$StudentAuthResponseImpl value,
    $Res Function(_$StudentAuthResponseImpl) then,
  ) = __$$StudentAuthResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token, AuthStudent student});

  @override
  $AuthStudentCopyWith<$Res> get student;
}

/// @nodoc
class __$$StudentAuthResponseImplCopyWithImpl<$Res>
    extends _$StudentAuthResponseCopyWithImpl<$Res, _$StudentAuthResponseImpl>
    implements _$$StudentAuthResponseImplCopyWith<$Res> {
  __$$StudentAuthResponseImplCopyWithImpl(
    _$StudentAuthResponseImpl _value,
    $Res Function(_$StudentAuthResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudentAuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? token = null, Object? student = null}) {
    return _then(
      _$StudentAuthResponseImpl(
        token: null == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String,
        student: null == student
            ? _value.student
            : student // ignore: cast_nullable_to_non_nullable
                  as AuthStudent,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StudentAuthResponseImpl implements _StudentAuthResponse {
  const _$StudentAuthResponseImpl({required this.token, required this.student});

  factory _$StudentAuthResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentAuthResponseImplFromJson(json);

  @override
  final String token;
  @override
  final AuthStudent student;

  @override
  String toString() {
    return 'StudentAuthResponse(token: $token, student: $student)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentAuthResponseImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.student, student) || other.student == student));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token, student);

  /// Create a copy of StudentAuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentAuthResponseImplCopyWith<_$StudentAuthResponseImpl> get copyWith =>
      __$$StudentAuthResponseImplCopyWithImpl<_$StudentAuthResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentAuthResponseImplToJson(this);
  }
}

abstract class _StudentAuthResponse implements StudentAuthResponse {
  const factory _StudentAuthResponse({
    required final String token,
    required final AuthStudent student,
  }) = _$StudentAuthResponseImpl;

  factory _StudentAuthResponse.fromJson(Map<String, dynamic> json) =
      _$StudentAuthResponseImpl.fromJson;

  @override
  String get token;
  @override
  AuthStudent get student;

  /// Create a copy of StudentAuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentAuthResponseImplCopyWith<_$StudentAuthResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StaffAuthResponse _$StaffAuthResponseFromJson(Map<String, dynamic> json) {
  return _StaffAuthResponse.fromJson(json);
}

/// @nodoc
mixin _$StaffAuthResponse {
  String get token => throw _privateConstructorUsedError;
  AuthStaffUser get user => throw _privateConstructorUsedError;

  /// Serializes this StaffAuthResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StaffAuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffAuthResponseCopyWith<StaffAuthResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffAuthResponseCopyWith<$Res> {
  factory $StaffAuthResponseCopyWith(
    StaffAuthResponse value,
    $Res Function(StaffAuthResponse) then,
  ) = _$StaffAuthResponseCopyWithImpl<$Res, StaffAuthResponse>;
  @useResult
  $Res call({String token, AuthStaffUser user});

  $AuthStaffUserCopyWith<$Res> get user;
}

/// @nodoc
class _$StaffAuthResponseCopyWithImpl<$Res, $Val extends StaffAuthResponse>
    implements $StaffAuthResponseCopyWith<$Res> {
  _$StaffAuthResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffAuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? token = null, Object? user = null}) {
    return _then(
      _value.copyWith(
            token: null == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String,
            user: null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as AuthStaffUser,
          )
          as $Val,
    );
  }

  /// Create a copy of StaffAuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthStaffUserCopyWith<$Res> get user {
    return $AuthStaffUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StaffAuthResponseImplCopyWith<$Res>
    implements $StaffAuthResponseCopyWith<$Res> {
  factory _$$StaffAuthResponseImplCopyWith(
    _$StaffAuthResponseImpl value,
    $Res Function(_$StaffAuthResponseImpl) then,
  ) = __$$StaffAuthResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token, AuthStaffUser user});

  @override
  $AuthStaffUserCopyWith<$Res> get user;
}

/// @nodoc
class __$$StaffAuthResponseImplCopyWithImpl<$Res>
    extends _$StaffAuthResponseCopyWithImpl<$Res, _$StaffAuthResponseImpl>
    implements _$$StaffAuthResponseImplCopyWith<$Res> {
  __$$StaffAuthResponseImplCopyWithImpl(
    _$StaffAuthResponseImpl _value,
    $Res Function(_$StaffAuthResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffAuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? token = null, Object? user = null}) {
    return _then(
      _$StaffAuthResponseImpl(
        token: null == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String,
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as AuthStaffUser,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StaffAuthResponseImpl implements _StaffAuthResponse {
  const _$StaffAuthResponseImpl({required this.token, required this.user});

  factory _$StaffAuthResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffAuthResponseImplFromJson(json);

  @override
  final String token;
  @override
  final AuthStaffUser user;

  @override
  String toString() {
    return 'StaffAuthResponse(token: $token, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffAuthResponseImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token, user);

  /// Create a copy of StaffAuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffAuthResponseImplCopyWith<_$StaffAuthResponseImpl> get copyWith =>
      __$$StaffAuthResponseImplCopyWithImpl<_$StaffAuthResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffAuthResponseImplToJson(this);
  }
}

abstract class _StaffAuthResponse implements StaffAuthResponse {
  const factory _StaffAuthResponse({
    required final String token,
    required final AuthStaffUser user,
  }) = _$StaffAuthResponseImpl;

  factory _StaffAuthResponse.fromJson(Map<String, dynamic> json) =
      _$StaffAuthResponseImpl.fromJson;

  @override
  String get token;
  @override
  AuthStaffUser get user;

  /// Create a copy of StaffAuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffAuthResponseImplCopyWith<_$StaffAuthResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
