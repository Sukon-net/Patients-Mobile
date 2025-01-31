import 'dart:async';

import 'package:clients/core/routing/routes.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_routing_extensions.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/widgets/loading_widget.dart';
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
  bool isCounterDownAvailable = false;
  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();

  int _counter = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    setState(() {
      isCounterDownAvailable = true;
      _counter = 60;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        _timer.cancel();
        setState(() {
          isCounterDownAvailable = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(),
      body: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          if (state is OtpSuccess) {
            context.pushReplacementNamed(Routes.completeProfile);
          }
        },
        builder: (context, state) {
          if (state is OtpLoading) {
            return const LoadingWidget();
          }
          if (state is OtpCounterDown) {
            isCounterDownAvailable = true;
          }
          return Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
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
                        const _OtpWidget(),
                        Padding(
                          padding: EdgeInsets.only(top: 24.h),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: context.tr(LocaleKeys
                                  .did_not_receive_the_verification_code),
                              style: TextStyles.size16Weight400.copyWith(
                                color: context.colors.accentTextColor,
                              ),
                              children: [
                                !isCounterDownAvailable
                                    ? TextSpan(
                                        text: context.tr(LocaleKeys.resend),
                                        style:
                                            TextStyles.size16Weight400.copyWith(
                                          color: context.colors.primaryCTAColor,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              context.colors.primaryCTAColor,
                                        ),
                                        recognizer: _tapGestureRecognizer
                                          ..onTap = () {
                                            setState(() {
                                              _counter = 60;
                                              isCounterDownAvailable = true;
                                            });
                                            startCountdown();
                                            context
                                                .read<OtpCubit>()
                                                .onResendOtpClicked();
                                          },
                                      )
                                    : TextSpan(
                                        text:
                                            '${(_counter ~/ 60).toString().padLeft(2, '0')}:${(_counter % 60).toString().padLeft(2, '0')}',
                                        style:
                                            TextStyles.size16Weight500.copyWith(
                                          color:
                                              context.colors.primaryTextColor,
                                        ),
                                      )
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
                  isActive: state is OtpButtonEnabled,
                  onClick: () {
                    context.read<OtpCubit>().onConfirmCodeSubmit(
                          int.parse(
                              context.read<OtpCubit>().otpController.text),
                        );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
