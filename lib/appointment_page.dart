import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
// ignore: depend_on_referenced_packages
import 'package:permission_handler/permission_handler.dart';

class Veterinarian {
  final String name;
  final String firstName;
  final String phoneNumber;
  final double latitude;
  final double longitude;

  Veterinarian({
    required this.name,
    required this.firstName,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
  });
}

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  MapController controller = MapController(
    initPosition: GeoPoint(latitude: 35.8667, longitude: 7.1167),
    areaLimit: BoundingBox(
      east: 10.4922941,
      north: 47.8084648,
      south: 45.817995,
      west: 5.9559113,
    ),
  );

  List<Veterinarian> veterinarians = [];
  Veterinarian? selectedVeterinarian;

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
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Location permission is required to show your location on the map.'),
        ),
      );
    }
  }

  void addUserLocationMarker() async {
    GeoPoint userLocation = await controller.myLocation();
    controller.addMarker(userLocation,
        markerIcon: const MarkerIcon(
          icon: Icon(
            Icons.location_on,
            color: Colors.green,
            size: 48,
          ),
        ));
  }

  Future<void> loadVeterinarians() async {
    List<Veterinarian> vets = await getVeterinarians();
    setState(() {
      veterinarians = vets;
    });
    for (var vet in veterinarians) {
      controller.addMarker(
        GeoPoint(latitude: vet.latitude, longitude: vet.longitude),
        markerIcon: const MarkerIcon(
          icon: Icon(
            Icons.local_hospital,
            color: Colors.red,
            size: 48,
          ),
        ),
      );
    }
    controller.listenerMapSingleTapping.addListener(() {
      if (controller.listenerMapSingleTapping.value != null) {
        GeoPoint tappedPoint = controller.listenerMapSingleTapping.value!;
        Veterinarian? tappedVeterinarian;
        for (var vet in veterinarians) {
          if ((tappedPoint.latitude - vet.latitude).abs() < 0.0001 &&
              (tappedPoint.longitude - vet.longitude).abs() < 0.0001) {
            tappedVeterinarian = vet;
            break;
          }
        }
        setState(() {
          selectedVeterinarian = tappedVeterinarian;
        });
      }
    });
  }

  Future<List<Veterinarian>> getVeterinarians() async {
    return [
      Veterinarian(
        name: "Doe",
        firstName: "John",
        phoneNumber: "123456789",
        latitude:
            35.8667, // Mettez à jour la latitude selon l'emplacement exact à Oum El Bouaghi
        longitude:
            7.1167, // Mettez à jour la longitude selon l'emplacement exact à Oum El Bouaghi
      ),
      Veterinarian(
        name: "Smith",
        firstName: "Jane",
        phoneNumber: "987654321",
        latitude:
            35.9000, // Mettez à jour la latitude selon l'emplacement exact à Oum El Bouaghi
        longitude:
            7.0500, // Mettez à jour la longitude selon l'emplacement exact à Oum El Bouaghi
      ),
      Veterinarian(
        name: "Brown",
        firstName: "Charlie",
        phoneNumber: "555555555",
        latitude:
            35.9000, // Mettez à jour la latitude selon l'emplacement exact à Oum El Bouaghi
        longitude:
            7.0500, // Mettez à jour la longitude selon l'emplacement exact à Oum El Bouaghi
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: OSMFlutter(
              controller: controller,
              osmOption: OSMOption(
                userTrackingOption: const UserTrackingOption(
                  enableTracking: true,
                  unFollowUser: false,
                ),
                zoomOption: const ZoomOption(
                  initZoom: 8,
                  minZoomLevel: 3,
                  maxZoomLevel: 19,
                  stepZoom: 1.0,
                ),
                userLocationMarker: UserLocationMaker(
                  personMarker: const MarkerIcon(
                    icon: Icon(
                      Icons.location_history_rounded,
                      color: Colors.red,
                      size: 48,
                    ),
                  ),
                  directionArrowMarker: const MarkerIcon(
                    icon: Icon(
                      Icons.double_arrow,
                      size: 48,
                    ),
                  ),
                ),
                roadConfiguration: const RoadOption(
                  roadColor: Colors.yellowAccent,
                ),
                markerOption: MarkerOption(
                  defaultMarker: const MarkerIcon(
                    icon: Icon(
                      Icons.person_pin_circle,
                      color: Colors.blue,
                      size: 56,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (selectedVeterinarian != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Selected Veterinarian: ${selectedVeterinarian!.name} ${selectedVeterinarian!.firstName}',
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Background color
                      disabledBackgroundColor: Colors.white, // Text color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppointmentBookingPage(
                            veterinarian: selectedVeterinarian!,
                          ),
                        ),
                      );
                    },
                    child: const Text('Prendre Rendez-vous'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class AppointmentBookingPage extends StatelessWidget {
  final Veterinarian veterinarian;

  const AppointmentBookingPage({super.key, required this.veterinarian});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prendre Rendez-vous'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Prendre rendez-vous avec ${veterinarian.name} ${veterinarian.firstName}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Téléphone: ${veterinarian.phoneNumber}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 32),
            // Ajoutez ici les champs nécessaires pour prendre un rendez-vous
            TextField(
              decoration: InputDecoration(
                labelText: 'Date',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Heure',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Logic pour confirmer la prise de rendez-vous
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Rendez-vous pris avec succès!')),
                );
              },
              child: Text('Confirmer le Rendez-vous'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AppointmentPage(),
  ));
}
