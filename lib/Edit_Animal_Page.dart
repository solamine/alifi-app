// edit_animal_page.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'animal.dart'; // Importez le fichier contenant la classe Animal

class EditAnimalPage extends StatefulWidget {
  final Animal? animal;

  EditAnimalPage({this.animal});

  @override
  _EditAnimalPageState createState() => _EditAnimalPageState();
}

class _EditAnimalPageState extends State<EditAnimalPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    if (widget.animal != null) {
      _nameController.text = widget.animal!.name;
      _typeController.text = widget.animal!.type;
      _genderController.text = widget.animal!.gender;
      _ageController.text = widget.animal!.age;
      _imagePath = widget.animal!.image;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _genderController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.animal == null ? 'Ajouter un Animal' : 'Modifier un Animal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _imagePath != null
                    ? FileImage(File(_imagePath!))
                    : AssetImage('images/default_animal.png') as ImageProvider,
                child: _imagePath == null
                    ? Icon(Icons.add_a_photo, size: 50)
                    : null,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: _typeController,
              decoration: InputDecoration(labelText: 'Type'),
            ),
            TextField(
              controller: _genderController,
              decoration: InputDecoration(labelText: 'Genre'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Âge'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedAnimal = Animal(
                  image: _imagePath ??
                      widget.animal?.image ??
                      'images/default_animal.png',
                  name: _nameController.text,
                  type: _typeController.text,
                  gender: _genderController.text,
                  age: _ageController.text,
                  id: '',
                );
                Navigator.pop(context, updatedAnimal);
              },
              child: Text(widget.animal == null ? 'Ajouter' : 'Modifier'),
            ),
          ],
        ),
      ),
    );
  }
}
