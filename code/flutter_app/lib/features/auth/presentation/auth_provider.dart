import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../../../core/storage/secure_storage.dart';
import '../data/auth_remote_source.dart';
import '../data/auth_repository.dart';
import '../domain/auth_models.dart';

// ── Infrastructure providers ──────────────────────────────────────────────────

final secureStorageProvider = Provider<SecureTokenStorage>(
  (_) => SecureTokenStorage(),
);

final dioProvider = Provider<Dio>((ref) {
  return createDio(ref.read(secureStorageProvider));
});

final authRemoteSourceProvider = Provider<AuthRemoteSource>((ref) {
  return AuthRemoteSource(ref.read(dioProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.read(authRemoteSourceProvider),
    ref.read(secureStorageProvider),
  );
});

// ── Auth notifier ─────────────────────────────────────────────────────────────

class AuthNotifier extends AsyncNotifier<AuthUser?> {
  @override
  Future<AuthUser?> build() async {
    return _repo.restoreSession();
  }

  AuthRepository get _repo => ref.read(authRepositoryProvider);

  Future<void> loginStudent(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _repo.loginStudent(email, password),
    );
  }

  Future<void> registerStudent({
    required String name,
    required String email,
    required String studentId,
    required String department,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _repo.registerStudent(
        name: name,
        email: email,
        studentId: studentId,
        department: department,
        password: password,
      ),
    );
  }

  Future<void> loginStaff(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _repo.loginStaff(email, password),
    );
  }

  Future<void> logout() async {
    await _repo.logout();
    state = const AsyncData(null);
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, AuthUser?>(
  AuthNotifier.new,
);

// ── Convenience selectors ─────────────────────────────────────────────────────

final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).valueOrNull != null;
});

final currentUserProvider = Provider<AuthUser?>((ref) {
  return ref.watch(authProvider).valueOrNull;
});
