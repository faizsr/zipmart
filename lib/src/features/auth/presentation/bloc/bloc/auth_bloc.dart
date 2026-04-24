import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zipmart/src/features/auth/domain/entities/user_entity.dart';
import 'package:zipmart/src/features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'package:zipmart/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:zipmart/src/features/auth/domain/usecases/logout_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  final CheckAuthStatusUsecase checkAuthStatusUsecase;

  AuthBloc({
    required this.loginUsecase,
    required this.logoutUsecase,
    required this.checkAuthStatusUsecase,
  }) : super(AuthInitial()) {
    on<AuthLogin>(_onAuthLogin);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<AuthLogout>(_onAuthLogout);
  }

  FutureOr<void> _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await loginUsecase.call(event.user);
    emit(AuthStatus(isLoggedIn: true));
  }

  FutureOr<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    bool isLoggedIn = await checkAuthStatusUsecase.call();
    // forced waiting to display splash page
    await Future.delayed(Duration(milliseconds: 2500));
    emit(AuthStatus(isLoggedIn: isLoggedIn));
  }

  FutureOr<void> _onAuthLogout(
    AuthLogout event,
    Emitter<AuthState> emit,
  ) async {
    await logoutUsecase.call();
    emit(AuthStatus(isLoggedIn: false));
  }
}
