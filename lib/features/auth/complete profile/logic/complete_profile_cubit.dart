import 'dart:developer';

import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/utils/validators.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit() : super(CompleteProfileInitial());
  bool isValidFirstName = false;
  bool isValidLastName = false;
  bool isValidEmail = false;

  bool get isButtonEnabled =>
      isValidFirstName && isValidLastName && isValidEmail;

  void validateFirstName(String name) {
    isValidFirstName = Validators.isValidName(name);
    log("First Name: $name / $isValidFirstName");
    emitValidationState();
  }

  void validateLastName(String name) {
    isValidLastName = Validators.isValidName(name);
    log("Last Name: $name / $isValidLastName");
    emitValidationState();
  }

  void validateEmail(String email) {
    isValidEmail = email.contains('@') && email.contains('.');
    log("Email: $email / $isValidEmail");
    emitValidationState();
  }

  void emitValidationState() {
    log("Emit Validation State: $isButtonEnabled");
    if (isButtonEnabled) {
      emit(CompProfileButtonEnabled());
    } else {
      emit(CompleteProfileInitial());
    }
  }

  void onCreateAccSubmit(String firstName, String lastName, String email) {
    if (Validators.isValidName(firstName) &&
        Validators.isValidName(lastName) &&
        Validators.isValidEmail(email)) {
      emit(CompleteProfileLoading());
      emit(CompleteProfileSuccess());
    } else {
      emit(
        CompleteProfileError(
          firstNameErrorMessage: !Validators.isValidName(firstName)
              ? LocaleKeys.invalid_name_format.tr()
              : null,
          lastNameErrorMessage: !Validators.isValidName(lastName)
              ? LocaleKeys.invalid_name_format.tr()
              : null,
          emailErrorMessage: !Validators.isValidEmail(email)
              ? LocaleKeys.invalid_email_format.tr()
              : null,
          //TODO handel phone validation
        ),
      );
    }
  }
}
