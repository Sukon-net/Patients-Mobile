import 'package:clients/core/utils/validators.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/l10n/generated/locale_keys.g.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  late final TextEditingController emailController;

  LoginCubit() : super(LoginInitial()) {
    emailController = TextEditingController();
    emailController.addListener(() {
      if (emailController.text.contains("@") &&
          emailController.text.contains(".")) {
        emit(LoginButtonEnabled());
      } else {
        emit(LoginInitial());
      }
    });
  }

  void onSendVerificationCodeClicked([String? email]) {
    emit(LoginLoading());
    if (Validators.isValidEmail(email ?? emailController.text)) {
      emit(LoginSuccess());
    } else {
      emit(
        LoginError(
          emailError: LocaleKeys.invalid_email_format.tr(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
