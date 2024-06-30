import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Define Veterinarian class with only name
class Veterinarian {
  final String name;

  Veterinarian({
    required this.name,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Veterinarian> veterinarians = []; // List to hold veterinarians

  @override
  void initState() {
    super.initState();
    _loadVeterinarians();
  }

  // Method to fetch veterinarians from Firestore
  Future<void> _loadVeterinarians() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('veterinaire').get();

    List<Veterinarian> vets = snapshot.docs.map((doc) {
      return Veterinarian(
        name: doc['name'],
      );
    }).toList();

    setState(() {
      veterinarians = vets; // Assign loaded veterinarians to the list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Veterinarians List'),
      ),
      body: ListView.builder(
        itemCount: veterinarians.length,
        itemBuilder: (context, index) {
          Veterinarian vet = veterinarians[index];
          return ListTile(
            title: Text(vet.name),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Veterinarians App',
    home: HomePage(),
  ));
}
