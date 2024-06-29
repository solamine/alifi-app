import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_animal_page.dart';
import 'animal.dart';

class MyAnimalsPage extends StatefulWidget {
  @override
  _MyAnimalsPageState createState() => _MyAnimalsPageState();
}

class _MyAnimalsPageState extends State<MyAnimalsPage> {
  List<Animal> animals = []; // قائمة الحيوانات تبدأ فارغة

  CollectionReference animalsCollection =
      FirebaseFirestore.instance.collection('animals');

  // استرداد الحيوانات من Firestore
  void getAnimalsFromFirestore() {
    animalsCollection.get().then((querySnapshot) {
      setState(() {
        animals =
            querySnapshot.docs.map((doc) => Animal.fromFirestore(doc)).toList();
      });
    }).catchError((error) {
      print("Failed to get animals: $error");
    });
  }

  @override
  void initState() {
    super.initState();
    getAnimalsFromFirestore(); // تحميل الحيوانات عند تهيئة الصفحة
  }

  Future<void> addAnimalToFirestore(Animal animal) {
    return animalsCollection
        .add({
          'image': animal.image,
          'name': animal.name,
          'type': animal.type,
          'gender': animal.gender,
          'age': animal.age,
        })
        .then((value) => print("Animal Added"))
        .catchError((error) => print("Failed to add animal: $error"));
  }

  void _editAnimal(int index) async {
    final updatedAnimal = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditAnimalPage(animal: animals[index]),
      ),
    );
    if (updatedAnimal != null) {
      setState(() {
        animals[index] = updatedAnimal;
        // تحديث الحيوان في Firestore هنا إذا لزم الأمر
      });
    }
  }

  void _addAnimal() async {
    final newAnimal = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditAnimalPage(),
      ),
    );
    if (newAnimal != null) {
      setState(() {
        animals.add(newAnimal);
      });
      addAnimalToFirestore(newAnimal); // إضافة الحيوان الجديد إلى Firestore
    }
  }

  void _deleteAnimal(int index) {
    String animalId = animals[index].id; // استخراج معرف الحيوان
    animalsCollection.doc(animalId).delete().then((_) {
      setState(() {
        animals.removeAt(index);
      });
      print("Animal deleted successfully");
    }).catchError((error) {
      print("Failed to delete animal: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VOTRE ANIMAL', style: TextStyle(color: Colors.teal)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Recherche',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: animals.map((animal) {
                  int index =
                      animals.indexOf(animal); // حصول على الفهرس للحيوان
                  return Dismissible(
                    key: Key(animal
                        .id), // مفتاح لضمان الاستدعاء الصحيح للعنصر المحذوف
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      _deleteAnimal(index); // حذف الحيوان عند التحريك لليمين
                    },
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: animal.image.startsWith('images/')
                              ? AssetImage(animal.image)
                              : FileImage(File(animal.image)) as ImageProvider,
                          radius: 30,
                        ),
                        title: Text(animal.name),
                        subtitle: Text(
                            '${animal.type} - ${animal.gender} - ${animal.age}'),
                        trailing: IconButton(
                          icon: Icon(Icons.edit, color: Colors.teal),
                          onPressed: () => _editAnimal(index),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAnimal,
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 50), // إضافة مساحة لتنسيق الزر
          ],
        ),
      ),
    );
  }
}
