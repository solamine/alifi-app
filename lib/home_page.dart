import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Define Veterinarian class with name, latitude, and longitude
class Veterinarian {
  final String name;
  final double latitude;
  final double longitude;

  Veterinarian({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Veterinarian> allVeterinarians = []; // All veterinarians from Firestore
  List<Veterinarian> displayedVeterinarians =
      []; // Veterinarians displayed based on search

  String _currentAddress = 'Recherche de l\'adresse...';
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadVeterinarians();
  }

  // Method to obtain current location (to be implemented)
  Future<void> _getCurrentLocation() async {
    // Placeholder implementation
    setState(() {
      _currentAddress = 'Current location'; // Update with actual location
    });
  }

  // Method to fetch veterinarians from Firestore
  Future<void> _loadVeterinarians() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('veterinaire').get();

    List<Veterinarian> vets = snapshot.docs.map((doc) {
      return Veterinarian(
        name: doc['name'],
        latitude: doc['latitude'],
        longitude: doc['longitude'],
      );
    }).toList();

    setState(() {
      allVeterinarians = vets;
      displayedVeterinarians =
          vets; // Initialize displayed list with all veterinarians
    });
  }

  // Method to filter veterinarians based on search query
  void _filterVeterinarians(String query) {
    List<Veterinarian> filteredList = allVeterinarians.where((vet) {
      return vet.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      displayedVeterinarians = filteredList;
    });
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  _filterVeterinarians(
                      value); // Call filter method on text change
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
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: displayedVeterinarians.length,
                itemBuilder: (context, index) {
                  Veterinarian vet = displayedVeterinarians[index];
                  return ListTile(
                    title: Text(vet.name),
                    subtitle: Text(
                      'Lat: ${vet.latitude}, Long: ${vet.longitude}',
                    ),
                  );
                },
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
