import 'contactus.dart';
import 'feedback.dart';
import 'helpcenter.dart';
import 'notification.dart';
import 'settings.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppointmentsScreen extends StatefulWidget {
  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Appointments',
          style: TextStyle(color: Colors.teal),
        ),
        actions: [
          IconButton(
            icon:
                FaIcon(FontAwesomeIcons.facebookMessenger, color: Colors.teal),
            onPressed: () {},
          ),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.bell, color: Colors.teal),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
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
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
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
            child: ListView(
              children: [
                AppointmentTile(
                  number: 1,
                  name: 'Max - Belghalem Sadim',
                  details: 'Dog - Vaccination - 09:00',
                ),
                AppointmentTile(
                  number: 2,
                  name: 'Anaïs - Halimi Belkis',
                  details: 'Cat - Operation - 09:30',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentTile extends StatelessWidget {
  final int number;
  final String name;
  final String details;

  AppointmentTile({
    required this.number,
    required this.name,
    required this.details,
  });

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
      subtitle: Text(details),
    );
  }
}
