part of 'complete_profile_cubit.dart';

sealed class CompleteProfileState extends Equatable {
  const CompleteProfileState();

  @override
  List<Object?> get props => [];
}

final class CompleteProfileInitial extends CompleteProfileState {}

final class CompleteProfileLoading extends CompleteProfileState {}

final class CompleteProfileSuccess extends CompleteProfileState {}

final class CompleteProfileError extends CompleteProfileState {
  final String? firstNameErrorMessage;
  final String? lastNameErrorMessage;
  final String? emailErrorMessage;
  final String? phoneErrorMessage;
  final String? errorMessage;

  const CompleteProfileError({
    this.firstNameErrorMessage,
    this.lastNameErrorMessage,
    this.emailErrorMessage,
    this.phoneErrorMessage,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        firstNameErrorMessage,
        lastNameErrorMessage,
        emailErrorMessage,
        phoneErrorMessage,
        errorMessage,
      ];
}

final class CompProfileButtonEnabled extends CompleteProfileState {}
