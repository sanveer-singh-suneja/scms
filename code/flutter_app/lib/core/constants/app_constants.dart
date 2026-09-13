abstract final class AppConstants {
  // Change this for your local dev machine / staging / production
  static const String baseUrl = 'http://10.0.2.2:8000';

  // Dio timeouts
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Secure storage keys
  static const String tokenKey = 'scms_auth_token';
  static const String roleKey = 'scms_auth_role';
  static const String userIdKey = 'scms_user_id';

  // Pagination
  static const int defaultPageSize = 20;
}
