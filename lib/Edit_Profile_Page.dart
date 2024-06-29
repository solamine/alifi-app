import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String firstName;
  final String lastName;
  final String gender;
  final String bio;
  final String phoneNumber;
  final String profileImage;

  EditProfilePage({
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.bio,
    required this.phoneNumber,
    required this.profileImage,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController bioController;
  late TextEditingController phoneNumberController;
  late String gender;
  File? _image;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.firstName);
    lastNameController = TextEditingController(text: widget.lastName);
    bioController = TextEditingController(text: widget.bio);
    phoneNumberController = TextEditingController(text: widget.phoneNumber);
    gender = widget.gender;
    _image = File(widget.profileImage);
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _saveProfile() {
    final updatedProfile = {
      'name': '${firstNameController.text} ${lastNameController.text}',
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'gender': gender,
      'bio': bioController.text,
      'phoneNumber': phoneNumberController.text,
      'profileImage': _image?.path ?? widget.profileImage,
    };
    Navigator.pop(context, updatedProfile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier le profil'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: _image != null
                    ? FileImage(_image!)
                    : AssetImage(widget.profileImage) as ImageProvider,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.teal,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: _pickImage,
              child: Text(
                'Modifier la photo de profil',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(
                labelText: 'Prénom',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(
                labelText: 'Nom',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Numéro de téléphone',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: bioController,
              decoration: InputDecoration(
                labelText: 'Bio',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              child: Text('Enregistrer'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}
