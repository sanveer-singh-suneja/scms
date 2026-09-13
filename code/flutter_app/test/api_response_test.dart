import 'package:flutter_test/flutter_test.dart';
import 'package:scms/core/errors/app_exception.dart';
import 'package:scms/core/network/api_response.dart';

void main() {
  group('ApiResponse.fromJson', () {
    test('parses success envelope', () {
      final resp = ApiResponse<Map<String, dynamic>>.fromJson(
        {'success': true, 'data': {'key': 'value'}},
        (j) => j as Map<String, dynamic>,
      );
      expect(resp.data['key'], 'value');
    });

    test('throws ApiException on failure envelope', () {
      expect(
        () => ApiResponse<Map<String, dynamic>>.fromJson(
          {
            'success': false,
            'error': {'code': 'NOT_FOUND', 'message': 'Not found'},
          },
          (j) => j as Map<String, dynamic>,
        ),
        throwsA(isA<ApiException>()),
      );
    });

    test('ApiException carries correct code and message', () {
      try {
        ApiResponse<String>.fromJson(
          {
            'success': false,
            'error': {'code': 'INVALID_CREDENTIALS', 'message': 'Bad password'},
          },
          (j) => j as String,
        );
        fail('Expected ApiException');
      } on ApiException catch (e) {
        expect(e.code, 'INVALID_CREDENTIALS');
        expect(e.message, 'Bad password');
      }
    });
  });

  group('ApiPagination', () {
    test('deserialises meta block', () {
      final meta = ApiPagination.fromJson({
        'page': 1,
        'limit': 20,
        'total': 45,
        'totalPages': 3,  // backend returns camelCase
      });
      expect(meta.totalPages, 3);
      expect(meta.hasNext, true);
    });
  });
}
