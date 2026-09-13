import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';

/// Thin wrapper around FlutterSecureStorage for auth token management.
class SecureTokenStorage {
  SecureTokenStorage() : _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  final FlutterSecureStorage _storage;

  Future<void> saveToken(String token) =>
      _storage.write(key: AppConstants.tokenKey, value: token);

  Future<String?> readToken() =>
      _storage.read(key: AppConstants.tokenKey);

  Future<void> saveRole(String role) =>
      _storage.write(key: AppConstants.roleKey, value: role);

  Future<String?> readRole() =>
      _storage.read(key: AppConstants.roleKey);

  Future<void> saveUserId(String userId) =>
      _storage.write(key: AppConstants.userIdKey, value: userId);

  Future<String?> readUserId() =>
      _storage.read(key: AppConstants.userIdKey);

  Future<void> clearAll() => _storage.deleteAll();

  Future<bool> hasToken() async {
    final token = await readToken();
    return token != null && token.isNotEmpty;
  }
}
