part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthStatus extends AuthState {
  final bool isLoggedIn;

  AuthStatus({required this.isLoggedIn});
}
