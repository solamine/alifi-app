import 'package:alifi_application/base%20de%20donne/user_model.dart';
import 'package:alifi_application/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alifi_application/authentication_repository.dart';

class SignUpController extends GetxController {
  final name = TextEditingController();
  final email = TextEditingController();
  final phoneNo = TextEditingController();
  final password = TextEditingController();

  final UserRepository userRepository = UserRepository();

  @override
  void onClose() {
    name.dispose();
    email.dispose();
    phoneNo.dispose();
    password.dispose();
    super.onClose();
  }

  void createUser() {
    final user = UserModel(
      name: name.text.trim(),
      email: email.text.trim(),
      phoneNo: phoneNo.text.trim(),
      password: password.text.trim(),
      Name: '',
    );

    userRepository.createUser(user);
  }
}

// Functions for user registration and authentication

void registerUser(String email, String password) async {
  try {
    // Call the authentication method
    await AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);
  } catch (error) {
    // Show error if any
    Get.showSnackbar(GetBar(message: error.toString()));
  }
}

void createUser(UserModel user) async {
  try {
    // Call the authentication method
    await AuthenticationRepository.instance.createUser(user);
  } catch (error) {
    // Show error if any
    Get.showSnackbar(GetBar(message: error.toString()));
  }
}

void phoneAuthentication(String phoneNo) async {
  try {
    // Call the authentication method
    await AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  } catch (error) {
    // Show error if any
    Get.showSnackbar(GetBar(message: error.toString()));
  }
}
