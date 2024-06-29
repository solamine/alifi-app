import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isNotificationEnabled = true;
  bool isEnglishSelected = false;
  bool isFrenchSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paramètres',
          style: TextStyle(color: Colors.teal),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.notifications, color: Colors.teal),
                title: Text('Notification'),
                trailing: Switch(
                  value: isNotificationEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      isNotificationEnabled = value;
                    });
                  },
                  activeColor: Colors.teal,
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ExpansionTile(
                leading: Icon(Icons.language, color: Colors.teal),
                title: Text('Langue'),
                children: [
                  SwitchListTile(
                    title: Text('Anglais'),
                    value: isEnglishSelected,
                    onChanged: (bool value) {
                      setState(() {
                        isEnglishSelected = value;
                        isFrenchSelected = !value;
                      });
                    },
                    activeColor: Colors.teal,
                  ),
                  SwitchListTile(
                    title: Text('Français'),
                    value: isFrenchSelected,
                    onChanged: (bool value) {
                      setState(() {
                        isFrenchSelected = value;
                        isEnglishSelected = !value;
                      });
                    },
                    activeColor: Colors.teal,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.history, color: Colors.teal),
                title: Text('Historique'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
                onTap: () {
                  // Naviguer vers l'écran d'historique
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
