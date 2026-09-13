import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/auth_provider.dart';
import '../../data/student_remote_source.dart';
import '../../domain/models/usage_stats_model.dart';

final studentRemoteSourceProvider = Provider<StudentRemoteSource>((ref) {
  return StudentRemoteSource(ref.read(dioProvider));
});

final usageStatsProvider = FutureProvider<UsageStatsModel>((ref) {
  return ref.read(studentRemoteSourceProvider).getUsageStats();
});

final qrTokenProvider = FutureProvider<String>((ref) {
  return ref.read(studentRemoteSourceProvider).getQrToken();
});

final studentProfileProvider = FutureProvider<Map<String, dynamic>>((ref) {
  return ref.read(studentRemoteSourceProvider).getProfile();
});
