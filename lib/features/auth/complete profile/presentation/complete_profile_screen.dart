import 'package:clients/core/constants/assets.dart';
import 'package:clients/core/di/dependency_container.dart';
import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/routing/routes.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_routing_extensions.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/utils/validators.dart';
import 'package:clients/core/widgets/loading_widget.dart';
import 'package:clients/core/widgets/primary_filled_button.dart';
import 'package:clients/core/widgets/top_app_bar.dart';
import 'package:clients/features/auth/complete%20profile/data/model/complete_profile_request.dart';
import 'package:clients/features/auth/complete%20profile/logic/complete_profile_cubit.dart';
import 'package:clients/features/auth/complete%20profile/presentation/widgets/gender_selector.dart';
import 'package:clients/features/auth/complete%20profile/presentation/widgets/phone_number.dart';
import 'package:clients/features/auth/widgets/auth_text_from_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../../model/user.dart';
import '../../logic/auth_cubit.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController =
      TextEditingController(text: sl<AuthCubit>().currentUser?.email);
  final TextEditingController dateOfBirthController = TextEditingController();
  DateTime? dateOfBirth;
  final PhoneController phoneController = PhoneController(
      initialValue: const PhoneNumber(isoCode: IsoCode.EG, nsn: ''));
  Gender? gender;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    dateOfBirthController.dispose();
    _formKey.currentState?.dispose();
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
        appBar: TopAppBar(
          widget: SvgPicture.asset(Assets.assetsSvgLogoBlue),
        ),
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
                key: _formKey,
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
                        validator: (value) {
                          if (!Validators.isValidName(value ?? '')) {
                            return context.tr(LocaleKeys.invalid_name_format);
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: AuthTextFromField(
                          label: context.tr(LocaleKeys.last_name),
                          hint: context.tr(LocaleKeys.required),
                          controller: lastNameController,
                          validator: (value) {
                            if (!Validators.isValidName(value ?? '')) {
                              return context.tr(LocaleKeys.invalid_name_format);
                            }
                            return null;
                          },
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
                        validator: (value) {
                          if (value == null) {
                            return context.tr(LocaleKeys.required);
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: GestureDetector(
                          onTap: _showTimePicker,
                          child: AuthTextFromField(
                            controller: dateOfBirthController,
                            label: context.tr(LocaleKeys.date_of_birth),
                            hint: context.tr(LocaleKeys.date_of_birth_hint),
                            enabled: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return context.tr(LocaleKeys.required);
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      PhoneNumberFormField(
                        controller: phoneController,
                        label: context.tr(LocaleKeys.phone_number),
                        hint: '(000)-000-00000',
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
                          validator: (value) {
                            if (!Validators.isValidEmail(value ?? '')) {
                              return context
                                  .tr(LocaleKeys.invalid_email_format);
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: PrimaryFilledButton(
                          borderRadius: 100.r,
                          text: context.tr(LocaleKeys.create_account),
                          onClick: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context
                                  .read<CompleteProfileCubit>()
                                  .onCreateAccSubmit(
                                    CompleteProfileRequest(
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      email: emailController.text,
                                      phoneNumber:
                                          phoneController.value.international,
                                      dateOfBirth: dateOfBirth,
                                      gender: gender,
                                    ),
                                  );
                            }
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
        dateOfBirthController.text =
            DateFormat('dd/MM/yyyy').format(dateOfBirth!);
      });
    }
  }
}
