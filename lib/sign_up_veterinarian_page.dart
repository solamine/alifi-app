import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpVeterinarianPage extends StatefulWidget {
  @override
  _SignUpVeterinarianPageState createState() => _SignUpVeterinarianPageState();
}

class _SignUpVeterinarianPageState extends State<SignUpVeterinarianPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  Future<void> _signUp() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    double latitude = double.parse(_latitudeController.text);
    double longitude = double.parse(_longitudeController.text);

    // Validate the input

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match!')),
      );
      return;
    }

    // Save veterinarian data to Firestore
    await FirebaseFirestore.instance.collection('veterinaire').add({
      'name': name,
      'email': email,
      'password': password, // Not recommended to save password as plain text
      'latitude': latitude,
      'longitude': longitude,
    });

    // Navigate to the login page or show a success message
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription Vétérinaire'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nom',
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
              ),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirmer le mot de passe',
              ),
              obscureText: true,
            ),
            TextField(
              controller: _latitudeController,
              decoration: InputDecoration(
                labelText: 'Latitude',
              ),
            ),
            TextField(
              controller: _longitudeController,
              decoration: InputDecoration(
                labelText: 'Longitude',
              ),
            ),
            ElevatedButton(
              onPressed: _signUp,
              child: Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }
}
