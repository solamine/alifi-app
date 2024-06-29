import 'package:flutter/material.dart';

class HistoriqueScreen extends StatelessWidget {
  final String title;

  HistoriqueScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
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
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: 10, // Adjust based on your data
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.teal),
              title: Text(
                'Max avait un rendez-vous le',
                style: TextStyle(color: Colors.grey[700]),
              ),
              subtitle: Text(
                '11 | 04 | 2024',
                style: TextStyle(color: Colors.teal),
              ),
              trailing: Icon(Icons.arrow_drop_down, color: Colors.teal),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HistoriqueScreen(title: 'Historique de Rendez-vous'),
  ));
}
