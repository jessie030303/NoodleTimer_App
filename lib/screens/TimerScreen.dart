import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

import 'package:TiMEE/services/Member3_notification_service.dart';
import 'package:TiMEE/models/Member4_timer_history.dart';
import 'package:TiMEE/services/Member4_history_storage_service.dart';

class TimerScreen extends StatefulWidget {
  final int duration;
  final String noodleType;

  const TimerScreen({
    super.key,
    required this.duration,
    required this.noodleType,
  });

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> with WidgetsBindingObserver {
  late int remainingSeconds;
  Timer? timer;
  bool isRunning = true;
  final AudioPlayer player = AudioPlayer();
  AppLifecycleState? appLifecycleState;
  String selectedSound = 'rooster.wav';

  int get selectedDuration => widget.duration;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    remainingSeconds = widget.duration;
    loadSettings();
    startTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    appLifecycleState = state;
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    selectedSound = prefs.getString(
          'selectedSound',
        ) ??
        'rooster.wav';
  }

  void startTimer() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) async {
        if (!isRunning) return;

        if (remainingSeconds > 0) {
          setState(() {
            remainingSeconds--;
          });
        } else {
          timer.cancel();

          await HistoryStorageService().saveHistory(
            TimerHistory(
              noodleType: widget.noodleType,
              durationInSeconds: widget.duration,
              completedAt: DateTime.now(),
              preference: "Cooked",
            ),
          );

          final prefs = await SharedPreferences.getInstance();

          bool notificationOn = prefs.getBool(
                'notificationOn',
              ) ??
              true;
          if (appLifecycleState == AppLifecycleState.paused) {
            if (notificationOn) {
              await NotificationService.showNotification();
              await playAlarm();
            }
            showFinishDialog();
          } else {
            await playAlarm();
            showFinishDialog();
          }
        }
      },
    );
  }

  Future<void> playAlarm() async {
    final prefs = await SharedPreferences.getInstance();

    bool soundOn = prefs.getBool(
          'soundOn',
        ) ??
        true;

    bool vibrationOn = prefs.getBool(
          'vibrationOn',
        ) ??
        true;

    bool repeatAlarmOn = prefs.getBool(
          'repeatAlarmOn',
        ) ??
        true;

    if (soundOn) {
      await player.stop();

      await player.setReleaseMode(
        repeatAlarmOn ? ReleaseMode.loop : ReleaseMode.stop,
      );

      await player.play(
        AssetSource(
          'sounds/$selectedSound',
        ),
      );
    }

    if (vibrationOn) {
      if (await Vibration.hasVibrator() ?? false) {
        if (repeatAlarmOn) {
          Vibration.vibrate(
            pattern: [
              0,
              1000,
              1000,
            ],
            repeat: 0,
          );
        } else {
          Vibration.vibrate(
            duration: 1000,
          );
        }
      }
    }
  }

  Future<void> stopAlarm() async {
    await player.stop();

    Vibration.cancel();
  }

  void pauseTimer() {
    setState(() {
      isRunning = false;
    });
  }

  void resumeTimer() {
    setState(() {
      isRunning = true;
    });
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      remainingSeconds = selectedDuration;
      isRunning = true;
    });
    startTimer();
  }

  void showFinishDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.yellow[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              25,
            ),
          ),
          title: Text(
            "Yay!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/happy_chicken.png',
                height: 150,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Your noodles are ready!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () async {
                await stopAlarm();

                if (mounted) {
                  Navigator.pop(
                    context,
                  );

                  Navigator.pop(
                    context,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
              ),
              child: Text(
                "Back",
              ),
            ),
          ],
        );
      },
    );
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    timer?.cancel();
    stopAlarm();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        title: Text(
          widget.noodleType,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/pixel_chicken.png',
              height: 250,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                color: Colors.yellow[50],
                borderRadius: BorderRadius.circular(
                  25,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: Offset(0, 5),
                    color: Colors.black26,
                  ),
                ],
              ),
              child: Text(
                formatTime(
                  remainingSeconds,
                ),
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (isRunning) {
                      pauseTimer();
                    } else {
                      resumeTimer();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      140,
                      60,
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: Text(
                    isRunning ? "Pause" : "Resume",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                ElevatedButton(
                  onPressed: resetTimer,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      140,
                      60,
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: Text(
                    "Reset",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () async {
                timer?.cancel();
                await stopAlarm();
                if (mounted) {
                  Navigator.pop(
                    context,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  160,
                  55,
                ),
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
              ),
              child: Text(
                "Back",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
