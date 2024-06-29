import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'selection_page.dart'; // Importez la page de sélection
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Définir SplashScreen comme page d'accueil
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // الاستماع لتغييرات حالة المصادقة
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('========================User is currently signed out!');
      } else {
        print('========================User is signed in!');
      }
    });

    // Naviguer vers SelectionPage après 3 secondes
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SelectionPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70.0,
                backgroundImage: AssetImage('images/logo.png'),
                backgroundColor: Colors.white,
              ),
              Text(
                'ALIFI',
                style: TextStyle(
                  fontSize: 50.0,
                  color: Color.fromARGB(255, 0, 197, 171),
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
