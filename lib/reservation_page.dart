import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart' as badges; // Alias for badges package

class ReservationScreen extends StatefulWidget {
  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  List<Reservation> _reservations = [];
  Map<DateTime, List<Reservation>> _reservationsByDate = {};
  int newNotificationCount = 3; // Initial notification count
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser != null) {
      _loadReservations();
    }
  }

  Future<void> _loadReservations() async {
    if (_currentUser == null) return;

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('reservation')
          .where('Id_veterinaire', isEqualTo: _currentUser!.uid)
          .get();

      List<Reservation> reservations = [];
      Map<DateTime, List<Reservation>> reservationsByDate = {};

      for (var doc in snapshot.docs) {
        var userDoc = await FirebaseFirestore.instance.collection('users').doc(doc['Id_user']).get();
        Reservation reservation = Reservation(
          id: doc.id,
          name: userDoc['name'],
          userId: doc['Id_user'],
          date: (doc['date'] as Timestamp).toDate(),
        );
        reservations.add(reservation);

        DateTime reservationDate = DateTime(reservation.date.year, reservation.date.month, reservation.date.day);
        if (reservationsByDate[reservationDate] == null) {
          reservationsByDate[reservationDate] = [];
        }
        reservationsByDate[reservationDate]!.add(reservation);
      }

      setState(() {
        _reservations = reservations;
        _reservationsByDate = reservationsByDate;
      });
    } catch (e) {
      print('Error loading reservations: $e');
      if (e is FirebaseException && e.code == 'permission-denied') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Erreur de permissions'),
            content: Text('Vous n\'avez pas les permissions nécessaires pour accéder aux réservations.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  void _deleteReservation(String reservationId) async {
    try {
      await FirebaseFirestore.instance.collection('reservation').doc(reservationId).delete();
      setState(() {
        _reservations.removeWhere((reservation) => reservation.id == reservationId);
        _loadReservations(); // Reload reservations to update the calendar view
      });
      print('Réservation supprimée avec succès');
    } catch (e) {
      print('Error deleting reservation: $e');
    }
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
            icon: FaIcon(FontAwesomeIcons.facebookMessenger, color: Colors.teal),
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
                setState(() {
                  newNotificationCount = 0; // Reset the notification count
                });
                // Navigate to notification screen (implement NotificationScreen if needed)
              },
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.teal),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            eventLoader: (day) {
              return _reservationsByDate[day] ?? [];
            },
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
              markerDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                if (_reservationsByDate[day] != null && _reservationsByDate[day]!.isNotEmpty) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        day.day.toString(),
                      ),
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              _reservationsByDate[day]!.length.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Text(day.day.toString());
                }
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _reservations.length,
              itemBuilder: (context, index) {
                final reservation = _reservations[index];
                return ReservationTile(
                  reservation: reservation,
                  onDelete: () => _deleteReservation(reservation.id),
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
  final String id;
  final String name;
  final String userId;
  final DateTime date;

  Reservation({
    required this.id,
    required this.name,
    required this.userId,
    required this.date,
  });
}

class ReservationTile extends StatelessWidget {
  final Reservation reservation;
  final VoidCallback onDelete;

  ReservationTile({
    required this.reservation,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.teal,
        child: Text(
          reservation.name[0],
          style: TextStyle(color: Colors.white),
        ),
      ),
      title: Text(reservation.name),
      subtitle: Text('Date: ${DateFormat('dd MMM yyyy, HH:mm').format(reservation.date)}'),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: onDelete,
      ),
    );
  }
}
