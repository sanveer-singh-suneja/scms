import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  factory StatusBadge.bookingStatus(String status) {
    return StatusBadge(label: status, color: _bookingColor(status));
  }

  factory StatusBadge.equipmentStatus(String status) {
    return StatusBadge(label: status, color: _equipmentColor(status));
  }

  factory StatusBadge.transactionStatus(String status) {
    return StatusBadge(label: status, color: _transactionColor(status));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  static Color _bookingColor(String s) => switch (s) {
        'REQUESTED' => AppColors.statusRequested,
        'CONFIRMED' => AppColors.statusConfirmed,
        'WAITLISTED' => AppColors.statusWaitlisted,
        'CANCELLED' => AppColors.statusCancelled,
        'NO_SHOW' => AppColors.statusNoShow,
        'COMPLETED' => AppColors.statusCompleted,
        _ => AppColors.textSecondary,
      };

  static Color _equipmentColor(String s) => switch (s) {
        'AVAILABLE' => AppColors.equipmentAvailable,
        'ISSUED' => AppColors.equipmentIssued,
        'MAINTENANCE' => AppColors.equipmentMaintenance,
        'RETIRED' => AppColors.equipmentRetired,
        _ => AppColors.textSecondary,
      };

  static Color _transactionColor(String s) => switch (s) {
        'ISSUED' => AppColors.transactionIssued,
        'RETURNED' => AppColors.transactionReturned,
        'RETURNED_DAMAGED' => AppColors.transactionDamaged,
        'OVERDUE' => AppColors.transactionOverdue,
        _ => AppColors.textSecondary,
      };
}
