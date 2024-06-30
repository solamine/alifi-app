import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Veterinarian {
  final String id;  // Ajout de l'identifiant
  final String name;
  final String address;
  final String email;

  Veterinarian({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Veterinarian> allVeterinarians = [];
  List<Veterinarian> displayedVeterinarians = [];
  String _currentAddress = 'Recherche de l\'adresse...';
  TextEditingController _searchController = TextEditingController();
  DateTime selectedDateTime = DateTime.now();
  late User? user;  // Ajout de l'utilisateur

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadVeterinarians();
    _getCurrentUser();  // Obtenir l'utilisateur connecté
  }

  Future<void> _getCurrentUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _currentAddress = 'Current location';
    });
  }

  Future<void> _loadVeterinarians() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('veterinaire').get();

      List<Veterinarian> vets = snapshot.docs.map((doc) {
        print('Document data: ${doc.data()}');
        return Veterinarian(
          id: doc.id,
          name: doc['name'],
          address: doc['adresse'],
          email: doc['email'],
        );
      }).toList();

      setState(() {
        allVeterinarians = vets;
        displayedVeterinarians = vets;
      });
    } catch (e) {
      print('Error loading veterinarians: $e');
    }
  }

  void _filterVeterinarians(String query) {
    List<Veterinarian> filteredList = allVeterinarians.where((vet) {
      return vet.name.toLowerCase().contains(query.toLowerCase()) ||
             vet.address.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      displayedVeterinarians = filteredList;
    });
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDateTime) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(pickedDate.year, pickedDate.month, pickedDate.day,
              pickedTime.hour, pickedTime.minute);
        });
      }
    }
  }

  Future<void> _confirmReservation(String vetId) async {
    // Vérifiez que l'utilisateur est connecté
    if (user == null) {
      print("Utilisateur non connecté");
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('reservation').add({
        'Id_user': user!.uid,
        'Id_veterinaire': vetId,
        'date': selectedDateTime,
      });
      print("Réservation confirmée avec succès");
    } catch (e) {
      print("Erreur lors de la confirmation de la réservation: $e");
    }
  }

  void _showReservationDialog(BuildContext context, String vetId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Prendre rendez-vous"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text("Date et heure : ${DateFormat('dd MMM yyyy HH:mm').format(selectedDateTime)}"),
                trailing: Icon(Icons.calendar_today),
                onTap: () {
                  _selectDateTime(context);
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Confirmer"),
              onPressed: () async {
                await _confirmReservation(vetId);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.location_on, color: Colors.teal),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _currentAddress,
                style: const TextStyle(color: Colors.teal),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _searchController,
              onChanged: (value) {
                _filterVeterinarians(value);
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Veterinarians',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: displayedVeterinarians.length,
                itemBuilder: (context, index) {
                  Veterinarian vet = displayedVeterinarians[index];
                  return ListTile(
                    title: Text(vet.name),
                    subtitle: Text('Address: ${vet.address}, Email: ${vet.email}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        _showReservationDialog(context, vet.id);
                      },
                      child: Text('Prendre rendez-vous'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
