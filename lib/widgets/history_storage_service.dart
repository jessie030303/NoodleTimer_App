import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Member4_timer_history.dart';

class HistoryStorageService {
  static String historyKey =
      'noodle_timer_history';
  Future<void> saveHistory(
      TimerHistory history) async {
    final prefs =
    await SharedPreferences.getInstance();
    final historyList =
        prefs.getStringList(historyKey)
            ?? [];
    historyList.add(
      jsonEncode(
        history.toJson(),
      ),
    );

    await prefs.setStringList(
      historyKey,
      historyList,
    );
  }

  Future<List<TimerHistory>>
  getHistory() async {
    final prefs =
    await SharedPreferences.getInstance();
    final historyList =
        prefs.getStringList(historyKey)
            ?? [];

    return historyList.map((item) {
      return TimerHistory.fromJson(
        jsonDecode(item),
      );
    }).toList();
  }
  Future<void> clearHistory() async {
    final prefs =
    await SharedPreferences.getInstance();
    await prefs.remove(historyKey);
  }
}
