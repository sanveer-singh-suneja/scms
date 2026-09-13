import 'package:flutter_test/flutter_test.dart';
import 'package:scms/features/student/domain/models/booking_model.dart';
import 'package:scms/features/student/domain/models/equipment_model.dart';
import 'package:scms/features/student/domain/models/notification_model.dart';
import 'package:scms/features/student/domain/models/transaction_model.dart';
import 'package:scms/features/student/domain/models/usage_stats_model.dart';

void main() {
  group('BookingModel', () {
    test('deserialises full booking from API response', () {
      final json = {
        'id': 42,
        'status': 'REQUESTED',
        'created_at': '2024-01-10T10:00:00',
        'slot': {
          'id': 7,
          'date': '2024-01-12',
          'start_time': '09:00',
          'end_time': '10:00',
          'booking_cutoff_at': '2024-01-11T23:59:00',
        },
        'equipment': {
          'id': 3,
          'name': 'Cricket Bat',
        },
      };
      final booking = BookingModel.fromJson(json);
      expect(booking.id, 42);
      expect(booking.status, 'REQUESTED');
      expect(booking.slot?.date, '2024-01-12');
      expect(booking.equipment?.name, 'Cricket Bat');
    });

    test('tolerates missing optional fields', () {
      final json = {
        'id': 1,
        'status': 'CANCELLED',
        'created_at': '2024-01-10T10:00:00',
      };
      final booking = BookingModel.fromJson(json);
      expect(booking.slot, isNull);
      expect(booking.equipment, isNull);
    });
  });

  group('QueuePosition', () {
    test('deserialises with snake_case keys', () {
      final json = {
        'booking_id': 42,
        'status': 'WAITLISTED',
        'queue_position': 3,
        'total_waitlisted': 10,
      };
      final q = QueuePosition.fromJson(json);
      expect(q.bookingId, 42);
      expect(q.queuePosition, 3);
      expect(q.totalWaitlisted, 10);
    });
  });

  group('EquipmentModel', () {
    test('deserialises all fields', () {
      final json = {
        'id': 5,
        'name': 'Football',
        'category': 'Football',
        'status': 'AVAILABLE',
        'condition': 'GOOD',
        'location': 'Store Room A',
        'qr_code': 'EQ-005',
      };
      final eq = EquipmentModel.fromJson(json);
      expect(eq.id, 5);
      expect(eq.qrCode, 'EQ-005');
      expect(eq.status, 'AVAILABLE');
    });
  });

  group('SlotAvailability', () {
    test('reads slot_id as id', () {
      final json = {
        'slot_id': 12,
        'date': '2024-01-12',
        'start_time': '09:00',
        'end_time': '10:00',
        'capacity': 5,
        'available_count': 3,
        'status': 'OPEN',
        'booking_cutoff_at': '2024-01-11T23:59:00',
      };
      final slot = SlotAvailability.fromJson(json);
      expect(slot.id, 12);
      expect(slot.availableCount, 3);
    });
  });

  group('NotificationModel', () {
    test('deserialises and reflects read status', () {
      final json = {
        'id': 1,
        'type': 'BOOKING_CONFIRMED',
        'title': 'Booking Confirmed',
        'message': 'Your slot for Cricket Bat is confirmed.',
        'is_read': false,
        'created_at': '2024-01-10T09:00:00',
      };
      final notif = NotificationModel.fromJson(json);
      expect(notif.isRead, false);
      expect(notif.type, 'BOOKING_CONFIRMED');
      final read = notif.copyWith(isRead: true);
      expect(read.isRead, true);
    });
  });

  group('TransactionModel', () {
    test('deserialises with equipment_name', () {
      final json = {
        'id': 99,
        'student_id': 1,
        'equipment_id': 3,
        'equipment_name': 'Cricket Bat',
        'issued_at': '2024-01-12T09:00:00',
        'due_at': '2024-01-12T10:00:00',
        'status': 'RETURNED',
        'issued_by': 7,
      };
      final tx = TransactionModel.fromJson(json);
      expect(tx.equipmentName, 'Cricket Bat');
      expect(tx.status, 'RETURNED');
    });
  });

  group('UsageStatsModel', () {
    test('deserialises snake_case fields', () {
      final json = {
        'sessions_last_7_days': 2,
        'total_sessions': 14,
        'last_session_at': '2024-01-10T10:00:00',
      };
      final stats = UsageStatsModel.fromJson(json);
      expect(stats.sessionsLast7Days, 2);
      expect(stats.totalSessions, 14);
    });
  });
}
