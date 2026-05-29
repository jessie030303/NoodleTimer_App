import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ThinNoodlesScreen.dart';
import 'ThickNoodlesScreen.dart';
import 'HistoryScreen.dart';
import 'setting_screen.dart';
import 'exit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,

      onPopInvoked: (didPop) {
        if (!didPop) {
          ExitDialog.show(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.yellow[100],
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Home",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                buildMainButton(
                  context: context,
                  text: "Thin Noodles",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ThinNoodlesScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 30),
                buildMainButton(
                  context: context,
                  text: "Thick Noodles",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ThickNoodlesScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 30),
                buildMainButton(
                  context: context,
                  text: "History",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoryScreen()),
                    );
                  },
                ),
                SizedBox(height: 60),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingScreen()),
                    );
                  },
                  icon: Icon(Icons.settings, size: 22),
                  label: Text(
                    "Settings",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[200],
                    foregroundColor: Colors.white,
                    elevation: 4,
                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildMainButton({
  required BuildContext context,
  required String text,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      minimumSize: Size(double.infinity, 90),
      backgroundColor: Colors.yellow[600],
      foregroundColor: CupertinoColors.white,
      elevation: 6,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    ),
  );
}
