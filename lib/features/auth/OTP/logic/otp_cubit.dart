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
    _otpRepository.resendOtp();
    emit(state.copyWith(countDownDuration: _defaultTimer));
    startTimer();
  }

  void verifyOtp({required String otp}) {
    _otpRepository.verifyOtp(otp: otp, email: email);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
