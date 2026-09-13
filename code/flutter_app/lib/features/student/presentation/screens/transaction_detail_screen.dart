import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/widgets/error_state.dart';
import '../../../../app/widgets/status_badge.dart';
import '../../domain/models/transaction_model.dart';
import '../providers/transaction_provider.dart';

class TransactionDetailScreen extends ConsumerWidget {
  const TransactionDetailScreen({super.key, required this.transactionId});
  final int transactionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txAsync = ref.watch(transactionDetailProvider(transactionId));

    return Scaffold(
      appBar: AppBar(title: const Text('Session Detail')),
      body: txAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorState(
          message: 'Could not load session detail',
          onRetry: () => ref.invalidate(transactionDetailProvider(transactionId)),
        ),
        data: (tx) => _TxContent(tx: tx),
      ),
    );
  }
}

class _TxContent extends StatelessWidget {
  const _TxContent({required this.tx});
  final TransactionModel tx;

  @override
  Widget build(BuildContext context) {
    final isDamaged = tx.status == 'RETURNED_DAMAGED';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Status banner
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _statusColor(tx.status).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: _statusColor(tx.status).withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(_statusIcon(tx.status),
                  color: _statusColor(tx.status), size: 28),
              const SizedBox(width: 14),
              StatusBadge.transactionStatus(tx.status),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Details card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Equipment',
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 12),
                _Row('Name',
                    tx.equipmentName ?? 'Equipment #${tx.equipmentId}'),
                _Row('Session #', '#${tx.id}'),
                const Divider(height: 24),
                Text('Dates', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 12),
                _Row('Issued', tx.issuedAt.replaceFirst('T', ' ').split('.').first),
                _Row('Due', tx.dueAt.replaceFirst('T', ' ').split('.').first),
                if (tx.returnedAt != null)
                  _Row('Returned',
                      tx.returnedAt!.replaceFirst('T', ' ').split('.').first),
              ],
            ),
          ),
        ),

        // Damage report card
        if (isDamaged || tx.damageReport != null) ...[
          const SizedBox(height: 12),
          Card(
            color: AppColors.error.withValues(alpha: 0.05),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.warning_amber,
                          color: AppColors.error, size: 18),
                      const SizedBox(width: 8),
                      Text('Damage Report',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: AppColors.error)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (tx.conditionOnReturn != null)
                    _Row('Condition', tx.conditionOnReturn!),
                  if (tx.damageReport != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      tx.damageReport!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 40),
      ],
    );
  }

  Color _statusColor(String s) => switch (s) {
        'ISSUED' => AppColors.transactionIssued,
        'RETURNED' => AppColors.transactionReturned,
        'RETURNED_DAMAGED' => AppColors.transactionDamaged,
        'OVERDUE' => AppColors.transactionOverdue,
        _ => AppColors.textSecondary,
      };

  IconData _statusIcon(String s) => switch (s) {
        'ISSUED' => Icons.sports,
        'RETURNED' => Icons.check_circle,
        'RETURNED_DAMAGED' => Icons.warning_amber,
        'OVERDUE' => Icons.timer_off,
        _ => Icons.info,
      };
}

class _Row extends StatelessWidget {
  const _Row(this.label, this.value);
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
            child:
                Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
