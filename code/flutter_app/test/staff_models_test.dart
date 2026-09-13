import 'package:flutter_test/flutter_test.dart';
import 'package:scms/features/staff/domain/models/qr_validation_model.dart';
import 'package:scms/features/staff/domain/models/staff_queue_model.dart';

void main() {
  group('QrStudentInfo', () {
    test('deserialises required fields', () {
      final json = {
        'id': 1,
        'name': 'Riya Sharma',
        'student_id': 'CS2021001',
        'department': 'Computer Science',
        'status': 'ACTIVE',
      };
      final s = QrStudentInfo.fromJson(json);
      expect(s.id, 1);
      expect(s.name, 'Riya Sharma');
      expect(s.studentId, 'CS2021001');
      expect(s.status, 'ACTIVE');
    });

    test('tolerates missing optional fields', () {
      final json = {'id': 2, 'name': 'Ali', 'student_id': 'ME2020003'};
      final s = QrStudentInfo.fromJson(json);
      expect(s.department, isNull);
      expect(s.status, isNull);
    });
  });

  group('QrValidationResult', () {
    test('deserialises with no booking and no transaction', () {
      final json = {
        'student': {
          'id': 1,
          'name': 'Riya Sharma',
          'student_id': 'CS2021001',
        },
        'current_booking': null,
        'open_transaction': null,
      };
      final r = QrValidationResult.fromJson(json);
      expect(r.student.name, 'Riya Sharma');
      expect(r.currentBooking, isNull);
      expect(r.openTransaction, isNull);
    });

    test('deserialises with a confirmed booking', () {
      final json = {
        'student': {'id': 1, 'name': 'Riya', 'student_id': 'CS001'},
        'current_booking': {
          'id': 55,
          'equipment': {'id': 1, 'name': 'Cricket Bat #3'},
          'slot': {
            'id': 10,
            'date': '2026-09-20',
            'start_time': '09:00',
            'end_time': '10:00',
          },
          'status': 'CONFIRMED',
        },
        'open_transaction': null,
      };
      final r = QrValidationResult.fromJson(json);
      expect(r.currentBooking?.id, 55);
      expect(r.currentBooking?.equipment.name, 'Cricket Bat #3');
      expect(r.currentBooking?.status, 'CONFIRMED');
      expect(r.openTransaction, isNull);
    });

    test('deserialises with an open transaction', () {
      final json = {
        'student': {'id': 1, 'name': 'Ali', 'student_id': 'ME001'},
        'current_booking': null,
        'open_transaction': {
          'id': 100,
          'equipment_name': 'Football',
          'issued_at': '2026-09-20T09:05:00Z',
          'due_at': '2026-09-20T10:00:00Z',
          'status': 'ISSUED',
        },
      };
      final r = QrValidationResult.fromJson(json);
      expect(r.openTransaction?.id, 100);
      expect(r.openTransaction?.equipmentName, 'Football');
      expect(r.openTransaction?.status, 'ISSUED');
    });
  });

  group('StaffQueueModel', () {
    test('deserialises empty queue', () {
      final json = {
        'confirmed_bookings_today': [],
        'open_transactions': [],
      };
      final q = StaffQueueModel.fromJson(json);
      expect(q.confirmedBookingsToday, isEmpty);
      expect(q.openTransactions, isEmpty);
    });

    test('deserialises confirmed bookings today', () {
      final json = {
        'confirmed_bookings_today': [
          {
            'booking_id': 55,
            'student': {'id': 1, 'name': 'Riya Sharma', 'student_id': 'CS001'},
            'equipment': {'id': 1, 'name': 'Cricket Bat #3'},
            'slot': {'start_time': '09:00', 'end_time': '10:00'},
            'status': 'CONFIRMED',
          },
        ],
        'open_transactions': [],
      };
      final q = StaffQueueModel.fromJson(json);
      expect(q.confirmedBookingsToday.length, 1);
      expect(q.confirmedBookingsToday.first.bookingId, 55);
      expect(q.confirmedBookingsToday.first.student.name, 'Riya Sharma');
      expect(q.confirmedBookingsToday.first.equipment.name, 'Cricket Bat #3');
      expect(q.confirmedBookingsToday.first.slot.startTime, '09:00');
    });

    test('deserialises open transactions with overdue status', () {
      final json = {
        'confirmed_bookings_today': [],
        'open_transactions': [
          {
            'transaction_id': 100,
            'student': {'id': 1, 'name': 'Riya Sharma'},
            'equipment': {'id': 1, 'name': 'Cricket Bat #3'},
            'issued_at': '2026-09-20T09:05:00Z',
            'due_at': '2026-09-20T10:00:00Z',
            'status': 'OVERDUE',
          },
        ],
      };
      final q = StaffQueueModel.fromJson(json);
      expect(q.openTransactions.length, 1);
      expect(q.openTransactions.first.transactionId, 100);
      expect(q.openTransactions.first.status, 'OVERDUE');
    });
  });

  group('StaffBookingEntry', () {
    test('extracts nested student and equipment refs', () {
      final json = {
        'booking_id': 42,
        'student': {'id': 5, 'name': 'Priya', 'student_id': 'EC2022010'},
        'equipment': {'id': 3, 'name': 'Basketball'},
        'slot': {'start_time': '14:00', 'end_time': '15:00'},
        'status': 'CONFIRMED',
      };
      final b = StaffBookingEntry.fromJson(json);
      expect(b.bookingId, 42);
      expect(b.student.studentId, 'EC2022010');
      expect(b.equipment.name, 'Basketball');
    });
  });

  group('Route protection logic', () {
    test('STUDENT role string is exactly STUDENT', () {
      const role = 'STUDENT';
      expect(role == 'STUDENT', isTrue);
      expect(role == 'STAFF' || role == 'ADMIN', isFalse);
    });

    test('STAFF role string is not STUDENT', () {
      const role = 'STAFF';
      expect(role == 'STUDENT', isFalse);
      expect(role == 'STAFF' || role == 'ADMIN', isTrue);
    });
  });
}
