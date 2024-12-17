part of 'otp_cubit.dart';

sealed class OtpState extends Equatable {
  const OtpState();
}

final class OtpInitial extends OtpState {
  @override
  List<Object> get props => [];
}
