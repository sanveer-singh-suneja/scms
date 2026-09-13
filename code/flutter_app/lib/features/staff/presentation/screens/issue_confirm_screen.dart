import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/errors/app_exception.dart';
import '../../domain/models/qr_validation_model.dart';
import '../providers/staff_provider.dart';

class IssueConfirmScreen extends ConsumerStatefulWidget {
  const IssueConfirmScreen({super.key, required this.result});
  final QrValidationResult result;

  @override
  ConsumerState<IssueConfirmScreen> createState() => _IssueConfirmScreenState();
}

class _IssueConfirmScreenState extends ConsumerState<IssueConfirmScreen> {
  bool _isIssuing = false;
  bool _success = false;
  String? _error;

  Future<void> _issue() async {
    final booking = widget.result.currentBooking;
    if (booking == null) return;

    setState(() {
      _isIssuing = true;
      _error = null;
    });

    try {
      await ref.read(staffRemoteSourceProvider).issueEquipment(
            bookingId: booking.id,
            studentId: widget.result.student.id,
            equipmentId: booking.equipment.id,
          );
      if (!mounted) return;
      setState(() {
        _isIssuing = false;
        _success = true;
      });
    } on AppException catch (e) {
      if (!mounted) return;
      setState(() {
        _isIssuing = false;
        _error = e.userMessage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final student = widget.result.student;
    final booking = widget.result.currentBooking;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Issue Equipment'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _success
            ? _SuccessView(
                student: student,
                booking: booking,
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
                          _SummaryRow(
                            icon: Icons.person_outline,
                            label: 'Student',
                            value: '${student.name} (${student.studentId})',
                          ),
                          const Divider(height: 20),
                          _SummaryRow(
                            icon: Icons.sports_outlined,
                            label: 'Equipment',
                            value: booking?.equipment.name ?? '—',
                          ),
                          if (booking?.slot != null) ...[
                            const Divider(height: 20),
                            _SummaryRow(
                              icon: Icons.schedule_outlined,
                              label: 'Slot',
                              value:
                                  '${booking!.slot!.date ?? ''} '
                                  '${booking.slot!.startTime}–${booking.slot!.endTime}',
                            ),
                          ],
                          const Divider(height: 20),
                          _SummaryRow(
                            icon: Icons.confirmation_number_outlined,
                            label: 'Booking ID',
                            value: '#${booking?.id}',
                          ),
                        ],
                      ),
                    ),
                  ),
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
                    onPressed: _isIssuing ? null : _issue,
                    icon: _isIssuing
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.sports_handball),
                    label: Text(_isIssuing ? 'Issuing…' : 'Confirm Issue'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(52),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: _isIssuing ? null : () => context.pop(),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.textSecondary),
              ),
              Text(
                value,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView({
    required this.student,
    required this.booking,
    required this.onDone,
  });
  final QrStudentInfo student;
  final QrBookingInfo? booking;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.check_circle, size: 72, color: AppColors.success),
        const SizedBox(height: 16),
        Text(
          'Equipment Issued!',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          '${booking?.equipment.name ?? 'Equipment'} issued to ${student.name}',
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
