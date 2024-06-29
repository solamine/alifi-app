import 'package:flutter/material.dart';

class AvisScreen extends StatelessWidget {
  final List<String> _reviews = [
    "Excellent vétérinaire, très compétent et attentionné envers nos animaux de compagnie.",
    "Je recommande vivement ce vétérinaire, très professionnel et à l'écoute.",
    "Très satisfait du service. Les tarifs sont également raisonnables.",
    "Le meilleur vétérinaire que j'ai jamais rencontré !"
  ];

  final double _averageRating = 4.9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Avis',
          style: TextStyle(color: Colors.teal),
        ),
        iconTheme: IconThemeData(color: Colors.teal),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildRating(),
            SizedBox(height: 20),
            Text(
              'Avis des Utilisateurs',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
            SizedBox(height: 10),
            _buildReviews(),
          ],
        ),
      ),
    );
  }

  Widget _buildRating() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: Colors.yellow),
            SizedBox(width: 5),
            Text(
              _averageRating.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(
          'Basé sur ${_reviews.length} avis',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildReviews() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _reviews.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _reviews[index],
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.thumb_up_alt, color: Colors.green),
                      SizedBox(width: 5),
                      Text(
                        '124',
                        style: TextStyle(color: Colors.green),
                      ),
                      SizedBox(width: 20),
                      Icon(Icons.thumb_down_alt, color: Colors.red),
                      SizedBox(width: 5),
                      Text(
                        '5',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
