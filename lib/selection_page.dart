import 'package:flutter/material.dart';
// Importez la page du scanner pour le vétérinaire
// Importez la page d'accueil pour l'éleveur
import 'login_page.dart'; // Importez la page de connexion pour les éleveurs
import 'veterinarian_login_page.dart'; // Importez la page de connexion pour les vétérinaires

class SelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vous êtes un ?'),
        backgroundColor: Color.fromARGB(255, 0, 197, 171),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Vous êtes un !',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 197, 171),
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  // Naviguer vers la page de connexion pour les vétérinaires
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VeterinarianLoginPage()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'images/veterinaire.jpg',
                        height: 120.0,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Vétérinaire',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  // Naviguer vers la page de connexion pour les éleveurs
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'images/eleveur.jpg',
                        height: 120.0,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Éleveur',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
