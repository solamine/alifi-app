class UserModel {

final String? id;
final String email; 
final String phoneNo;
final String password;
const UserModel({ this.id,  required this.email, required this.phoneNo, required this.password, });

Map<String, dynamic> userss() {

return {
"email": email,
"password": password,
"phoneno": phoneNo,
};
}
}