import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import '../errors/app_exception.dart';
import '../storage/secure_storage.dart';

/// Shared Dio instance with auth + error interceptors.
Dio createDio(SecureTokenStorage storage) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: AppConstants.connectTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
      headers: {'Content-Type': 'application/json'},
    ),
  );

  dio.interceptors.addAll([
    _AuthInterceptor(storage),
    _ErrorInterceptor(),
  ]);

  return dio;
}

/// Attaches the Bearer token to every request when one is stored.
class _AuthInterceptor extends Interceptor {
  _AuthInterceptor(this._storage);

  final SecureTokenStorage _storage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.readToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

/// Converts Dio errors into typed [AppException] subclasses.
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionError:
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: const NetworkException(),
          ),
        );
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode ?? 0;
        final body = err.response?.data;

        // Parse structured error envelope from backend
        if (body is Map<String, dynamic>) {
          final errBody = body['error'] as Map<String, dynamic>?;
          final code = errBody?['code'] as String? ?? 'HTTP_ERROR';
          final message = errBody?['message'] as String? ??
              'Request failed ($statusCode).';

          if (code == ApiErrorCode.tokenExpired) {
            handler.reject(
              DioException(
                requestOptions: err.requestOptions,
                error: const SessionExpiredException(),
              ),
            );
            return;
          }

          handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              error: ApiException(code: code, message: message),
            ),
          );
          return;
        }

        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: ServerException(statusCode: statusCode),
          ),
        );
      default:
        handler.next(err);
    }
  }
}

/// Helper to extract [AppException] from a caught [DioException].
AppException dioToAppException(DioException e) {
  final inner = e.error;
  if (inner is AppException) return inner;
  return const NetworkException();
}
