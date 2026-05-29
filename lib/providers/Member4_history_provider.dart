import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/Member4_timer_history.dart';
import '../services/Member4_history_storage_service.dart';
import 'dart:convert';

final historyStorageServiceProvider = Provider<HistoryStorageService>((ref) {
  return HistoryStorageService();
});

final historyProvider = FutureProvider<List<TimerHistory>>((ref) async {
  final storageService = ref.read(historyStorageServiceProvider);
  return storageService.getHistory();
});
