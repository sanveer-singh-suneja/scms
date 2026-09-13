import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';
import '../domain/models/usage_stats_model.dart';

class StudentRemoteSource {
  StudentRemoteSource(this._dio);
  final Dio _dio;

  Future<String> getQrToken() async {
    try {
      final res = await _dio.get(ApiEndpoints.studentQr);
      return res.data['data']['qr_identifier'] as String;
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }

  Future<UsageStatsModel> getUsageStats() async {
    try {
      final res = await _dio.get(ApiEndpoints.usageStats);
      return UsageStatsModel.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    try {
      final res = await _dio.get(ApiEndpoints.authMe);
      return res.data['data'] as Map<String, dynamic>;
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }
}
