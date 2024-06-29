import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Centre d\'Aide',
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FAQ',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
            SizedBox(height: 10),
            _buildFaqItem(
              'Comment réserver une place pour mon animal ?',
              'Pour réserver une place, veuillez utiliser notre application pour sélectionner les dates souhaitées et compléter le formulaire de réservation. Vous pouvez également nous appeler directement.',
            ),
            _buildFaqItem(
              'Quels sont les tarifs pour le séjour des animaux ?',
              'Les tarifs varient en fonction de la durée du séjour et du type d\'animal. Veuillez consulter notre site web ou l\'application pour les détails des tarifs.',
            ),
            _buildFaqItem(
              'Quels services offrez-vous pendant le séjour de mon animal ?',
              'Nous offrons divers services tels que les promenades quotidiennes, les soins médicaux de base, et une alimentation équilibrée. Des services supplémentaires peuvent être ajoutés à la demande.',
            ),
            SizedBox(height: 20),
            Text(
              'Ressources Utiles',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
            SizedBox(height: 10),
            _buildResourceItem(
              'Guide de réservation',
              'Un guide complet pour vous aider à réserver une place pour votre animal.',
              Icons.book,
            ),
            _buildResourceItem(
              'Conseils pour le séjour de votre animal',
              'Des conseils et astuces pour assurer un séjour agréable à votre animal.',
              Icons.pets,
            ),
            _buildResourceItem(
              'Services de santé pour animaux',
              'Trouvez les services de santé pour animaux disponibles près de chez vous.',
              Icons.local_hospital,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: TextStyle(color: Colors.teal),
      ),
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(answer),
        ),
      ],
    );
  }

  Widget _buildResourceItem(String title, String description, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
        onTap: () {
          // Handle resource item tap
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HelpCenterScreen(),
  ));
}
