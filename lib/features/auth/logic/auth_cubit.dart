import 'package:clients/features/auth/data/repository/auth_repository.dart';
import 'package:clients/features/auth/model/authed_user/authed_user.dart';
import 'package:clients/features/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const AuthLoading()) {
    checkAuth();
  }

  User? get currentUser {
    if (state is Authenticated) {
      return (state as Authenticated).user;
    } else if (state is Guest) {
      return User.guest;
    } else {
      return null;
    }
  }

  void checkAuth() async {
    final isAuthenticated = await _authRepository.isAuthenticated();
    if (isAuthenticated) {
      final user = await _authRepository.getUser();
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(const Unauthenticated());
      }
    } else {
      emit(const Unauthenticated());
    }
  }

  void authenticateUser(AuthedUser authedUser) {
    _authRepository.storeUser(authedUser);
    emit(Authenticated(user: authedUser.user));
  }

  void logout() {
    _authRepository.logout();
    emit(const Unauthenticated());
  }

  void continueAsGuest() {
    emit(const Guest());
  }
}
