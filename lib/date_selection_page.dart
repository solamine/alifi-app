import 'package:flutter/material.dart';
import 'vet.dart';

class Animal {
  final String name;
  final String photoUrl;

  Animal({required this.name, required this.photoUrl});
}

class DateSelectionPage extends StatefulWidget {
  final Vet veterinarian;

  const DateSelectionPage({super.key, required this.veterinarian});

  @override
  _DateSelectionPageState createState() => _DateSelectionPageState();
}

class _DateSelectionPageState extends State<DateSelectionPage> {
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  int durationHours = 0;
  int durationDays = 0;
  int durationWeeks = 0;
  Animal? selectedAnimal;

  List<Animal> animals = [
    Animal(name: 'Cat', photoUrl: 'assets/cat.jpg'),
    Animal(name: 'Dog', photoUrl: 'assets/dog.jpg'),
  ];

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sélectionner la date'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Réserver avec ${widget.veterinarian.name} ${widget.veterinarian.firstName}'),
            Text('Téléphone: ${widget.veterinarian.phoneNumber}'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Temps'),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => _selectTime(context),
                    ),
                    Text('${selectedTime.format(context)}'),
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        // يمكن إضافة وظيفة لتقليل الوقت هنا
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date'),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => _selectDate(context),
                    ),
                    Text(
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        // يمكن إضافة وظيفة لتقليل التاريخ هنا
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Durée'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Heures'),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              durationHours++;
                            });
                          },
                        ),
                        Text('$durationHours'),
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (durationHours > 0) durationHours--;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Jours'),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              durationDays++;
                            });
                          },
                        ),
                        Text('$durationDays'),
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (durationDays > 0) durationDays--;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Semaines'),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              durationWeeks++;
                            });
                          },
                        ),
                        Text('$durationWeeks'),
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (durationWeeks > 0) durationWeeks--;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Animal'),
            DropdownButton<Animal>(
              value: selectedAnimal,
              hint: Text('Sélectionnez un animal'),
              onChanged: (Animal? newValue) {
                setState(() {
                  selectedAnimal = newValue;
                });
              },
              items: animals.map((Animal animal) {
                return DropdownMenuItem<Animal>(
                  value: animal,
                  child: Text(animal.name),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Logique pour réserver ici
              },
              child: Text('Réserver'),
            ),
          ],
        ),
      ),
    );
  }
}
