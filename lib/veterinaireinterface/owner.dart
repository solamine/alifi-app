import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OwnerProfileScreen extends StatelessWidget {
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
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  padding: EdgeInsets.only(top: 30, bottom: 50),
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                          height: 70), // Space for the CircleAvatar to overlap
                      Text(
                        'Belghalem Sadim',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'images/owner.png'), // Update this path as needed
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildAnimalCard(
                      'Micha', 'images/cat.png', 'Une chatte - Female - 5 ans'),
                  _buildAnimalCard(
                      'Max', 'images/dog.png', 'Un chien - Male - 3 ans'),
                  _buildAnimalCard(
                      'Lucy', 'images/dog.png', 'Une chienne - Female - 8 ans'),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Contacte:',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.google, color: Colors.red, size: 30),
                SizedBox(width: 20),
                Icon(FontAwesomeIcons.facebook, color: Colors.blue, size: 30),
                SizedBox(width: 20),
                Icon(FontAwesomeIcons.instagram, color: Colors.pink, size: 30),
                SizedBox(width: 20),
                Icon(FontAwesomeIcons.whatsapp, color: Colors.green, size: 30),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimalCard(String name, String imagePath, String details) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imagePath),
        ),
        title: Text(name, style: TextStyle(color: Colors.grey[700])),
        subtitle: Text(details, style: TextStyle(color: Colors.grey)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
        onTap: () {
          // Navigate to animal details if needed
        },
      ),
    );
  }
}
