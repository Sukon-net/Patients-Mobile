// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

enum AuthStatus {
  unauthenticated,
  authenticated,
  guest,
  error,
}

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.unauthenticated,
    this.authedUser,
    this.errorMessage,
  });

  final AuthStatus status;
  final AuthedUser? authedUser;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, authedUser, errorMessage];

  AuthState copyWith({
    AuthStatus? status,
    AuthedUser? authedUser,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      authedUser: authedUser ?? this.authedUser,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
