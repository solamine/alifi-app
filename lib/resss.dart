import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Veterinarian {
  final String name;
  final String email;

  Veterinarian({
    required this.name,
    required this.email,
  });
}

class ReservationPage extends StatefulWidget {
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  List<Veterinarian> veterinarians = [];

  @override
  void initState() {
    super.initState();
    _loadVeterinarians();
  }

  Future<void> _loadVeterinarians() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('veterinaires').get();

    List<Veterinarian> vets = snapshot.docs.map((doc) {
      return Veterinarian(
        name: doc['name'],
        email: doc['email'],
      );
    }).toList();

    setState(() {
      veterinarians = vets;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Réservation'),
      ),
      body: ListView.builder(
        itemCount: veterinarians.length,
        itemBuilder: (context, index) {
          Veterinarian vet = veterinarians[index];
          return ListTile(
            title: Text(vet.name),
            subtitle: Text(vet.email),
          );
        },
      ),
    );
  }
}
