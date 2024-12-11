part of 'login_cubit.dart';

class LoginState extends Equatable {
  final bool isSuccess;
  final bool isLoading;
  final String errorMessage;
  final String emailError;
  final String email;

  const LoginState({
    this.isSuccess = false,
    this.isLoading = false,
    this.errorMessage = "",
    this.emailError = "",
    this.email = "",
});

  LoginState copyWith({
    bool? isSuccess,
    bool? isLoading,
    String? errorMessage,
    String? emailError,
    String? email,
  }) {
  return LoginState(
    isSuccess: isSuccess ?? this.isSuccess,
    isLoading: isLoading ?? this.isLoading,
    errorMessage: errorMessage ?? this.errorMessage,
    emailError: emailError ?? this.emailError,
    email: email ?? this.email,
  );
}

  @override
  List<Object> get props => [isSuccess, isLoading, errorMessage, emailError, email,];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState{}

final class LoginLoaded extends LoginState{}

final class LoginError extends LoginState{}