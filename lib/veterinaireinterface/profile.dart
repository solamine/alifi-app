import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'avis.dart';
import 'contactus.dart';
import 'feedback.dart';
import 'helpcenter.dart';
import 'settings.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _profileName = 'Dr. John Doe';
  String _profilePhoto = 'images/doctor.png';
  String _location = 'V4F5+P7Q, Unnamed Road, Oum El Bouaghi';
  String _phoneNumber = '06 55 33 16 63';
  String _email = 'johndoe99@gmail.com';
  String _clinicType = 'Cabiner';
  final days = [
    'Dimanche',
    'Lundi',
    'Mardi',
    'Mercredi',
    'Jeudi',
    'Vendredi',
    'Samdi'
  ];
  List<String> hours = [
    '09:00 - 15:00',
    '09:00 - 15:00',
    '09:00 - 15:00',
    '09:00 - 15:00',
    '09:00 - 15:00',
    '00:00 - 00:00',
    '00:00 - 00:00'
  ];

  // Function to handle editing the profile photo
  void _editProfilePhoto(BuildContext context) {
    // Implement photo editing functionality here
    // For example, you can show a dialog to choose a new photo
  }

  // Function to handle editing opening hours for a specific day
  void _editOpeningHours(BuildContext context, int dayIndex) {
    TextEditingController _hoursController =
        TextEditingController(text: hours[dayIndex]);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Modifier les heures d\'ouverture'),
          content: TextField(
            controller: _hoursController,
            decoration: InputDecoration(
                hintText: 'Entrez les nouvelles heures (ex: 09:00 - 18:00)'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  hours[dayIndex] = _hoursController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  void _editField(BuildContext context, String title, String currentValue,
      Function(String) onSave) {
    TextEditingController controller =
        TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Modifier $title'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Entrez un nouveau $title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.of(context).pop();
              },
              child: Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  void _editClinicType(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Type de pratique'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Cabiner'),
                onTap: () {
                  setState(() {
                    _clinicType = 'Cabiner';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Libéral'),
                onTap: () {
                  setState(() {
                    _clinicType = 'Libéral';
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoCard(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 40, color: Colors.teal),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildOpeningHours(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(days.length, (index) {
        return GestureDetector(
          onTap: () {
            _editOpeningHours(context, index);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  days[index],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  hours[index],
                  style: TextStyle(color: Colors.grey),
                ),
                Icon(Icons.edit, color: Colors.teal),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.teal),
        ),
        iconTheme: IconThemeData(color: Colors.teal),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.teal),
              title: Text('Paramètres'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.thumb_up, color: Colors.teal),
              title: Text('Aidez nous à améliorer'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedbackScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.help, color: Colors.teal),
              title: Text('Centre d\'aide'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpCenterScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.mail, color: Colors.teal),
              title: Text('Contactez-nous'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUsScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title:
                  Text('Se Déconnecter', style: TextStyle(color: Colors.red)),
              onTap: () {
                // Handle logout
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(_profilePhoto),
                  ),
                  Positioned(
                    bottom: 0,
                    child: IconButton(
                      icon: Icon(Icons.edit, color: Colors.teal),
                      onPressed: () {
                        _editProfilePhoto(context);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _editField(context, 'nom', _profileName, (newName) {
                          setState(() {
                            _profileName = newName;
                          });
                        });
                      },
                      child: Text(
                        _profileName,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                      ),
                    ),
                    Text('Docteur vétérinaire',
                        style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        _editClinicType(context);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.teal[50],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(_clinicType,
                                style: TextStyle(color: Colors.teal)),
                            Icon(Icons.arrow_drop_down, color: Colors.teal),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInfoCard('100+', 'Patients', FontAwesomeIcons.users),
                  _buildInfoCard(
                      '9+', 'Ans Exp.', FontAwesomeIcons.calendarAlt),
                  _buildInfoCard('4.9+', 'Évaluation', FontAwesomeIcons.star),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AvisScreen()),
                      );
                    },
                    child: _buildInfoCard(
                        'Avis', 'Avis', FontAwesomeIcons.comment),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(height: 30, thickness: 2),
              SizedBox(height: 20),
              Text(
                'Informations de contact',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.location_on, color: Colors.teal),
                title: Text(_location),
              ),
              ListTile(
                leading: Icon(Icons.phone, color: Colors.teal),
                title: Text(_phoneNumber),
                onTap: () {
                  // Implement phone call functionality here
                },
              ),
              ListTile(
                leading: Icon(Icons.email, color: Colors.teal),
                title: Text(_email),
                onTap: () {
                  // Implement email sending functionality here
                },
              ),
              SizedBox(height: 20),
              Divider(height: 30, thickness: 2),
              SizedBox(height: 20),
              Text(
                'Heures d\'ouverture',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildOpeningHours(context),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfileScreen(),
  ));
}
