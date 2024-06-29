import 'package:alifi_application/veterinaireinterface/contactus.dart';
import 'package:alifi_application/veterinaireinterface/feedback.dart';
import 'package:alifi_application/veterinaireinterface/helpcenter.dart';
import 'package:alifi_application/veterinaireinterface/notification.dart';
import 'package:alifi_application/veterinaireinterface/settings.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:badges/badges.dart' as badges; // Alias for badges package

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservation App',
      home: ReservationScreen(),
    );
  }
}

class ReservationScreen extends StatefulWidget {
  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  List<Reservation> _reservations = [];
  int newNotificationCount = 3; // Initial notification count

  @override
  void initState() {
    super.initState();
    _reservations = _getReservationsForDay(_selectedDay);
  }

  List<Reservation> _getReservationsForDay(DateTime day) {
    // Simulate fetching data from a database or API
    if (day.day % 2 == 0) {
      return [
        Reservation(
            number: 1,
            name: 'Anaiis - Halimi Belkis',
            dateRange: 'De 17/04/2024 à 02/05/2024'),
        Reservation(number: 2, name: 'Lucy - Athman Aya Malak'),
      ];
    } else {
      return [
        Reservation(
            number: 1,
            name: 'John Doe - Jane Doe',
            dateRange: 'De 01/05/2024 à 10/05/2024'),
        Reservation(number: 2, name: 'Alice - Bob'),
      ];
    }
  }

  void _resetNotificationCount() {
    setState(() {
      newNotificationCount = 0; // Reset the notification count
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Réservation',
          style: TextStyle(color: Colors.teal),
        ),
        actions: [
          IconButton(
            icon:
                FaIcon(FontAwesomeIcons.facebookMessenger, color: Colors.teal),
            onPressed: () {},
          ),
          badges.Badge(
            // Use the alias here
            position: badges.BadgePosition.topEnd(top: 0, end: 3),
            badgeColor: Colors.red,
            badgeContent: Text(
              newNotificationCount.toString(),
              style: TextStyle(color: Colors.white),
            ),
            child: IconButton(
              icon: Icon(Icons.notifications, color: Colors.teal),
              onPressed: () {
                _resetNotificationCount();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.teal),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.teal),
              title: Text('Paramètres'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.thumb_up, color: Colors.teal),
              title: Text('Aidez nous à améliorer'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedbackScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.help, color: Colors.teal),
              title: Text('Centre d\'aide'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpCenterScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.mail, color: Colors.teal),
              title: Text('Contactez-nous'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUsScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title:
                  Text('Se Déconnecter', style: TextStyle(color: Colors.red)),
              onTap: () {
                // Handle logout
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _reservations = _getReservationsForDay(_selectedDay);
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _reservations.length,
              itemBuilder: (context, index) {
                final reservation = _reservations[index];
                return ReservationTile(
                  number: reservation.number,
                  name: reservation.name,
                  dateRange: reservation.dateRange,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Reservation {
  final int number;
  final String name;
  final String dateRange;

  Reservation({required this.number, required this.name, this.dateRange = ''});
}

class ReservationTile extends StatelessWidget {
  final int number;
  final String name;
  final String dateRange;

  ReservationTile(
      {required this.number, required this.name, this.dateRange = ''});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.teal,
        child: Text(
          number.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
      title: Text(name),
      subtitle: dateRange.isNotEmpty ? Text(dateRange) : null,
      trailing: FaIcon(FontAwesomeIcons.fileAlt, color: Colors.teal),
    );
  }
}
