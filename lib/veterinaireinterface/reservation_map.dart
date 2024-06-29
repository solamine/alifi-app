import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Veterinarian {
  final String name;
  final String town;
  final String state;

  Veterinarian({
    required this.name,
    required this.town,
    required this.state,
  });
}

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  osm.MapController controller = osm.MapController(
    initPosition: osm.GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
    areaLimit: osm.BoundingBox(
      east: 10.4922941,
      north: 47.8084648,
      south: 45.817995,
      west: 5.9559113,
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
    try {
      List<Veterinarian> vets = await getVeterinarians();
      setState(() {
        veterinarians = vets;
      });
      for (var vet in veterinarians) {
        if (vet.latitude != null && vet.longitude != null) {
          // تحويل اسم البلدة والولاية إلى تسمية مخصصة للماركر
          String markerLabel = '${vet.town}, ${vet.state}';

          controller.addMarker(
            osm.GeoPoint(latitude: vet.latitude!, longitude: vet.longitude!),
            markerIcon: osm.MarkerIcon(
              icon: Icon(
                Icons.local_hospital,
                color: Colors.red,
                size: 48,
              ),
            ),
            markerInfo: osm.MarkerInfo(
              title: vet.name,
              snippet: markerLabel,
            ),
          );
        }
      }
    } catch (e) {
      print('Error loading veterinarians: $e');
    }
  }

  Future<List<Veterinarian>> getVeterinarians() async {
    List<Veterinarian> vets = [];
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('veterinarian').get();
    snapshot.docs.forEach((doc) {
      if (doc.exists) {
        vets.add(Veterinarian(
          name: doc['name'],
          town: doc['town'],
          state: doc['state'],
        ));
      }
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
                userTrackingOption: const osm.UserTrackingOption(
                  enableTracking: true,
                  unFollowUser: false,
                ),
                zoomOption: const osm.ZoomOption(
                  initZoom: 8,
                  minZoomLevel: 3,
                  maxZoomLevel: 19,
                  stepZoom: 1.0,
                ),
                userLocationMarker: osm.UserLocationMaker(
                  personMarker: const osm.MarkerIcon(
                    icon: Icon(
                      Icons.location_history_rounded,
                      color: Colors.red,
                      size: 48,
                    ),
                  ),
                  directionArrowMarker: const osm.MarkerIcon(
                    icon: Icon(
                      Icons.double_arrow,
                      size: 48,
                    ),
                  ),
                ),
                roadConfiguration: const osm.RoadOption(
                  roadColor: Colors.yellowAccent,
                ),
                markerOption: osm.MarkerOption(
                  defaultMarker: const osm.MarkerIcon(
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
        ],
      ),
    );
  }
}
