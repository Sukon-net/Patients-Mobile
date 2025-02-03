import 'dart:async';

import 'package:clients/features/auth/OTP/data/repository/otp_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/l10n/generated/locale_keys.g.dart';
import '../../../../core/utils/validators.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  static const int initialCountdown = 60; // 1 minute countdown
  late Timer _timer;
  int _counter = initialCountdown;

  late final TextEditingController otpController;
  final OtpRepository _otpRepository;
  final String emailAddress;

  OtpCubit(this._otpRepository, this.emailAddress) : super(OtpInitial()) {
    otpController = TextEditingController();
    otpController.addListener(() {
      if (otpController.text.length == 4) {
        emit(OtpButtonEnabled());
      } else {
        emit(OtpInitial());
      }
    });
  }

  void startCountdown() {
    emit(OtpCounterDown(_counter));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        _counter--;
        emit(OtpCounterDown(_counter));
      } else {
        _timer.cancel();
        emit(OtpCounterFinished());
      }
    });
  }

  void onConfirmCodeSubmit(int otpCode) {
    emit(OtpLoading());
    if (Validators.isValidOtp(int.parse(otpController.text))) {
      emit(OtpSuccess());
    } else {
      emit(
        OtpError(
          otpError: LocaleKeys.verification_code_is_wrong.tr(),
        ),
      );
    }
  }

  void onResendOtpClicked() {
    _timer.cancel(); // Stop any running timer
    _counter = initialCountdown;
    startCountdown();
  }

  @override
  Future<void> close() {
    _timer.cancel();
    otpController.dispose();
    return super.close();
  }
}
