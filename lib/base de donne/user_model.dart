class UserModel {
  final String? id;
  final String Name;
  final String email;
  final String phoneNo;
  final String password;

  const UserModel({
    this.id,
    required this.Name,
    required this.email,
    required this.phoneNo,
    required this.password,
    required name,
  });
  toUsers() {
    return {
      "fullname": Name,
      "email": email,
      "password": password,
      "phoneno": phoneNo,
    };
  }
}
