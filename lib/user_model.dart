class User {
  final String uid;
  final String name;
  final String email;
  final String userType;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.userType,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      userType: map['userType'] ?? '',
    );
  }
}
