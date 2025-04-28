// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class Authenticated extends AuthState {
  final User user;
  bool get hasCompletedSignup => user.hasCompletedSignup;

  const Authenticated({required this.user});

  @override
  List<Object?> get props => [user, hasCompletedSignup];
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class Guest extends AuthState {
  const Guest();
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
