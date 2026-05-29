import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  bool soundOn = true;
  bool vibrationOn = true;
  bool notificationOn = true;
  bool repeatAlarmOn = true;

  String selectedSound = 'rooster.wav';
  List<String> validSounds = ['rooster.wav', 'jumping.wav', 'swan_lake.wav'];

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  void loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    String savedSound = prefs.getString('selectedSound') ?? 'rooster.wav';
    setState(() {
      soundOn = prefs.getBool('soundOn') ?? true;
      vibrationOn = prefs.getBool('vibrationOn') ?? true;
      notificationOn = prefs.getBool('notificationOn') ?? true;
      repeatAlarmOn = prefs.getBool('repeatAlarmOn') ?? true;
      if (validSounds.contains(savedSound)) {
        selectedSound = savedSound;
      } else {
        selectedSound = 'rooster.wav';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              buildSwitchTile(
                icon: Icons.volume_up,
                title: "Sound",
                subtitle: "Enable timer sound",
                value: soundOn,
                onChanged: (value) async {
                  final prefs = await SharedPreferences.getInstance();
                  setState(() {
                    soundOn = value;
                  });
                  await prefs.setBool('soundOn', value);
                },
              ),
              SizedBox(height: 20),
              buildSwitchTile(
                icon: Icons.vibration,
                title: "Vibration",
                subtitle: "Enable timer vibration",
                value: vibrationOn,
                onChanged: (value) async {
                  final prefs = await SharedPreferences.getInstance();
                  setState(() {
                    vibrationOn = value;
                  });
                  await prefs.setBool('vibrationOn', value);
                },
              ),
              SizedBox(height: 20),
              buildSwitchTile(
                icon: Icons.notifications,
                title: "Notifications",
                subtitle: "Show timer notifications",
                value: notificationOn,
                onChanged: (value) async {
                  final prefs = await SharedPreferences.getInstance();
                  setState(() {
                    notificationOn = value;
                  });
                  await prefs.setBool('notificationOn', value);
                },
              ),
              const SizedBox(height: 20),
              buildSwitchTile(
                icon: Icons.alarm,
                iconColor: Colors.deepOrange,
                title: "Repeat Alarm",
                subtitle: "Alarm repeats until stopped",
                value: repeatAlarmOn,
                onChanged: (value) async {
                  final prefs = await SharedPreferences.getInstance();
                  setState(() {
                    repeatAlarmOn = value;
                  });
                  await prefs.setBool('repeatAlarmOn', value);
                },
              ),
              SizedBox(height: 20),
              Card(
                color: Colors.orange[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 3,
                child: ListTile(
                  leading: Icon(Icons.music_note, color: Colors.deepOrange),
                  title: Text(
                    "Notification Sound",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  subtitle: DropdownButton<String>(
                    value: selectedSound,
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(
                        value: 'rooster.wav',
                        child: Text('Rooster'),
                      ),
                      DropdownMenuItem(
                        value: 'jumping.wav',
                        child: Text('Jumping'),
                      ),
                      DropdownMenuItem(
                        value: 'swan_lake.wav',
                        child: Text('Swan Lake'),
                      ),
                    ],
                    onChanged: (value) async {
                      if (value != null) {
                        final prefs = await SharedPreferences.getInstance();
                        setState(() {
                          selectedSound = value;
                        });
                        await prefs.setString('selectedSound', value);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: Colors.orange[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const ListTile(
                  leading: Icon(Icons.info, color: Colors.black),
                  title: Text(
                    "Timer Info",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  subtitle: Text("TiMEE v1.0\nNoodle Cooking Timer App"),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSwitchTile({
    required IconData icon,
    Color iconColor = Colors.black,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Card(
      color: Colors.orange[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 3,
      child: SwitchListTile(
        secondary: Icon(icon, color: iconColor),
        activeColor: Colors.deepOrange,
        activeTrackColor: Colors.orange,
        title: Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
