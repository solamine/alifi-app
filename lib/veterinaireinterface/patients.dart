import 'animal.dart';
import 'package:flutter/material.dart';

class PatientsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mes Patients',
          style: TextStyle(color: Colors.teal),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.teal),
            onPressed: () {
              // TODO: Navigate to add new patient screen
            },
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.teal),
            onPressed: () {
              showSearch(
                context: context,
                delegate: PatientSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search here',
                    hintStyle: TextStyle(color: Colors.teal),
                    prefixIcon: Icon(Icons.search, color: Colors.teal),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14.0),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: (value) {
                    // TODO: Implement search functionality
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildPatientCard(context, 'Max', 'Belghalem Sadim',
                    'images/dog.png', 'Un chien - Male - 3 ans'),
                _buildPatientCard(context, 'Anaïs', 'Halimi Belkis',
                    'images/cat.png', 'Un chat - Female - 2 ans'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientCard(BuildContext context, String name, String owner,
      String imagePath, String details) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 30,
        ),
        title: Text(name),
        subtitle: Text('$owner\n$details'),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnimalScreen(
                name: name,
                imagePath: imagePath,
                owner: owner,
                details: details,
              ),
            ),
          );
        },
      ),
    );
  }
}

class PatientSearchDelegate extends SearchDelegate<String> {
  final List<String> patients = [
    'Max -  Belghalem Sadim',
    'Anaïs -  Halimi Belkis',
  ];

  final List<String> recentPatients = [
    'Max -  Belghalem Sadim',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: Colors.teal),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.teal),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = patients
        .where((patient) => patient.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            close(context, results[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recentPatients
        : patients
            .where((patient) =>
                patient.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}
