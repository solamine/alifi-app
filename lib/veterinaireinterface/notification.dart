import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.teal),
        ),
        iconTheme: IconThemeData(color: Colors.teal),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('notifications').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var notifications = snapshot.data!.docs;
          return ListView(
            padding: EdgeInsets.all(8.0),
            children: notifications.map((notification) {
              var data = notification.data() as Map<String, dynamic>;
              return NotificationTile(
                notificationId: notification.id,
                title: data['title'] ?? '',
                subtitle: data['message'] ?? '',
                date: data['date'] ?? '',
                additionalInfo: data.containsKey('additionalInfo')
                    ? data['additionalInfo']
                    : '',
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String notificationId;
  final String title;
  final String subtitle;
  final String date;
  final String additionalInfo;

  NotificationTile({
    required this.notificationId,
    required this.title,
    required this.subtitle,
    required this.date,
    this.additionalInfo = '',
  });

  void _acceptNotification() {
    FirebaseFirestore.instance
        .collection('reservations')
        .doc(notificationId)
        .update({'status': 'accepted'}).then((_) {
      print("Notification accepted");
    }).catchError((error) {
      print("Failed to accept notification: $error");
    });
  }

  void _rejectNotification() {
    FirebaseFirestore.instance
        .collection('reservations')
        .doc(notificationId)
        .update({'status': 'rejected'}).then((_) {
      print("Notification rejected");
    }).catchError((error) {
      print("Failed to reject notification: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: FaIcon(FontAwesomeIcons.calendarAlt, color: Colors.teal),
        title: Text('$title\n$subtitle'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date),
            if (additionalInfo.isNotEmpty)
              Text(
                additionalInfo,
                style: TextStyle(color: Colors.blue),
              ),
            Row(
              children: [
                IconButton(
                  icon:
                      FaIcon(FontAwesomeIcons.checkCircle, color: Colors.green),
                  onPressed: _acceptNotification,
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.timesCircle, color: Colors.red),
                  onPressed: _rejectNotification,
                ),
              ],
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
