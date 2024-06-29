import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static var instance;

  // تسجيل الدخول بالبريد الإلكتروني وكلمة المرور
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // التسجيل بالبريد الإلكتروني وكلمة المرور
  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // تسجيل الخروج
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  static createUserWithEmailAndPassword(String email, String password) {}
}
