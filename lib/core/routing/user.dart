class User {
  final int id;
  final String username;
  final String email;
  final String? password;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.password,
  });

  // Create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }

  // Convert a User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  // Optional: Copy with updated values
  User copyWith({
    int? id,
    String? username,
    String? email,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email)';
  }
}
