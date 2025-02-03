import 'package:clients/core/routing/routes.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_routing_extensions.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/widgets/primary_filled_button.dart';
import 'package:clients/features/auth/OTP/logic/otp_cubit.dart';
import 'package:clients/features/auth/widgets/top_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/l10n/generated/locale_keys.g.dart';

part '../widgets/otp_widget.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool isButtonActive = false;

  void onConfirmCodeSubmit(BuildContext context) {
    context.pushReplacementNamed(Routes.completeProfile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(),
      body: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          if (state.status == OtpStatus.success) {
            context.pushReplacementNamed(Routes.completeProfile);
          }
        },
        builder: (context, state) {
          if (state.status == OtpStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [
              SizedBox.expand(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          context.tr(LocaleKeys.verify_email),
                          style: TextStyles.size24Weight600.copyWith(
                            color: context.colors.primaryTextColor,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
                          child: Text(
                            context.tr(LocaleKeys.enter_the_verification_code),
                            style: TextStyles.size16Weight400.copyWith(
                              color: context.colors.accentTextColor,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        _OtpWidget(
                          onCompleted: (pin) {
                            context.read<OtpCubit>().verifyOtp(otp: pin);
                          },
                          onChanged: (pin) {
                            setState(() {
                              isButtonActive = pin.length == 4;
                            });
                          },
                          errorMessage: state.status == OtpStatus.error
                              ? context
                                  .tr(LocaleKeys.verification_code_is_wrong)
                              : null,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 24.h),
                          child: Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              text: context.tr(LocaleKeys
                                  .did_not_receive_the_verification_code),
                              style: TextStyles.size16Weight400.copyWith(
                                color: context.colors.accentTextColor,
                              ),
                              children: [
                                if (state.countDownDuration == Duration.zero)
                                  TextSpan(
                                    text: context.tr(LocaleKeys.resend),
                                    style: TextStyles.size16Weight400.copyWith(
                                      color: context.colors.primaryCTAColor,
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          context.colors.primaryCTAColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.read<OtpCubit>().resendOtp();
                                      },
                                  ),
                                if (state.countDownDuration != Duration.zero)
                                  TextSpan(
                                    text:
                                        "${state.countDownDuration.inMinutes.toString().padLeft(2, '0')}:${(state.countDownDuration.inSeconds % 60).toString().padLeft(2, '0')}",
                                    style: TextStyles.size16Weight500.copyWith(
                                      color: context.colors.primaryTextColor,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 24.w,
                left: 24.w,
                bottom: 24.h,
                child: PrimaryFilledButton(
                  text: context.tr(LocaleKeys.confirm_code),
                  isActive: isButtonActive,
                  onClick: () => onConfirmCodeSubmit(context),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
