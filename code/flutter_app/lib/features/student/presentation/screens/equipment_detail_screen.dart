import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/widgets/app_button.dart';
import '../../../../app/widgets/error_state.dart';
import '../../../../app/widgets/status_badge.dart';
import '../../domain/models/equipment_model.dart';
import '../providers/booking_provider.dart';
import '../providers/equipment_provider.dart';

class EquipmentDetailScreen extends ConsumerWidget {
  const EquipmentDetailScreen({super.key, required this.equipmentId});
  final int equipmentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final equipAsync = ref.watch(equipmentDetailProvider(equipmentId));
    final availAsync = ref.watch(equipmentAvailabilityProvider(equipmentId));

    return Scaffold(
      appBar: AppBar(title: const Text('Equipment')),
      body: equipAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorState(
          message: 'Could not load equipment',
          onRetry: () => ref.invalidate(equipmentDetailProvider(equipmentId)),
        ),
        data: (equipment) => _EquipmentContent(
          equipment: equipment,
          availabilityAsync: availAsync,
          onSlotTap: (slotId) =>
              _showBookingConfirm(context, ref, slotId),
        ),
      ),
    );
  }

  Future<void> _showBookingConfirm(
      BuildContext context, WidgetRef ref, int slotId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Request This Slot?'),
        content: const Text(
          'Booking requests are processed after the cutoff time.\n\n'
          'The system allocates slots fairly based on recent usage. '
          'You may be CONFIRMED, WAITLISTED, or not allocated.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Request Slot'),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      await _submitBooking(context, ref, slotId);
    }
  }

  Future<void> _submitBooking(
      BuildContext context, WidgetRef ref, int slotId) async {
    try {
      final booking =
          await ref.read(myBookingsProvider.notifier).submitBooking(slotId);
      if (context.mounted) {
        if (booking != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Booking request submitted!'),
              backgroundColor: AppColors.success,
              action: SnackBarAction(
                label: 'View',
                textColor: Colors.white,
                onPressed: () =>
                    context.push('/student/bookings/${booking.id}'),
              ),
            ),
          );
          context.push('/student/bookings/${booking.id}');
        }
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

class _EquipmentContent extends StatelessWidget {
  const _EquipmentContent({
    required this.equipment,
    required this.availabilityAsync,
    required this.onSlotTap,
  });
  final EquipmentModel equipment;
  final AsyncValue<List<SlotAvailability>> availabilityAsync;
  final void Function(int slotId) onSlotTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.sports,
                          color: AppColors.primary, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(equipment.name,
                              style:
                                  Theme.of(context).textTheme.titleMedium),
                          Text(equipment.category,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                    StatusBadge.equipmentStatus(equipment.status),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 12),
                _InfoRow('Condition', equipment.condition),
                if (equipment.location != null)
                  _InfoRow('Location', equipment.location!),
                if (equipment.notes != null)
                  _InfoRow('Notes', equipment.notes!),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Availability
        Text('Available Slots',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        availabilityAsync.when(
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (e, _) => const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'Could not load availability.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          data: (slots) {
            if (slots.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'No upcoming slots available.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              );
            }
            return Column(
              children: slots
                  .map((s) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _SlotCard(
                          slot: s,
                          equipmentAvailable:
                              equipment.status == 'AVAILABLE',
                          onBook: () => onSlotTap(s.id),
                        ),
                      ))
                  .toList(),
            );
          },
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
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

class _SlotCard extends StatelessWidget {
  const _SlotCard({
    required this.slot,
    required this.equipmentAvailable,
    required this.onBook,
  });
  final SlotAvailability slot;
  final bool equipmentAvailable;
  final VoidCallback onBook;

  @override
  Widget build(BuildContext context) {
    final canBook = equipmentAvailable &&
        slot.status == 'OPEN' &&
        slot.availableCount > 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    slot.date,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    '${slot.startTime} – ${slot.endTime}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 13,
                        color: slot.availableCount > 0
                            ? AppColors.success
                            : AppColors.error,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${slot.availableCount}/${slot.capacity} available',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                              color: slot.availableCount > 0
                                  ? AppColors.success
                                  : AppColors.error,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (canBook)
              AppButton(
                label: 'Request',
                onPressed: onBook,
              )
            else
              Text(
                slot.availableCount == 0 ? 'Full' : slot.status,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.textSecondary),
              ),
          ],
        ),
      ),
    );
  }
}
