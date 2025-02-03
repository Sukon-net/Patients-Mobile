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

  const OtpState({
    this.status = OtpStatus.initial,
    required this.countDownDuration,
  });

  @override
  List<Object?> get props => [status, countDownDuration];

  OtpState copyWith({
    OtpStatus? status,
    Duration? countDownDuration,
  }) {
    return OtpState(
      status: status ?? this.status,
      countDownDuration: countDownDuration ?? this.countDownDuration,
    );
  }
}
