import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  bool isFrenchSelected = true;
  bool isEnglishSelected = false;
  bool darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('paramètre', style: TextStyle(color: Colors.teal)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SwitchListTile(
                title: Text('Notification'),
                value: notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    notificationsEnabled = value;
                  });
                },
                secondary: Icon(Icons.notifications, color: Colors.teal),
              ),
              ListTile(
                title: Text('Langue'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    ),
                    SwitchListTile(
                      title: Text('Francais'),
                      value: isFrenchSelected,
                      onChanged: (bool value) {
                        setState(() {
                          isFrenchSelected = value;
                          isEnglishSelected = !value;
                        });
                      },
                    ),
                  ],
                ),
                leading: Icon(Icons.language, color: Colors.teal),
              ),
              Divider(),
              ListTile(
                title: Text('Offres'),
                leading: Icon(Icons.local_offer, color: Colors.teal),
                trailing: Icon(Icons.arrow_forward, color: Colors.teal),
                onTap: () {
                  // Logique pour accéder aux offres
                },
              ),
              ListTile(
                title: Text('Historique'),
                leading: Icon(Icons.history, color: Colors.teal),
                trailing: Icon(Icons.arrow_forward, color: Colors.teal),
                onTap: () {
                  // Logique pour accéder à l'historique
                },
              ),
              ListTile(
                title: Text('Méthode de paiement'),
                leading: Icon(Icons.payment, color: Colors.teal),
                trailing: Icon(Icons.arrow_forward, color: Colors.teal),
                onTap: () {
                  // Logique pour accéder aux méthodes de paiement
                },
              ),
              SwitchListTile(
                title: Text('Mode sombre'),
                value: darkModeEnabled,
                onChanged: (bool value) {
                  setState(() {
                    darkModeEnabled = value;
                  });
                },
                secondary: Icon(Icons.nights_stay, color: Colors.teal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
