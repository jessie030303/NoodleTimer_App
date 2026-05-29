import 'package:flutter/material.dart';
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
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Thin Noodles",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60),
            buildOption(
              context: context,
              timeText: "2 min",
              durationInSeconds: 120,
              preference: "Firm",
            ),
            buildOption(
              context: context,
              timeText: "5 min",
              durationInSeconds: 300,
              preference: "Perfect",
            ),
            buildOption(
              context: context,
              timeText: "10 min",
              durationInSeconds: 600,
              preference: "Soft",
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

Widget buildOption({
  required BuildContext context,
  required String timeText,
  required int durationInSeconds,
  required String preference,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TimerScreen(
            duration: durationInSeconds,
            noodleType: "Thin Noodles",
          ),
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              shape: BoxShape.circle,
            ),

            child: Center(
              child: Text(
                timeText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.orange[300],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  preference,
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
