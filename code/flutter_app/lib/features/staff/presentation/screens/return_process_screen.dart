import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/errors/app_exception.dart';
import '../../domain/models/qr_validation_model.dart';
import '../providers/staff_provider.dart';

class ReturnProcessScreen extends ConsumerStatefulWidget {
  const ReturnProcessScreen({super.key, required this.transaction});
  final QrTransactionInfo transaction;

  @override
  ConsumerState<ReturnProcessScreen> createState() =>
      _ReturnProcessScreenState();
}

class _ReturnProcessScreenState extends ConsumerState<ReturnProcessScreen> {
  String _condition = 'GOOD';
  final _damageController = TextEditingController();
  bool _isReturning = false;
  bool _success = false;
  String? _error;

  @override
  void dispose() {
    _damageController.dispose();
    super.dispose();
  }

  bool get _isDamaged => _condition == 'DAMAGED';

  Future<void> _processReturn() async {
    if (_isDamaged && _damageController.text.trim().isEmpty) {
      setState(() => _error = 'Please describe the damage before submitting.');
      return;
    }

    setState(() {
      _isReturning = true;
      _error = null;
    });

    try {
      await ref.read(staffRemoteSourceProvider).returnEquipment(
            widget.transaction.id,
            condition: _condition,
            damageReport:
                _isDamaged ? _damageController.text.trim() : null,
          );
      if (!mounted) return;
      setState(() {
        _isReturning = false;
        _success = true;
      });
    } on AppException catch (e) {
      if (!mounted) return;
      setState(() {
        _isReturning = false;
        _error = e.userMessage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tx = widget.transaction;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Process Return'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _success
            ? _SuccessView(
                equipmentName: tx.equipmentName ?? 'Equipment',
                condition: _condition,
                onDone: () => context.go(Routes.staffHome),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tx.equipmentName ?? 'Equipment',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          _InfoRow(
                            label: 'Issued',
                            value: _formatDateTime(tx.issuedAt),
                          ),
                          const SizedBox(height: 4),
                          _InfoRow(
                            label: 'Due',
                            value: _formatDateTime(tx.dueAt),
                          ),
                          const SizedBox(height: 4),
                          _InfoRow(
                            label: 'Transaction',
                            value: '#${tx.id}',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Condition on Return',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _ConditionSelector(
                    selected: _condition,
                    onChanged: (v) => setState(() {
                      _condition = v;
                      _error = null;
                    }),
                  ),
                  if (_isDamaged) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Damage Description',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _damageController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Describe the damage in detail…',
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: AppColors.error.withValues(alpha: 0.05),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.error.withValues(alpha: 0.5),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.error),
                        ),
                      ),
                    ),
                  ],
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.1),
                        border: Border.all(color: AppColors.error),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _error!,
                        style: const TextStyle(color: AppColors.error),
                      ),
                    ),
                  ],
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: _isReturning ? null : _processReturn,
                    icon: _isReturning
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.assignment_turned_in),
                    label: Text(_isReturning ? 'Processing…' : 'Confirm Return'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isDamaged
                          ? AppColors.transactionDamaged
                          : AppColors.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(52),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: _isReturning ? null : () => context.pop(),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
      ),
    );
  }

  String _formatDateTime(String iso) {
    try {
      final dt = DateTime.parse(iso).toLocal();
      return '${dt.day}/${dt.month}/${dt.year} '
          '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return iso;
    }
  }
}

class _ConditionSelector extends StatelessWidget {
  const _ConditionSelector({required this.selected, required this.onChanged});
  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    const options = [
      ('GOOD', Icons.check_circle_outline, AppColors.success),
      ('FAIR', Icons.warning_amber_outlined, AppColors.warning),
      ('DAMAGED', Icons.broken_image_outlined, AppColors.error),
    ];

    return Row(
      children: options.map((opt) {
        final (label, icon, color) = opt;
        final isSelected = selected == label;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              onTap: () => onChanged(label),
              borderRadius: BorderRadius.circular(8),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? color.withValues(alpha: 0.15)
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? color : AppColors.divider,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(icon,
                        size: 24,
                        color: isSelected ? color : AppColors.textSecondary),
                    const SizedBox(height: 4),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color:
                            isSelected ? color : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 64,
          child: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.textSecondary),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView({
    required this.equipmentName,
    required this.condition,
    required this.onDone,
  });
  final String equipmentName;
  final String condition;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final color = condition == 'DAMAGED'
        ? AppColors.transactionDamaged
        : AppColors.success;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          condition == 'DAMAGED'
              ? Icons.warning_amber_rounded
              : Icons.check_circle,
          size: 72,
          color: color,
        ),
        const SizedBox(height: 16),
        Text(
          'Return Processed',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          '$equipmentName returned as $condition',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: onDone,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(48),
          ),
          child: const Text('Back to Home'),
        ),
      ],
    );
  }
}
