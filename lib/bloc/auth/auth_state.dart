part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, error }

class AuthState extends Equatable {
  final List<User> users;
  final User user;
  final AuthStatus status;
  final String message;

  const AuthState({
    this.users = const <User>[],
    this.user = const User(),
    this.status = AuthStatus.initial,
    this.message = "",
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    List<User>? users,
    String? message,
  }) {
    return AuthState(
      users: users ?? this.users,
      user: user ?? this.user,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  factory AuthState.fromJson(Map<String, dynamic> json) {
    try {
      var listOfUsers = (json['users'] as List<dynamic>)
          .map(
            (e) => User.fromJson(e as Map<String, dynamic>),
          )
          .toList();

      var user = User.fromJson(json["user"]);

      return AuthState(
        users: listOfUsers,
        user: user,
        status: AuthStatus.values.firstWhere(
          (element) => element.name.toString() == json['status'],
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'users': users,
      'user': user,
      'status': status.name,
    };
  }

  @override
  List<Object?> get props => [users, user, status, message];
}
