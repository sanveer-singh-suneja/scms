import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/widgets/app_card.dart';
import '../../../../app/widgets/empty_state.dart';
import '../../../../app/widgets/error_state.dart';
import '../../../../app/widgets/status_badge.dart';
import '../../domain/models/transaction_model.dart';
import '../providers/transaction_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txAsync = ref.watch(transactionListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Equipment History')),
      body: txAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorState(
          message: 'Could not load history',
          onRetry: () => ref.invalidate(transactionListProvider),
        ),
        data: (transactions) {
          if (transactions.isEmpty) {
            return const EmptyState(
              icon: Icons.history,
              message: 'No equipment history yet.',
            );
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(transactionListProvider),
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              itemCount: transactions.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (_, i) =>
                  _TransactionRow(transaction: transactions[i]),
            ),
          );
        },
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  const _TransactionRow({required this.transaction});
  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    final isOverdue = transaction.status == 'OVERDUE';
    final isDamaged = transaction.status == 'RETURNED_DAMAGED';

    return AppCard(
      onTap: () => context.push(
          '${Routes.studentHistory}/${transaction.id}'),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: (isDamaged
                      ? AppColors.transactionDamaged
                      : isOverdue
                          ? AppColors.transactionOverdue
                          : AppColors.transactionIssued)
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isDamaged ? Icons.warning_amber : Icons.sports,
              color: isDamaged
                  ? AppColors.transactionDamaged
                  : isOverdue
                      ? AppColors.transactionOverdue
                      : AppColors.transactionIssued,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.equipmentName ?? 'Equipment #${transaction.equipmentId}',
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Issued: ${transaction.issuedAt.split('T').first}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.textSecondary),
                ),
                if (transaction.returnedAt != null)
                  Text(
                    'Returned: ${transaction.returnedAt!.split('T').first}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.textSecondary),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          StatusBadge.transactionStatus(transaction.status),
        ],
      ),
    );
  }
}
