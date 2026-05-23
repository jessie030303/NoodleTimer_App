import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// THIN TIMER
final thinTimerProvider = StateNotifierProvider<TimerNotifier, int>((ref) {
  return TimerNotifier();
});

// THICK TIMER
final thickTimerProvider = StateNotifierProvider<TimerNotifier, int>((ref) {
  return TimerNotifier();
});

class TimerNotifier extends StateNotifier<int> {
  TimerNotifier() : super(0);
  Timer? _timer;

  // START TIMER
  void startTimer(int seconds) {
    state = seconds;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state > 0) {
        state--;
      } else {
        timer.cancel();
      }
    });
  }

  // RESET TIMER
  void resetTimer() {
    _timer?.cancel();
    state = 0;
  }

  // STOP TIMER
  void stopTimer() {
    _timer?.cancel();
  }

  // THIN NOODLES
  void thin2Min() {
    startTimer(120);
  }

  void thin5Min() {
    startTimer(300);
  }

  void thin10Min() {
    startTimer(600);
  }

  // THICK NOODLES
  void thick5Min() {
    startTimer(300);
  }

  void thick10Min() {
    startTimer(600);
  }

  void thick15Min() {
    startTimer(780);
  }
}
