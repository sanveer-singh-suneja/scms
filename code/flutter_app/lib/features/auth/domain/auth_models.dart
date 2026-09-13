import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String email,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}

@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String name,
    required String email,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'student_id') required String studentId,
    required String department,
    required String password,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}

@freezed
class AuthStudent with _$AuthStudent {
  const factory AuthStudent({
    required int id,
    required String name,
    required String email,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'student_id') required String studentId,
    required String department,
    required String status,
  }) = _AuthStudent;

  factory AuthStudent.fromJson(Map<String, dynamic> json) =>
      _$AuthStudentFromJson(json);
}

@freezed
class AuthStaffUser with _$AuthStaffUser {
  const factory AuthStaffUser({
    required int id,
    required String name,
    required String email,
    required String role,
  }) = _AuthStaffUser;

  factory AuthStaffUser.fromJson(Map<String, dynamic> json) =>
      _$AuthStaffUserFromJson(json);
}

/// Unified auth identity held in memory after login.
@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    required int id,
    required String name,
    required String email,
    required String role,
    String? studentId,
    String? department,
    String? status,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}

@freezed
class StudentAuthResponse with _$StudentAuthResponse {
  const factory StudentAuthResponse({
    required String token,
    required AuthStudent student,
  }) = _StudentAuthResponse;

  factory StudentAuthResponse.fromJson(Map<String, dynamic> json) =>
      _$StudentAuthResponseFromJson(json);
}

@freezed
class StaffAuthResponse with _$StaffAuthResponse {
  const factory StaffAuthResponse({
    required String token,
    required AuthStaffUser user,
  }) = _StaffAuthResponse;

  factory StaffAuthResponse.fromJson(Map<String, dynamic> json) =>
      _$StaffAuthResponseFromJson(json);
}
