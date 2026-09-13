import '../../../core/storage/secure_storage.dart';
import '../domain/auth_models.dart';
import 'auth_remote_source.dart';

class AuthRepository {
  AuthRepository(this._remote, this._storage);

  final AuthRemoteSource _remote;
  final SecureTokenStorage _storage;

  Future<AuthUser> loginStudent(String email, String password) async {
    final resp = await _remote.studentLogin(
      LoginRequest(email: email, password: password),
    );
    await _persistToken(resp.token, 'STUDENT', resp.student.id.toString());
    return AuthUser(
      id: resp.student.id,
      name: resp.student.name,
      email: resp.student.email,
      role: 'STUDENT',
      studentId: resp.student.studentId,
      department: resp.student.department,
      status: resp.student.status,
    );
  }

  Future<AuthUser> registerStudent({
    required String name,
    required String email,
    required String studentId,
    required String department,
    required String password,
  }) async {
    final resp = await _remote.studentRegister(
      RegisterRequest(
        name: name,
        email: email,
        studentId: studentId,
        department: department,
        password: password,
      ),
    );
    await _persistToken(resp.token, 'STUDENT', resp.student.id.toString());
    return AuthUser(
      id: resp.student.id,
      name: resp.student.name,
      email: resp.student.email,
      role: 'STUDENT',
      studentId: resp.student.studentId,
      department: resp.student.department,
      status: resp.student.status,
    );
  }

  Future<AuthUser> loginStaff(String email, String password) async {
    final resp = await _remote.staffLogin(
      LoginRequest(email: email, password: password),
    );
    await _persistToken(resp.token, resp.user.role, resp.user.id.toString());
    return AuthUser(
      id: resp.user.id,
      name: resp.user.name,
      email: resp.user.email,
      role: resp.user.role,
    );
  }

  Future<void> logout() => _storage.clearAll();

  Future<bool> hasSession() => _storage.hasToken();

  Future<AuthUser?> restoreSession() async {
    final token = await _storage.readToken();
    final role = await _storage.readRole();
    final userId = await _storage.readUserId();
    if (token == null || role == null || userId == null) return null;

    try {
      if (role == 'STUDENT') {
        final student = await _remote.getMe();
        return AuthUser(
          id: student.id,
          name: student.name,
          email: student.email,
          role: 'STUDENT',
          studentId: student.studentId,
          department: student.department,
          status: student.status,
        );
      } else {
        final user = await _remote.getMeStaff();
        return AuthUser(
          id: user.id,
          name: user.name,
          email: user.email,
          role: user.role,
        );
      }
    } catch (_) {
      return null;
    }
  }

  Future<void> _persistToken(String token, String role, String userId) async {
    await _storage.saveToken(token);
    await _storage.saveRole(role);
    await _storage.saveUserId(userId);
  }
}
