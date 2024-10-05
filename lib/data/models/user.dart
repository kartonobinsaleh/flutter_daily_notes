import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String password;
  final String? name;

  const User({
    this.username = "",
    this.password = "",
    this.name = "",
  });

  User copyWith({
    String? username,
    String? password,
    String? name,
  }) {
    return User(
      username: username ?? this.username,
      password: password ?? this.password,
      name: name ?? this.name,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [username, password, name];
}
