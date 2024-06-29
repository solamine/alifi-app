import 'package:alifi_application/base%20de%20donne/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    try {
      await _firestore.collection('users').add(user.toUsers());
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  signInWithEmailAndPassword(String text, String text2) {}
}
