import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/widgets/error_state.dart';
import '../../../../app/widgets/status_badge.dart';
import '../../domain/models/booking_model.dart';
import '../providers/booking_provider.dart';

class BookingDetailScreen extends ConsumerWidget {
  const BookingDetailScreen({super.key, required this.bookingId});
  final int bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingAsync = ref.watch(bookingDetailProvider(bookingId));

    return Scaffold(
      appBar: AppBar(title: const Text('Booking Detail')),
      body: bookingAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorState(
          message: 'Could not load booking',
          onRetry: () => ref.invalidate(bookingDetailProvider(bookingId)),
        ),
        data: (booking) => _BookingDetailContent(
          booking: booking,
          onCancel: () => _confirmCancel(context, ref, booking),
        ),
      ),
    );
  }

  Future<void> _confirmCancel(
      BuildContext context, WidgetRef ref, BookingModel booking) async {
    if (!['REQUESTED', 'CONFIRMED', 'WAITLISTED'].contains(booking.status)) {
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Cancel Booking?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep It'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Cancel Booking'),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      try {
        await ref.read(myBookingsProvider.notifier).cancelBooking(bookingId);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Booking cancelled')),
          );
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString().replaceFirst('Exception: ', '')),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    }
  }
}

class _BookingDetailContent extends StatelessWidget {
  const _BookingDetailContent({
    required this.booking,
    required this.onCancel,
  });
  final BookingModel booking;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final canCancel = ['REQUESTED', 'CONFIRMED', 'WAITLISTED']
        .contains(booking.status);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Status banner
        _StatusBanner(booking: booking),
        const SizedBox(height: 16),

        // Details card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Details',
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 12),
                if (booking.equipment != null)
                  _DetailRow('Equipment', booking.equipment!.name),
                if (booking.slot != null) ...[
                  _DetailRow('Date', booking.slot!.date),
                  _DetailRow('Time',
                      '${booking.slot!.startTime} – ${booking.slot!.endTime}'),
                  _DetailRow('Cutoff', booking.slot!.bookingCutoffAt),
                ],
                _DetailRow('Booking ID', '#${booking.id}'),
                _DetailRow('Requested', booking.createdAt.split('T').first),
                if (booking.allocatedAt != null)
                  _DetailRow('Allocated', booking.allocatedAt!.split('T').first),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Queue info for waitlisted
        if (booking.status == 'WAITLISTED')
          _QueueCard(booking: booking),

        // Fairness info for REQUESTED
        if (booking.status == 'REQUESTED') ...[
          const SizedBox(height: 4),
          _FairnessInfoCard(),
          const SizedBox(height: 4),
        ],

        // Cancel button
        if (canCancel) ...[
          const SizedBox(height: 20),
          OutlinedButton(
            style: OutlinedButton.styleFrom(foregroundColor: AppColors.error),
            onPressed: onCancel,
            child: const Text('Cancel Booking'),
          ),
        ],
        const SizedBox(height: 32),
      ],
    );
  }
}

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({required this.booking});
  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    final (icon, msg, color) = _info(booking.status);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatusBadge.bookingStatus(booking.status),
                const SizedBox(height: 4),
                Text(msg,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: color)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static (IconData, String, Color) _info(String status) => switch (status) {
        'REQUESTED' => (
            Icons.hourglass_top,
            'Awaiting batch allocation after cutoff time.',
            AppColors.statusRequested,
          ),
        'CONFIRMED' => (
            Icons.check_circle,
            'Slot confirmed! Show your QR to collect.',
            AppColors.statusConfirmed,
          ),
        'WAITLISTED' => (
            Icons.people,
            'You are on the waitlist. Position may improve.',
            AppColors.statusWaitlisted,
          ),
        'CANCELLED' => (
            Icons.cancel,
            'This booking was cancelled.',
            AppColors.statusCancelled,
          ),
        'NO_SHOW' => (
            Icons.timer_off,
            'You did not collect within the window.',
            AppColors.statusNoShow,
          ),
        'COMPLETED' => (
            Icons.sports_score,
            'Equipment was collected and returned.',
            AppColors.statusCompleted,
          ),
        _ => (Icons.info, status, AppColors.textSecondary),
      };
}

class _QueueCard extends ConsumerWidget {
  const _QueueCard({required this.booking});
  final BookingModel booking;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queueAsync = ref.watch(queuePositionProvider(booking.id));
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Queue Position',
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 10),
            queueAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (_, _) => const Text(
                'Could not load queue info.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              data: (q) => Row(
                children: [
                  Text(
                    '#${q.queuePosition ?? '—'}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.statusWaitlisted,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  if (q.totalWaitlisted != null) ...[
                    Text(
                      ' of ${q.totalWaitlisted}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FairnessInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.info.withValues(alpha: 0.06),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info_outline, color: AppColors.info, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Slots are allocated after the booking cutoff. '
                'Students with fewer recent sessions are given higher priority.',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.info),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.textSecondary),
            ),
          ),
          Expanded(
            child: Text(value,
                style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
