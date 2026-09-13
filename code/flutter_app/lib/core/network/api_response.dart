import '../errors/app_exception.dart';

/// Parses {"success": true/false, "data": ..., "pagination": ..., "error": ...}.
/// Throws [ApiException] when success is false.
class ApiResponse<T> {
  const ApiResponse._({required this.data, this.pagination});

  final T data;
  final ApiPagination? pagination;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) converter,
  ) {
    final success = json['success'] as bool? ?? false;
    if (!success) {
      final err = json['error'] as Map<String, dynamic>?;
      final code = err?['code'] as String? ?? 'UNKNOWN_ERROR';
      final message =
          err?['message'] as String? ?? 'An unexpected error occurred.';
      throw ApiException(code: code, message: message);
    }
    ApiPagination? pagination;
    if (json['pagination'] != null) {
      pagination = ApiPagination.fromJson(
        json['pagination'] as Map<String, dynamic>,
      );
    }
    return ApiResponse._(data: converter(json['data']), pagination: pagination);
  }

  static ApiResponse<List<T>> fromJsonList<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) itemConverter,
  ) {
    final success = json['success'] as bool? ?? false;
    if (!success) {
      final err = json['error'] as Map<String, dynamic>?;
      final code = err?['code'] as String? ?? 'UNKNOWN_ERROR';
      final message =
          err?['message'] as String? ?? 'An unexpected error occurred.';
      throw ApiException(code: code, message: message);
    }
    ApiPagination? pagination;
    if (json['pagination'] != null) {
      pagination = ApiPagination.fromJson(
        json['pagination'] as Map<String, dynamic>,
      );
    }
    final items = (json['data'] as List<dynamic>? ?? [])
        .map((e) => itemConverter(e as Map<String, dynamic>))
        .toList();
    return ApiResponse._(data: items, pagination: pagination);
  }
}

class ApiPagination {
  const ApiPagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  final int page;
  final int limit;
  final int total;
  final int totalPages;

  bool get hasNext => page < totalPages;

  factory ApiPagination.fromJson(Map<String, dynamic> json) => ApiPagination(
        page: (json['page'] as num?)?.toInt() ?? 1,
        limit: (json['limit'] as num?)?.toInt() ?? 20,
        total: (json['total'] as num?)?.toInt() ?? 0,
        totalPages: (json['totalPages'] as num?)?.toInt() ?? 1,
      );
}
