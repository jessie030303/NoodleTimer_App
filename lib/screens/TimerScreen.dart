import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';
import '../services/Member3_notification_service.dart';

class TimerScreen extends StatefulWidget {
  final int duration;
  final AudioPlayer player = AudioPlayer();

  TimerScreen({super.key, required this.duration});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late int timeLeft;
  final AudioPlayer player = AudioPlayer();

  Timer? timer;

  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    timeLeft = widget.duration;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (timeLeft > 0) {
        if (!isPaused) {
          if (timeLeft > 0) {
            setState(() {
              timeLeft--;
            });
          } else {
            timer.cancel();

            await player.play(
              AssetSource('sounds/ding.mp3'),
            );
            if (await Vibration.hasVibrator() ?? false) {
              Vibration.vibrate(duration: 2000);
    }
          NotificationService.showNotification();
        }
      }
    }
    }
      );
  }

  void pauseTimer() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  void resetTimer() {
    setState(() {
      timeLeft = widget.duration;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // SPACE FOR TOP
              SizedBox(height: 5),
              // CHICKEN AND CLOCK
              Stack(
                alignment: Alignment.center,

                children: [
                  // CHICKEN IMAGE
                  Image.asset(
                    'assets/images/pixel_chicken.png',
                    height: 400,
                    width: 800,
                    fit: BoxFit.contain,
                  ),

                  // TIMER BOX
                  Transform.translate(
                    offset: Offset(0, 40),

                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.yellow[100],
                        borderRadius: BorderRadius.circular(20),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 5,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),

                      // TIMER TEXT
                      child: Text(
                        "${(timeLeft ~/ 60).toString().padLeft(2, '0')}:${(timeLeft % 60).toString().padLeft(2, '0')}",

                        textAlign: TextAlign.center,

                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 50),

              Transform.translate(
                offset: Offset(0, -120),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: pauseTimer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 8,
                        shadowColor: Colors.black38,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 22,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: Text(
                        "Pause",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),

                    ElevatedButton(
                      onPressed: resetTimer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 8,
                        shadowColor: Colors.black38,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 22,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: Text(
                        "Reset",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              Transform.translate(
                offset: Offset(0, -120),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 8,
                    shadowColor: Colors.black38,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: Text(
                    "Back",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
