import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ThinNoodlesScreen.dart';
import 'ThickNoodlesScreen.dart';
import 'history_screen.dart';
import 'setting_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],

      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: CupertinoColors.white,
        title: Text(
          "TiMEE",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThinNoodlesScreen(),
                  ),
                );
              },

              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 70),
                backgroundColor: Colors.yellow,
                foregroundColor: CupertinoColors.white,
              ),

              child: Text(
                "Thin Noodles",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThickNoodlesScreen(),
                  ),
                );
              },

              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 70),
                backgroundColor: Colors.yellow,
                foregroundColor: CupertinoColors.white,
              ),

              child: Text(
                "Thick Noodles",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HistoryScreen(),
                  ),
                );
              },

              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 70),
                backgroundColor: Colors.yellow,
                foregroundColor: CupertinoColors.white,
              ),

              child: Text(
                "History",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 60),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingScreen(),
                  ),
                );
              },

              style: ElevatedButton.styleFrom(
                minimumSize: Size(60, 30),
                backgroundColor: Colors.white10,
                foregroundColor: Colors.white,
              ),

              child: Text(
                "Settings",
                style: TextStyle(
                  fontSize: 20,
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
