import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand
  static const Color primary = Color(0xFF1A237E); // deep navy
  static const Color primaryLight = Color(0xFF534bae);
  static const Color primaryDark = Color(0xFF000051);
  static const Color accent = Color(0xFFF57C00); // sports orange

  // Neutrals
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF5F6FA);
  static const Color divider = Color(0xFFE0E0E0);
  static const Color textPrimary = Color(0xFF1C1C1E);
  static const Color textSecondary = Color(0xFF6B6B80);
  static const Color textHint = Color(0xFFAAAAAA);

  // Status — booking
  static const Color statusRequested = Color(0xFF1565C0);
  static const Color statusConfirmed = Color(0xFF2E7D32);
  static const Color statusWaitlisted = Color(0xFFF57C00);
  static const Color statusCancelled = Color(0xFF757575);
  static const Color statusNoShow = Color(0xFFB71C1C);
  static const Color statusCompleted = Color(0xFF388E3C);

  // Status — equipment
  static const Color equipmentAvailable = Color(0xFF2E7D32);
  static const Color equipmentIssued = Color(0xFF1565C0);
  static const Color equipmentMaintenance = Color(0xFFF57C00);
  static const Color equipmentRetired = Color(0xFF757575);

  // Transaction
  static const Color transactionIssued = Color(0xFF1565C0);
  static const Color transactionReturned = Color(0xFF2E7D32);
  static const Color transactionOverdue = Color(0xFFB71C1C);
  static const Color transactionDamaged = Color(0xFFE53935);

  // Feedback
  static const Color error = Color(0xFFB00020);
  static const Color warning = Color(0xFFF57C00);
  static const Color success = Color(0xFF2E7D32);
  static const Color info = Color(0xFF0277BD);

  // On-primary
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onAccent = Color(0xFFFFFFFF);
}
