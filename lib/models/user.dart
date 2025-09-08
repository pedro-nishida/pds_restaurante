/// Represents a user in the system
class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final UserRole role;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.role,
  });

  // Convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role.toString().split('.').last,
    };
  }

  // Create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: UserRole.values.firstWhere(
        (e) => e.toString().split('.').last == json['role'],
        orElse: () => UserRole.employee,
      ),
    );
  }
}

enum UserRole {
  admin,
  manager,
  employee,
}
