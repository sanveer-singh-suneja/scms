import 'package:flutter_test/flutter_test.dart';
import 'package:scms/features/auth/domain/auth_models.dart';

void main() {
  group('LoginRequest', () {
    test('serialises to JSON', () {
      const req = LoginRequest(email: 'test@test.com', password: 'pass123');
      final json = req.toJson();
      expect(json['email'], 'test@test.com');
      expect(json['password'], 'pass123');
    });
  });

  group('RegisterRequest', () {
    test('uses student_id key', () {
      const req = RegisterRequest(
        name: 'Riya',
        email: 'riya@test.com',
        studentId: 'CS001',
        department: 'CS',
        password: 'pass123',
      );
      final json = req.toJson();
      expect(json['student_id'], 'CS001');
    });
  });

  group('AuthStudent', () {
    test('deserialises from JSON', () {
      final student = AuthStudent.fromJson({
        'id': 1,
        'name': 'Riya Sharma',
        'email': 'riya@test.com',
        'student_id': 'CS001',
        'department': 'Computer Science',
        'status': 'ACTIVE',
      });
      expect(student.studentId, 'CS001');
      expect(student.status, 'ACTIVE');
    });
  });

  group('AuthUser', () {
    test('round-trip JSON', () {
      const user = AuthUser(
        id: 1,
        name: 'Test User',
        email: 'test@test.com',
        role: 'STUDENT',
        studentId: 'CS001',
      );
      final json = user.toJson();
      final restored = AuthUser.fromJson(json);
      expect(restored.id, 1);
      expect(restored.role, 'STUDENT');
      expect(restored.studentId, 'CS001');
    });
  });
}
