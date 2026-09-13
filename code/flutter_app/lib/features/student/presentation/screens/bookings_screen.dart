import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/widgets/app_card.dart';
import '../../../../app/widgets/empty_state.dart';
import '../../../../app/widgets/error_state.dart';
import '../../../../app/widgets/status_badge.dart';
import '../../domain/models/booking_model.dart';
import '../providers/booking_provider.dart';

class BookingsScreen extends ConsumerStatefulWidget {
  const BookingsScreen({super.key});

  @override
  ConsumerState<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends ConsumerState<BookingsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 2, vsync: this);

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingsAsync = ref.watch(myBookingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabs,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Past'),
          ],
        ),
      ),
      body: bookingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorState(
          message: 'Could not load bookings',
          onRetry: () => ref.invalidate(myBookingsProvider),
        ),
        data: (bookings) {
          final active = bookings
              .where((b) => ['REQUESTED', 'CONFIRMED', 'WAITLISTED']
                  .contains(b.status))
              .toList();
          final past = bookings
              .where((b) => ['CANCELLED', 'NO_SHOW', 'COMPLETED']
                  .contains(b.status))
              .toList();

          return TabBarView(
            controller: _tabs,
            children: [
              _BookingList(
                bookings: active,
                emptyMessage: 'No active bookings.\nBrowse equipment to make one.',
                onRefresh: () => ref.read(myBookingsProvider.notifier).refresh(),
              ),
              _BookingList(
                bookings: past,
                emptyMessage: 'No past bookings.',
                onRefresh: () => ref.read(myBookingsProvider.notifier).refresh(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BookingList extends StatelessWidget {
  const _BookingList({
    required this.bookings,
    required this.emptyMessage,
    required this.onRefresh,
  });
  final List<BookingModel> bookings;
  final String emptyMessage;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return EmptyState(icon: Icons.bookmark_border, message: emptyMessage);
    }
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        itemCount: bookings.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (_, i) => _BookingRow(booking: bookings[i]),
      ),
    );
  }
}

class _BookingRow extends StatelessWidget {
  const _BookingRow({required this.booking});
  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => context.push('/student/bookings/${booking.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  booking.equipment?.name ?? 'Equipment',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              StatusBadge.bookingStatus(booking.status),
            ],
          ),
          if (booking.slot != null) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined,
                    size: 13, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text(
                  booking.slot!.date,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.access_time_outlined,
                    size: 13, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text(
                  '${booking.slot!.startTime} – ${booking.slot!.endTime}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ],
          if (booking.status == 'WAITLISTED' &&
              booking.queuePosition != null) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.queue, size: 13, color: AppColors.statusWaitlisted),
                const SizedBox(width: 4),
                Text(
                  'Queue position #${booking.queuePosition}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.statusWaitlisted,
                      ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
