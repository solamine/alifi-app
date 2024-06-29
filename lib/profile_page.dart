import 'package:flutter/material.dart';
import 'package:alifi_application/edit_profile_page.dart';
import 'package:alifi_application/settingspage.dart';
import 'package:alifi_application/login_page.dart'; // Assurez-vous que le chemin est correct

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "prenom complet";
  String firstName = "prenom";
  String lastName = "nom";
  String gender = "genre";
  String bio = "bio ";
  String phoneNumber = "numero ";
  String profileImage = 'images/profile.png';

  void updateProfile(Map<String, dynamic> updatedProfile) {
    setState(() {
      name = updatedProfile['name'];
      firstName = updatedProfile['firstName'];
      lastName = updatedProfile['lastName'];
      gender = updatedProfile['gender'];
      bio = updatedProfile['bio'];
      phoneNumber = updatedProfile['phoneNumber'];
      profileImage = updatedProfile['profileImage'];
    });
  }

  void _logout() {
    // Ajoutez votre logique de déconnexion ici.
    // Par exemple, vous pouvez supprimer la session de l'utilisateur ou les tokens.
    // Après la déconnexion, naviguez vers l'écran de connexion.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(), // Assurez-vous d'avoir une LoginPage
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Votre profil'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage(profileImage),
                ),
                SizedBox(height: 10),
                Text(
                  '$firstName $lastName',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  bio,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ProfileOption(
                    icon: Icons.edit,
                    title: 'Modifier le profil',
                    onTap: () async {
                      final updatedProfile = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(
                            name: name,
                            firstName: firstName,
                            lastName: lastName,
                            gender: gender,
                            bio: bio,
                            phoneNumber: phoneNumber,
                            profileImage: profileImage,
                          ),
                        ),
                      );
                      if (updatedProfile != null) {
                        updateProfile(updatedProfile);
                      }
                    },
                  ),
                  ProfileOption(
                    icon: Icons.settings,
                    title: 'Paramètres',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsPage(),
                        ),
                      );
                    },
                  ),
                  ProfileOption(
                    icon: Icons.logout,
                    title: 'Déconnexion',
                    onTap: _logout,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  ProfileOption({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward, color: Colors.teal),
        onTap: onTap,
      ),
    );
  }
}
