import 'package:cloud_firestore/cloud_firestore.dart';

class Animal {
  String id; // إضافة الحقل id هنا
  String image;
  String name;
  String type;
  String gender;
  String age;

  Animal({
    required this.id, // تحديد معرف كمعامل مطلوب
    required this.image,
    required this.name,
    required this.type,
    required this.gender,
    required this.age,
  });

  // تحويل بيانات Firestore إلى كائن Animal
  factory Animal.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    return Animal(
      id: doc.id, // استخدام معرف الوثيقة كمعرف للحيوان
      image: data?['image'] ?? '',
      name: data?['name'] ?? '',
      type: data?['type'] ?? '',
      gender: data?['gender'] ?? '',
      age: data?['age'] ?? '',
    );
  }
}
