import 'package:clients/core/di/dependency_container.dart';
import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/routing/routes.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_routing_extensions.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/widgets/loading_widget.dart';
import 'package:clients/core/widgets/primary_filled_button.dart';
import 'package:clients/features/auth/complete%20profile/logic/complete_profile_cubit.dart';
import 'package:clients/features/auth/complete%20profile/model/complete_profile_request.dart';
import 'package:clients/features/auth/complete%20profile/widgets/gender_selector.dart';
import 'package:clients/features/auth/complete%20profile/widgets/phone_number.dart';
import 'package:clients/features/auth/widgets/auth_text_from_field.dart';
import 'package:clients/features/auth/widgets/top_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../../model/user.dart';
import '../../model/authed_user/logic/auth_cubit.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController =
      TextEditingController(text: sl<AuthCubit>().state.authedUser?.user.email);
  DateTime? dateOfBirth;
  final PhoneController phoneController = PhoneController(
      initialValue: const PhoneNumber(isoCode: IsoCode.EG, nsn: ''));
  Gender? gender;

  @override
  void initState() {
    super.initState();
    firstNameController.addListener(
      () {
        context
            .read<CompleteProfileCubit>()
            .validateFirstName(firstNameController.text);
      },
    );

    lastNameController.addListener(
      () {
        context
            .read<CompleteProfileCubit>()
            .validateLastName(lastNameController.text);
      },
    );

    emailController.addListener(
      () {
        context
            .read<CompleteProfileCubit>()
            .validateEmail(emailController.text);
      },
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompleteProfileCubit, CompleteProfileState>(
      listener: (context, state) {
        if (state is CompleteProfileSuccess) {
          context.pushReplacementNamed(Routes.home);
        }
      },
      child: Scaffold(
        appBar: const TopAppBar(),
        body: BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
          builder: (context, state) {
            if (state is CompleteProfileLoading) {
              return const LoadingWidget();
            }
            return Padding(
              padding: EdgeInsets.only(
                left: 24.w,
                right: 24.w,
                top: 16.h,
              ),
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr(LocaleKeys.complete_your_data),
                        style: TextStyles.size24Weight600.copyWith(
                          color: context.colors.primaryTextColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
                        child: Text(
                          context.tr(LocaleKeys.one_simple_step_separates_you),
                          style: TextStyles.size16Weight400.copyWith(
                            color: context.colors.subTextColor,
                          ),
                        ),
                      ),
                      AuthTextFromField(
                        label: context.tr(LocaleKeys.first_name),
                        hint: context.tr(LocaleKeys.required),
                        controller: firstNameController,
                        errorText: state is CompleteProfileError
                            ? state.firstNameErrorMessage
                            : null,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: AuthTextFromField(
                          label: context.tr(LocaleKeys.last_name),
                          hint: context.tr(LocaleKeys.required),
                          controller: lastNameController,
                          errorText: state is CompleteProfileError
                              ? state.lastNameErrorMessage
                              : null,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.5.h),
                        child: Text(
                          context.tr(LocaleKeys.gender),
                          style: TextStyles.size16Weight500.copyWith(
                            color: context.colors.primaryTextColor,
                          ),
                        ),
                      ),
                      GenderSelector(
                        onGenderSelectionChange: (gender) {
                          setState(() {
                            this.gender = gender;
                          });
                        },
                        currentSelection: gender,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: GestureDetector(
                          onTap: _showTimePicker,
                          child: AuthTextFromField(
                            label: context.tr(LocaleKeys.date_of_birth),
                            hint: context.tr(LocaleKeys.date_of_birth_hint),
                            enabled: false,
                            initialValue: dateOfBirth != null
                                ? DateFormat('dd/MM/yyyy').format(dateOfBirth!)
                                : null,
                          ),
                        ),
                      ),
                      PhoneNumberFormField(
                        controller: phoneController,
                        label: context.tr(LocaleKeys.phone_number),
                        hint: '(000)-000-00000',
                        errorText: state is CompleteProfileError
                            ? state.phoneErrorMessage
                            : null,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.h, bottom: 41.h),
                        child: AuthTextFromField(
                          label: context.tr(LocaleKeys.email),
                          hint: 'example@example.com',
                          controller: emailController,
                          enabled: false,
                          keyboardType: TextInputType.emailAddress,
                          showDisabledState: true,
                          errorText: state is CompleteProfileError
                              ? state.emailErrorMessage
                              : null,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: PrimaryFilledButton(
                          text: context.tr(LocaleKeys.create_account),
                          onClick: () {
                            context
                                .read<CompleteProfileCubit>()
                                .onCreateAccSubmit(
                                  CompleteProfileRequest(
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    email: emailController.text,
                                    phoneNumber:
                                        phoneController.value.toString(),
                                    dateOfBirth: dateOfBirth,
                                    gender: gender,
                                  ),
                                );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showTimePicker() async {
    final dataFormatter = DateFormat('dd/MM/yyyy');
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 100, now.month, now.day);
    final lastDate = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        dateOfBirth = pickedDate;
      });
    }
  }
}
