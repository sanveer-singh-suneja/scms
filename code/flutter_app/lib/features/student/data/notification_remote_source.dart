import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/api_response.dart';
import '../domain/models/notification_model.dart';

class NotificationRemoteSource {
  NotificationRemoteSource(this._dio);
  final Dio _dio;

  Future<ApiResponse<List<NotificationModel>>> listNotifications({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final res = await _dio.get(
        ApiEndpoints.notifications,
        queryParameters: {'page': page, 'limit': limit},
      );
      return ApiResponse.fromJsonList(
        res.data as Map<String, dynamic>,
        NotificationModel.fromJson,
      );
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }

  Future<int> getUnreadCount() async {
    try {
      final res = await _dio.get(ApiEndpoints.notificationsUnreadCount);
      return res.data['data']['unread_count'] as int;
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }

  Future<void> markRead(int notificationId) async {
    try {
      await _dio.put(ApiEndpoints.notificationRead(notificationId));
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }

  Future<void> markAllRead() async {
    try {
      await _dio.post(ApiEndpoints.notificationsMarkAllRead);
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }
}
