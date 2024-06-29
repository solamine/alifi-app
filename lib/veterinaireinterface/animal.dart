import 'historique_rendez.dart';
import 'historique_reserve.dart';
import 'owner.dart';
import 'package:flutter/material.dart';
// Import the OwnerProfileScreen

class AnimalScreen extends StatelessWidget {
  final String name;
  final String imagePath;
  final String owner;
  final String details;

  AnimalScreen({
    required this.name,
    required this.imagePath,
    required this.owner,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.teal,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              padding: EdgeInsets.only(top: 30, bottom: 20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(imagePath),
                  ),
                  SizedBox(height: 10),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, color: Colors.white),
                      SizedBox(width: 8),
                      Text('06 55 33 16 67',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(width: 20),
                      Icon(Icons.email, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: Icon(Icons.pets, color: Colors.teal),
                      title: Text(details,
                          style: TextStyle(color: Colors.grey[700])),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: Icon(Icons.history, color: Colors.teal),
                      title: Text('Historique de rendez-vous',
                          style: TextStyle(color: Colors.grey[700])),
                      trailing:
                          Icon(Icons.arrow_forward_ios, color: Colors.teal),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoriqueScreen(
                                title: 'Historique de rendez-vous'),
                          ),
                        );
                      },
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: Icon(Icons.calendar_today, color: Colors.teal),
                      title: Text('Historique de reservation',
                          style: TextStyle(color: Colors.grey[700])),
                      trailing:
                          Icon(Icons.arrow_forward_ios, color: Colors.teal),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoriqueReserveScreen(
                                title: 'Historique de reservation'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OwnerProfileScreen()),
                );
              },
              child: Text(
                'De $owner',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AnimalScreen(
      name: 'Max',
      imagePath: 'images/dog.png', // Update this path as needed
      owner: 'Belghalem Sadim',
      details: 'Un Chien Male 3 ans',
    ),
  ));
}
