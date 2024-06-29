import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  const ReservationPage({super.key});

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

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
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
    controller.addMarker(userLocation,
        markerIcon: osm.MarkerIcon(
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

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _submitReservation() {
    if (selectedDate != null && selectedTime != null) {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        FirebaseFirestore.instance.collection('reservations').add({
          'selectedDate': selectedDate!.toIso8601String(),
          'selectedTime': selectedTime!.format(context),
          'userId': currentUser.uid,
        }).then((value) {
          String reservationId = value.id;
          FirebaseFirestore.instance.collection('notifications').add({
            'reservationId': reservationId,
            'title': 'حجز جديد',
            'message': 'تم حجز موعد جديد بواسطة ${currentUser.displayName}',
            'date': selectedDate!.toIso8601String(),
            'time': selectedTime!.format(context),
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تم حفظ الحجز بنجاح')),
          );
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('حدث خطأ أثناء حفظ الحجز: $error')),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('لم يتم العثور على المستخدم الحالي')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('الرجاء تحديد التاريخ والوقت أولاً')),
      );
    }
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedDate == null
                            ? 'اختر التاريخ'
                            : 'التاريخ: ${selectedDate!.toLocal()}'
                                .split(' ')[0],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: Text('اختر التاريخ'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedTime == null
                            ? 'اختر الوقت'
                            : 'الوقت: ${selectedTime!.format(context)}',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _selectTime(context),
                      child: Text('اختر الوقت'),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _submitReservation,
                  child: Text('حفظ الحجز'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
