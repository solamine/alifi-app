import 'package:alifi_application/map_page.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:geolocator/geolocator.dart';
// ignore: depend_on_referenced_packages
import 'package:geocoding/geocoding.dart';
import 'profile_page.dart';
import 'chat_page.dart';
import 'calendar_page.dart';
import 'appointment_page.dart';
import 'my_animals_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _currentAddress = 'Recherche de l\'adresse...';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Vérifiez si les services de localisation sont activés
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Les services de localisation sont désactivés.');
    }

    // Vérifiez les permissions de localisation
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Les permissions de localisation sont refusées.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Les permissions de localisation sont refusées de manière permanente.');
    }

    // Obtenez la position actuelle
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _getAddressFromLatLng(position);
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.locality}, ${place.country}';
      });
    } catch (e) {
      print(e);
    }
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
                'Nos services',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ServiceButton(
                    image: 'images/service_1.png',
                    label: 'Rendez-vous',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AppointmentPage()),
                      );
                    },
                  ),
                  ServiceButton(
                    image: 'images/service_2.png',
                    label: 'Reservation',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReservationPage()),
                      );
                    },
                  ),
                  ServiceButton(
                    image: 'images/service_3.png',
                    label: 'Mes animaux',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyAnimalsPage()),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('images/home.png')),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
                color: Color.fromARGB(255, 81, 80, 80),
                AssetImage('images/calendar (2).png')),
            label: 'Calendrier',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
                color: Color.fromARGB(255, 79, 79, 79),
                AssetImage('images/chat (2).png')),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
                color: Color.fromARGB(255, 80, 80, 80),
                AssetImage('images/profile-user (3).png')),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.teal,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalendarPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatPage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }
        },
      ),
    );
  }
}

class ServiceButton extends StatelessWidget {
  final String image;
  final String label;
  final VoidCallback onTap;

  ServiceButton(
      {required this.image, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Image.asset(
              image,
              height: 60.0,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
