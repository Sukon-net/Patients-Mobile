part of 'otp_cubit.dart';

enum OtpStatus {
  initial,
  loading,
  success,
  error,
}

class OtpState extends Equatable {
  final OtpStatus status;
  final Duration countDownDuration;
  final String errorMessage;

  const OtpState({
    this.status = OtpStatus.initial,
    required this.countDownDuration,
    this.errorMessage = "",
  });

  @override
  List<Object?> get props => [status, countDownDuration, errorMessage];

  OtpState copyWith({
    OtpStatus? status,
    Duration? countDownDuration,
    String? errorMessage,
  }) {
    return OtpState(
      status: status ?? this.status,
      countDownDuration: countDownDuration ?? this.countDownDuration,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
