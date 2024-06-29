import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  late Map<String, dynamic> _userData;
  late List<Map<String, dynamic>> _animalsData = [];

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _getAnimals();
  }

  void _getCurrentUser() async {
    _user = _auth.currentUser;
    if (_user != null) {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('USERS').doc(_user!.uid).get();
      setState(() {
        _userData = (userSnapshot.data() as Map<String, dynamic>);
      });
    }
  }

  void _getAnimals() async {
    if (_user != null) {
      QuerySnapshot animalsSnapshot = await _firestore
          .collection('USERS')
          .doc(_user!.uid)
          .collection('animals')
          .get();
      setState(() {
        _animalsData = animalsSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ملفي الشخصي'),
      ),
      body: _user != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الاسم: ${_userData['name']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'البريد الإلكتروني: ${_userData['email']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'نوع المستخدم: ${_userData['userType']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'الحيوانات المرتبطة:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _animalsData.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_animalsData[index]['name']),
                          subtitle: Text(_animalsData[index]['type']),
                          // Add more fields as needed
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
