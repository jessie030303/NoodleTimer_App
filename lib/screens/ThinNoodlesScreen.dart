import 'package:flutter/material.dart';
import '../models/Member4_timer_history.dart';
import '../providers/Member4_history_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'TimerScreen.dart';

class ThinNoodlesScreen extends ConsumerWidget {
  const ThinNoodlesScreen({super.key});

@override
Widget build(BuildContext context, WidgetRef ref) {
  return Scaffold(
    backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          "Thin Noodles",
          style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            buildOption(
              ref: ref,
              context: context,
              timeText: "2 min",
              durationInSeconds: 120,
              preference: "Rushing mode",
            ),
        buildOption(
          ref: ref,
          context: context,
          timeText: "5 min",
          durationInSeconds: 300,
          preference: "Relax mode",
        ),
        buildOption(
          ref: ref,
          context: context,
          timeText: "10 min",
          durationInSeconds: 600,
          preference: "Soggy",
        ),
        ],
        ),
      ),
        );

}

  Future<void> saveCookingHistory({
    required WidgetRef ref,
    required int durationInSeconds,
    required String preference,
  }) async {
    final history = TimerHistory(
      noodleType: 'Thin Noodles',
      durationInSeconds: durationInSeconds,
      completedAt: DateTime.now(),
      preference: preference,
    );

    await ref.read(historyStorageServiceProvider).saveHistory(history);
  }

  Widget buildOption({
    required WidgetRef ref,
    required BuildContext context,
    required String timeText,
    required int durationInSeconds,
    required String preference,
  }) {
    return GestureDetector(
      onTap: () async {
        await saveCookingHistory(
          ref: ref,

          durationInSeconds: durationInSeconds,

          preference: preference,
        );

        Navigator.push(
          context,

          MaterialPageRoute(
            builder: (context) => TimerScreen(duration: durationInSeconds),
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(60),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),

        child: Row(
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: const BoxDecoration(
                color: Colors.deepOrange,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  timeText,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF5F5F5),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 20),
            Expanded(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(30),
                ),

                child: Center(
                  child: Text(
                    preference,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
