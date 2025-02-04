import 'dart:async';

import 'package:clients/core/utils/extensions/num_duration_extensions.dart';
import 'package:clients/features/auth/OTP/data/repository/otp_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final OtpRepository _otpRepository;
  final String email;

  OtpCubit(this._otpRepository, this.email)
      : super(const OtpState(countDownDuration: _defaultTimer));

  static const _defaultTimer = Duration(minutes: 2);

  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(1.seconds, (timer) {
      if (state.countDownDuration == Duration.zero) {
        stopTimer();
        return;
      }
      emit(state.copyWith(
        countDownDuration: state.countDownDuration - 1.seconds,
      ));
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void resendOtp() {
    emit(state.copyWith(status: OtpStatus.loading));
    _otpRepository.resendOtp(email);
    emit(state.copyWith(
        status: OtpStatus.initial, countDownDuration: _defaultTimer));
    startTimer();
  }

  void verifyOtp({required String otp}) {
    emit(state.copyWith(status: OtpStatus.loading));
    _otpRepository
        .verifyOtp(otp: int.parse(otp.trim()), email: email)
        .then((result) {
      result.fold(
        (_) => emit(state.copyWith(status: OtpStatus.success)),
        (error) => emit(
          state.copyWith(
            status: OtpStatus.error,
            errorMessage: error.message,
          ),
        ),
      );
    });
  }

  void onConfirmCodeSubmit({required String otp}) {
    verifyOtp(otp: otp);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
