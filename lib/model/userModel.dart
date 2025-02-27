class UserModel {
  final String id;
  final String username;
  final String email;
  final String password;
  bool? isLoggedin;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    this.isLoggedin,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: data["id"],
      username: data["username"],
      email: data["email"],
      password: data["password"],
      isLoggedin: data["isLoggedin"],
    );
  }
}
