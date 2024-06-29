import 'package:flutter/material.dart';

class Veterinarian {
  final String name;
  final String firstName;
  final String phoneNumber;

  Veterinarian({
    required this.name,
    required this.firstName,
    required this.phoneNumber,
  });
}

class AppointmentBookingPage extends StatelessWidget {
  final Veterinarian veterinarian;

  const AppointmentBookingPage({super.key, required this.veterinarian});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prendre Rendez-vous'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Prendre rendez-vous avec ${veterinarian.name} ${veterinarian.firstName}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('Téléphone: ${veterinarian.phoneNumber}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 32),
            // Ajoutez ici les champs nécessaires pour prendre un rendez-vous
            const TextField(
              decoration: InputDecoration(
                labelText: 'Date',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Heure',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Logic pour confirmer la prise de rendez-vous
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Rendez-vous pris avec succès!')),
                );
              },
              child: const Text('Confirmer le Rendez-vous'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AppointmentBookingPage(
      veterinarian: Veterinarian(
        name: "Doe",
        firstName: "John",
        phoneNumber: "123456789",
      ),
    ),
  ));
}
