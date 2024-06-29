import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الحجوزات'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('reservations').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var reservations = snapshot.data!.docs;
          return ListView.builder(
            itemCount: reservations.length,
            itemBuilder: (context, index) {
              var reservation = reservations[index];
              var data = reservation.data() as Map<String, dynamic>;
              return ReservationTile(
                reservationId: reservation.id,
                selectedDate: DateTime.parse(data['selectedDate']),
                selectedTime: TimeOfDay.fromDateTime(
                    DateTime.parse(data['selectedTime'])),
                status: data['status'],
                veterinarian: data['veterinarian'],
              );
            },
          );
        },
      ),
    );
  }
}

class ReservationTile extends StatelessWidget {
  final String reservationId;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final String status;
  final String veterinarian; // Assuming you have a field for veterinarian name

  ReservationTile({
    required this.reservationId,
    required this.selectedDate,
    required this.selectedTime,
    required this.status,
    required this.veterinarian,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text('تاريخ الحجز: ${selectedDate.toString().split(' ')[0]}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الوقت: ${selectedTime.format(context)}'),
            Text('حالة الحجز: $status'),
            Text('البيطري: $veterinarian'),
          ],
        ),
      ),
    );
  }
}
