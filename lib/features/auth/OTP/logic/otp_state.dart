part of 'otp_cubit.dart';

sealed class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object?> get props => [];
}

final class OtpInitial extends OtpState {}

final class OtpLoading extends OtpState {}

final class OtpSuccess extends OtpState {}

final class OtpError extends OtpState {
  final String? otpError;
  final String? errorMessage;

  const OtpError({this.otpError, this.errorMessage});

  @override
  List<Object?> get props => [otpError, errorMessage];
}

final class OtpButtonEnabled extends OtpState {}

final class OtpResendEnabled extends OtpState {}

final class OtpCounterDown extends OtpState {}
