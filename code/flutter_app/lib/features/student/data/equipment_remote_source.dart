import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/api_response.dart';
import '../domain/models/equipment_model.dart';

class EquipmentRemoteSource {
  EquipmentRemoteSource(this._dio);
  final Dio _dio;

  Future<ApiResponse<List<EquipmentModel>>> listEquipment({
    String? category,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final res = await _dio.get(
        ApiEndpoints.equipment,
        queryParameters: {
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

  Future<EquipmentModel> getEquipment(int id) async {
    try {
      final res = await _dio.get(ApiEndpoints.equipmentById(id));
      return EquipmentModel.fromJson(
        res.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }

  Future<List<SlotAvailability>> getAvailability(int equipmentId) async {
    try {
      final res = await _dio.get(ApiEndpoints.equipmentAvailability(equipmentId));
      final slots = res.data['data']['available_slots'] as List<dynamic>;
      return slots
          .map((s) => SlotAvailability.fromJson(s as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }
}
