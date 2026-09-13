import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/auth_provider.dart';
import '../../data/booking_remote_source.dart';
import '../../domain/models/booking_model.dart';

final bookingRemoteSourceProvider = Provider<BookingRemoteSource>((ref) {
  return BookingRemoteSource(ref.read(dioProvider));
});

// My bookings list
final myBookingsProvider =
    AsyncNotifierProvider<MyBookingsNotifier, List<BookingModel>>(
  MyBookingsNotifier.new,
);

class MyBookingsNotifier extends AsyncNotifier<List<BookingModel>> {
  @override
  Future<List<BookingModel>> build() async {
    final res = await ref.read(bookingRemoteSourceProvider).listBookings(limit: 50);
    return res.data;
  }

  Future<BookingModel?> submitBooking(int slotId) async {
    state = const AsyncLoading();
    try {
      final booking = await ref.read(bookingRemoteSourceProvider).submitBooking(slotId);
      // Refresh list
      final list = await ref.read(bookingRemoteSourceProvider).listBookings(limit: 50);
      state = AsyncData(list.data);
      return booking;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }

  Future<void> cancelBooking(int bookingId) async {
    await ref.read(bookingRemoteSourceProvider).cancelBooking(bookingId);
    ref.invalidateSelf();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

// Single booking detail
final bookingDetailProvider =
    FutureProvider.family<BookingModel, int>(
  (ref, id) => ref.read(bookingRemoteSourceProvider).getBooking(id),
);

// Active/upcoming bookings (REQUESTED, CONFIRMED, WAITLISTED)
final activeBookingsProvider = FutureProvider<List<BookingModel>>((ref) async {
  final src = ref.read(bookingRemoteSourceProvider);
  final results = await Future.wait([
    src.listBookings(status: 'REQUESTED', limit: 20),
    src.listBookings(status: 'CONFIRMED', limit: 20),
    src.listBookings(status: 'WAITLISTED', limit: 20),
  ]);
  return [...results[0].data, ...results[1].data, ...results[2].data];
});

final queuePositionProvider =
    FutureProvider.family<QueuePosition, int>(
  (ref, bookingId) =>
      ref.read(bookingRemoteSourceProvider).getQueuePosition(bookingId),
);
