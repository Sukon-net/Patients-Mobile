import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/l10n/generated/locale_keys.g.dart';
import '../../../../core/utils/validators.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  late final TextEditingController otpController;

  //final OtpRepository _otpRepository;

  OtpCubit() : super(OtpInitial()) {
    otpController = TextEditingController();
    otpController.addListener(() {
      if (otpController.text.length == 4) {
        emit(OtpButtonEnabled());
      } else {
        emit(OtpInitial());
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
    emit(OtpCounterDown());
  }

  @override
  Future<void> close() {
    otpController.dispose();
    return super.close();
  }
}
