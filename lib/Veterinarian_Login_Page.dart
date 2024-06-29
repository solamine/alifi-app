import 'package:flutter/material.dart';
import 'scanner_page.dart';
import 'forgot_password_page.dart';
import 'sign_up_veterinarian_page.dart'; // Import de la page d'inscription des vétérinaires

class VeterinarianLoginPage extends StatefulWidget {
  @override
  _VeterinarianLoginPageState createState() => _VeterinarianLoginPageState();
}

class _VeterinarianLoginPageState extends State<VeterinarianLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _stayLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Se connecter - Vétérinaire'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 70.0,
              backgroundImage: AssetImage('images/logo.png'),
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Checkbox(
                  value: _stayLoggedIn,
                  onChanged: (bool? value) {
                    setState(() {
                      _stayLoggedIn = value ?? false;
                    });
                  },
                ),
                const Text('Rester connecté'),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                print('Email: ${_emailController.text}');
                print('Mot de passe: ${_passwordController.text}');
                print('Rester connecté: $_stayLoggedIn');
                // Logique de connexion ici
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ScannerPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 197, 171),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Se connecter',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgotPasswordPage()),
                );
              },
              child: const Text(
                'Mot de passe oublié?',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignUpVeterinarianPage()),
                );
              },
              child: const Text(
                'Vous n\'avez pas de compte ? S\'inscrire',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
