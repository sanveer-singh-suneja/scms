import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/api_response.dart';
import '../../student/domain/models/equipment_model.dart';
import '../domain/models/qr_validation_model.dart';
import '../domain/models/staff_queue_model.dart';

class StaffRemoteSource {
  StaffRemoteSource(this._dio);
  final Dio _dio;

  Future<QrValidationResult> validateStudentQr(String token) async {
    try {
      final res = await _dio.post(
        ApiEndpoints.qrValidateStudent,
        data: {'token': token},
      );
      return QrValidationResult.fromJson(
        res.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }

  Future<EquipmentModel> validateEquipmentQr(String qrCode) async {
    try {
      final res = await _dio.post(
        ApiEndpoints.qrValidateEquipment,
        data: {'qr_code': qrCode},
      );
      return EquipmentModel.fromJson(
        res.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }

  Future<Map<String, dynamic>> issueEquipment({
    required int bookingId,
    required int studentId,
    required int equipmentId,
  }) async {
    try {
      final res = await _dio.post(
        ApiEndpoints.transactionIssue,
        data: {
          'booking_id': bookingId,
          'student_id': studentId,
          'equipment_id': equipmentId,
        },
      );
      return res.data['data'] as Map<String, dynamic>;
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }

  Future<Map<String, dynamic>> returnEquipment(
    int transactionId, {
    required String condition,
    String? damageReport,
  }) async {
    try {
      final data = <String, dynamic>{'condition_on_return': condition};
      if (damageReport != null) data['damage_report'] = damageReport;

      final res = await _dio.post(
        ApiEndpoints.transactionReturn(transactionId),
        data: data,
      );
      return res.data['data'] as Map<String, dynamic>;
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }

  Future<StaffQueueModel> getQueue() async {
    try {
      final res = await _dio.get(ApiEndpoints.staffQueue);
      return StaffQueueModel.fromJson(
        res.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }

  Future<ApiResponse<List<EquipmentModel>>> getInventory({
    String? status,
    String? category,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final res = await _dio.get(
        ApiEndpoints.inventory,
        queryParameters: {
          if (status != null) 'status': status,
          if (category != null) 'category': category,
          'page': page,
          'limit': limit,
        },
      );
      return ApiResponse.fromJsonList(
        res.data as Map<String, dynamic>,
        EquipmentModel.fromJson,
      );
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }
}
