part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthLogin extends AuthEvent {
  final User user;

  const AuthLogin(this.user);
}

class AuthSignup extends AuthEvent {
  final User user;
  final String passwordConfirm;

  const AuthSignup(this.user, this.passwordConfirm);
}

class AuthLogout extends AuthEvent {}
