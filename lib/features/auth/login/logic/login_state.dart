part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginError extends LoginState {
  final String? emailError;
  final String? errorMessage;

  LoginError({this.emailError, this.errorMessage});

  @override
  List<Object?> get props => [emailError, errorMessage];
}

final class ButtonEnabled extends LoginState {}
