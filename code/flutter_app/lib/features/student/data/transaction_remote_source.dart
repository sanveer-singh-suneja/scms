import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/api_response.dart';
import '../domain/models/transaction_model.dart';

class TransactionRemoteSource {
  TransactionRemoteSource(this._dio);
  final Dio _dio;

  Future<ApiResponse<List<TransactionModel>>> listTransactions({
    String? status,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final res = await _dio.get(
        ApiEndpoints.transactions,
        queryParameters: {
          if (status != null) 'status': status,
          'page': page,
          'limit': limit,
        },
      );
      return ApiResponse.fromJsonList(
        res.data as Map<String, dynamic>,
        TransactionModel.fromJson,
      );
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }

  Future<TransactionModel> getTransaction(int id) async {
    try {
      final res = await _dio.get(ApiEndpoints.transactionById(id));
      return TransactionModel.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw dioToAppException(e);
    }
  }
}
