import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/auth_provider.dart';
import '../../data/transaction_remote_source.dart';
import '../../domain/models/transaction_model.dart';

final transactionRemoteSourceProvider = Provider<TransactionRemoteSource>((ref) {
  return TransactionRemoteSource(ref.read(dioProvider));
});

final transactionListProvider =
    FutureProvider<List<TransactionModel>>((ref) async {
  final res = await ref.read(transactionRemoteSourceProvider).listTransactions(limit: 50);
  return res.data;
});

final transactionDetailProvider =
    FutureProvider.family<TransactionModel, int>(
  (ref, id) => ref.read(transactionRemoteSourceProvider).getTransaction(id),
);
