import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  osm.MapController controller = osm.MapController(
    initPosition: osm.GeoPoint(
      latitude: 35.555, // Adjust to your desired initial latitude
      longitude: 7.258, // Adjust to your desired initial longitude
    ),
  );

  List<Veterinarian> veterinarians = [];

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
    loadVeterinarians();
  }

  void requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      addUserLocationMarker();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يتطلب الإذن بالموقع لعرض موقعك على الخريطة.')),
      );
    }
  }

  void addUserLocationMarker() async {
    osm.GeoPoint userLocation = await controller.myLocation();
    controller.addMarker(
      userLocation,
      markerIcon: osm.MarkerIcon(
        icon: Icon(
          Icons.location_on,
          color: Colors.green,
          size: 48,
        ),
      ),
    );
  }

  Future<void> loadVeterinarians() async {
    // Load veterinarians from Firestore
    List<Veterinarian> vetsFromFirestore = await getVeterinarians();

    // Manually add a veterinarian
    Veterinarian manualVeterinarian = Veterinarian(
      name: 'ياسين', // Manually added veterinarian's name
      latitude: 35.9, // Manually added latitude
      longitude: 7.9, // Manually added longitude
    );

    setState(() {
      veterinarians = [...vetsFromFirestore, manualVeterinarian];
    });

    // Add markers for all veterinarians
    for (var vet in veterinarians) {
      await controller.addMarker(
        osm.GeoPoint(latitude: vet.latitude, longitude: vet.longitude),
        markerIcon: osm.MarkerIcon(
          icon: Icon(
            Icons.local_hospital,
            color: Colors.red,
            size: 48,
          ),
        ),
      );
    }
  }

  Future<List<Veterinarian>> getVeterinarians() async {
    List<Veterinarian> vets = [];
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('veterinaire').get();
    snapshot.docs.forEach((doc) {
      vets.add(Veterinarian(
        name: doc['name'],
        latitude: doc['latitude'],
        longitude: doc['longitude'],
      ));
    });
    return vets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('صفحة الحجز'),
      ),
      body: Column(
        children: [
          Expanded(
            child: osm.OSMFlutter(
              controller: controller,
              osmOption: osm.OSMOption(
                roadConfiguration: const osm.RoadOption(
                  roadColor: Colors.yellowAccent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
