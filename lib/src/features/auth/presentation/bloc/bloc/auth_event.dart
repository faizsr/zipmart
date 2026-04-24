part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthLogin extends AuthEvent {
  final UserEntity user;

  AuthLogin(this.user);
}

class CheckAuthStatus extends AuthEvent {}

class AuthLogout extends AuthEvent {}
