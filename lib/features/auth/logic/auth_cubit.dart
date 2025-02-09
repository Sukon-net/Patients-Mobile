import 'package:clients/features/auth/model/authed_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  void authenticateUser(AuthedUser authedUser) {
    emit(state.copyWith(
      status: AuthStatus.authenticated,
      authedUser: authedUser,
    ));
  }

  void logout() {
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }

  void continueAsGuest() {
    emit(const AuthState(status: AuthStatus.guest));
  }
}
