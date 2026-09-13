import 'package:dio/dio.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../domain/auth_models.dart';

class AuthRemoteSource {
  AuthRemoteSource(this._dio);

  final Dio _dio;

  Future<StudentAuthResponse> studentLogin(LoginRequest req) async {
    try {
      final res = await _dio.post(ApiEndpoints.studentLogin, data: req.toJson());
      return StudentAuthResponse.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }

  Future<StudentAuthResponse> studentRegister(RegisterRequest req) async {
    try {
      final res = await _dio.post(ApiEndpoints.studentRegister, data: req.toJson());
      return StudentAuthResponse.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }

  Future<StaffAuthResponse> staffLogin(LoginRequest req) async {
    try {
      final res = await _dio.post(ApiEndpoints.staffLogin, data: req.toJson());
      return StaffAuthResponse.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }

  Future<AuthStudent> getMe() async {
    try {
      final res = await _dio.get(ApiEndpoints.authMe);
      return AuthStudent.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }

  Future<AuthStaffUser> getMeStaff() async {
    try {
      final res = await _dio.get(ApiEndpoints.authMeStaff);
      return AuthStaffUser.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }
}
