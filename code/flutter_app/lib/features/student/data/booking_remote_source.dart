import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/api_response.dart';
import '../domain/models/booking_model.dart';

class BookingRemoteSource {
  BookingRemoteSource(this._dio);
  final Dio _dio;

  Future<BookingModel> submitBooking(int slotId) async {
    try {
      final res = await _dio.post(
        ApiEndpoints.bookings,
        data: {'slot_id': slotId},
      );
      return BookingModel.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }

  Future<ApiResponse<List<BookingModel>>> listBookings({
    String? status,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final res = await _dio.get(
        ApiEndpoints.bookings,
        queryParameters: {
          if (status != null) 'status': status,
          'page': page,
          'limit': limit,
        },
      );
      return ApiResponse.fromJsonList(
        res.data as Map<String, dynamic>,
        BookingModel.fromJson,
      );
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }

  Future<BookingModel> getBooking(int id) async {
    try {
      final res = await _dio.get(ApiEndpoints.bookingById(id));
      return BookingModel.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }

  Future<BookingModel> cancelBooking(int id) async {
    try {
      final res = await _dio.delete(ApiEndpoints.bookingById(id));
      return BookingModel.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }

  Future<QueuePosition> getQueuePosition(int bookingId) async {
    try {
      final res = await _dio.get(ApiEndpoints.bookingQueuePosition(bookingId));
      return QueuePosition.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }
}
