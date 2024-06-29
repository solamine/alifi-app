import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contactez nous',
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
            ContactOption(
              icon: FontAwesomeIcons.google,
              color: Colors.red,
              text: 'Gmail',
              onTap: () {
                // Add Gmail contact functionality here
              },
            ),
            ContactOption(
              icon: FontAwesomeIcons.whatsapp,
              color: Colors.green,
              text: 'WhatsUp',
              onTap: () {
                // Add WhatsUp contact functionality here
              },
            ),
            ContactOption(
              icon: FontAwesomeIcons.facebook,
              color: Colors.blue,
              text: 'Facebook',
              onTap: () {
                // Add Facebook contact functionality here
              },
            ),
            ContactOption(
              icon: FontAwesomeIcons.instagram,
              color: Colors.pink,
              text: 'Instagram',
              onTap: () {
                // Add Instagram contact functionality here
              },
            ),
            ContactOption(
              icon: FontAwesomeIcons.phone,
              color: Colors.black,
              text: 'Téléphone',
              onTap: () {
                // Add Phone contact functionality here
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ContactOption extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onTap;

  ContactOption({
    required this.icon,
    required this.color,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: FaIcon(icon, color: color),
        title: Text(text),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
        onTap: onTap,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ContactUsScreen(),
  ));
}
