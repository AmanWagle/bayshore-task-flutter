class UserModel {
  final String email;
  final String password;
  final String? role;

  UserModel({required this.email, required this.password, this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '', // Initialize role from JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'role': role, // Include role when converting to JSON
    };
  }
}
