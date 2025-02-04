import 'package:clients/core/utils/validators.dart';
import 'package:clients/features/auth/login/data/repository/login_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/l10n/generated/locale_keys.g.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  late final TextEditingController emailController;
  final LoginRepository _loginRepository;

  LoginCubit(this._loginRepository) : super(LoginInitial()) {
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
      checkEmailSent();
    } else {
      emit(
        LoginError(
          emailError: LocaleKeys.invalid_email_format.tr(),
        ),
      );
    }
  }

  void checkEmailSent() {
    _loginRepository.sendEmail(emailController.text).then((result) {
      result.fold(
        (_) => emit(LoginSuccess()),
        (error) => emit(LoginError(errorMessage: error.message)),
      );
    });
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
