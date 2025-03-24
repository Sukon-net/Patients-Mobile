import 'dart:developer';

import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/utils/validators.dart';
import 'package:clients/features/auth/complete%20profile/data/repository/complete_profile_repository.dart';
import 'package:clients/features/auth/complete%20profile/model/complete_profile_request.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_container.dart';
import '../../model/authed_user/logic/auth_cubit.dart';

part 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  final CompleteProfileRepository _repository;
  final AuthCubit _authCubit = sl();

  CompleteProfileCubit(this._repository) : super(CompleteProfileInitial());
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

  void onCreateAccSubmit(CompleteProfileRequest compProfileReq) async {
    emit(CompleteProfileLoading());
    if (Validators.isValidName(compProfileReq.firstName) &&
        Validators.isValidName(compProfileReq.lastName) &&
        Validators.isValidEmail(compProfileReq.email) &&
        compProfileReq.gender != null &&
        compProfileReq.dateOfBirth != null) {
      checkDataSent(compProfileReq);
    } else {
      emit(
        CompleteProfileError(
          firstNameErrorMessage:
              !Validators.isValidName(compProfileReq.firstName)
                  ? LocaleKeys.invalid_name_format.tr()
                  : null,
          lastNameErrorMessage: !Validators.isValidName(compProfileReq.lastName)
              ? LocaleKeys.invalid_name_format.tr()
              : null,
          emailErrorMessage: !Validators.isValidEmail(compProfileReq.email)
              ? LocaleKeys.invalid_email_format.tr()
              : null,
        ),
      );
    }
  }

  void checkDataSent(CompleteProfileRequest compProfileReq) {
    _repository
        .completeUserProfile(compProfileReq: compProfileReq)
        .then((result) {
      result.fold(
        (authedUser) {
          _authCubit.authenticateUser(authedUser);
          emit(CompleteProfileSuccess());
        },
        (error) => emit(CompleteProfileError(errorMessage: error.message)),
      );
    });
  }
}
