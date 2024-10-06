import 'package:equatable/equatable.dart';
import 'package:flutter_todo_list/models/user.dart';
import 'package:flutter_todo_list/extensions/list.dart';
import 'package:flutter_todo_list/helper/password.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<AuthLogin>(_onLogin);
    on<AuthSignup>(_onSignup);
    on<AuthLogout>(_onLogout);
  }

  void _onLogin(AuthLogin event, Emitter<AuthState> emit) {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      if (event.user.username.isEmpty) throw "Username Tidak Boleh Kosong";
      if (event.user.password.isEmpty) throw "Password Tidak Boleh Kosong";

      final isExisting = state.users.firstWhereOrNull((e) => e.username == event.user.username);
      if (isExisting == null) throw "Username Tidak Terdaftar";

      final passwordHashed = PasswordHelper.hash(event.user.password);

      if (isExisting.password != passwordHashed) throw "Password Salah";

      emit(state.copyWith(
        status: AuthStatus.success,
        user: event.user,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        message: e.toString(),
      ));
      rethrow;
    }
  }

  void _onSignup(AuthSignup event, Emitter<AuthState> emit) {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final isExisting = state.users.any((e) => e.username == event.user.username);
      if (isExisting) throw "Username Sudah Terdaftar";

      List<User> temp = List.from(state.users);

      if (event.user.username.isEmpty) throw "Username Tidak Boleh Kosong";
      if (event.user.password.isEmpty) throw "Password Tidak Boleh Kosong";
      if (event.passwordConfirm.isEmpty) throw "Password Confirm Tidak Boleh Kosong";
      if (event.user.password != event.passwordConfirm) throw "Password Tidak Cocok";

      final passwordHashed = PasswordHelper.hash(event.user.password);
      temp.add(event.user.copyWith(password: passwordHashed));

      emit(state.copyWith(
        status: AuthStatus.success,
        users: temp,
        message: "Berhasil Daftar",
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        message: e.toString(),
      ));
      rethrow;
    }
  }

  void _onLogout(AuthLogout event, Emitter<AuthState> emit) {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      return emit(state.copyWith(
        status: AuthStatus.success,
        user: const User(),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        message: e.toString(),
      ));
      rethrow;
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toJson();
  }
}
