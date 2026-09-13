// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRequestImpl _$$LoginRequestImplFromJson(Map<String, dynamic> json) =>
    _$LoginRequestImpl(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$LoginRequestImplToJson(_$LoginRequestImpl instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

_$RegisterRequestImpl _$$RegisterRequestImplFromJson(
  Map<String, dynamic> json,
) => _$RegisterRequestImpl(
  name: json['name'] as String,
  email: json['email'] as String,
  studentId: json['student_id'] as String,
  department: json['department'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$$RegisterRequestImplToJson(
  _$RegisterRequestImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'student_id': instance.studentId,
  'department': instance.department,
  'password': instance.password,
};

_$AuthStudentImpl _$$AuthStudentImplFromJson(Map<String, dynamic> json) =>
    _$AuthStudentImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      studentId: json['student_id'] as String,
      department: json['department'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$AuthStudentImplToJson(_$AuthStudentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'student_id': instance.studentId,
      'department': instance.department,
      'status': instance.status,
    };

_$AuthStaffUserImpl _$$AuthStaffUserImplFromJson(Map<String, dynamic> json) =>
    _$AuthStaffUserImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$$AuthStaffUserImplToJson(_$AuthStaffUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
    };

_$AuthUserImpl _$$AuthUserImplFromJson(Map<String, dynamic> json) =>
    _$AuthUserImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      studentId: json['studentId'] as String?,
      department: json['department'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$AuthUserImplToJson(_$AuthUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'studentId': instance.studentId,
      'department': instance.department,
      'status': instance.status,
    };

_$StudentAuthResponseImpl _$$StudentAuthResponseImplFromJson(
  Map<String, dynamic> json,
) => _$StudentAuthResponseImpl(
  token: json['token'] as String,
  student: AuthStudent.fromJson(json['student'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$StudentAuthResponseImplToJson(
  _$StudentAuthResponseImpl instance,
) => <String, dynamic>{'token': instance.token, 'student': instance.student};

_$StaffAuthResponseImpl _$$StaffAuthResponseImplFromJson(
  Map<String, dynamic> json,
) => _$StaffAuthResponseImpl(
  token: json['token'] as String,
  user: AuthStaffUser.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$StaffAuthResponseImplToJson(
  _$StaffAuthResponseImpl instance,
) => <String, dynamic>{'token': instance.token, 'user': instance.user};
