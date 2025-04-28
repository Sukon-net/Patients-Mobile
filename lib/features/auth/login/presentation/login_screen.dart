import 'package:clients/core/routing/routes.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_routing_extensions.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/utils/toastifications.dart';
import 'package:clients/core/widgets/loading_widget.dart';
import 'package:clients/core/widgets/or_divider.dart';
import 'package:clients/core/widgets/primary_filled_button.dart';
import 'package:clients/core/widgets/social_media_button.dart';
import 'package:clients/core/widgets/top_app_bar.dart';
import 'package:clients/features/auth/login/logic/login_cubit.dart';
import 'package:clients/features/auth/widgets/auth_text_from_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/l10n/generated/locale_keys.g.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardVisible = bottomInsets > 100;
    final backgroundColor = context.colors.errorAccentColor;
    final textColor = context.colors.primaryTextColor;
    final borderColor = context.colors.errorColor;

    return Scaffold(
      appBar: TopAppBar(
        widget: SvgPicture.asset(Assets.assetsSvgLogoBlue),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            context.pushNamed(Routes.otp,
                arguments: context.read<LoginCubit>().emailController.text);
          }
          if (state is LoginError && state.errorMessage != null) {
            Toastifications.show(
              context: context,
              message: state.errorMessage!,
              textColor: textColor,
              borderColor: borderColor,
              backgroundColor: backgroundColor,
            );
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            return const LoadingWidget();
          }
          return Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr(LocaleKeys.login_or_signup),
                        style: TextStyles.size24Weight600.copyWith(
                          color: context.colors.primaryTextColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
                        child: Text(
                          context.tr(LocaleKeys.we_will_send_verification_code),
                          style: TextStyles.size14Weight400.copyWith(
                            color: context.colors.subTextColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: AuthTextFromField(
                          label: context.tr(LocaleKeys.email),
                          hint: context.tr(LocaleKeys.required),
                          helperText: context.tr(LocaleKeys.no_password_needed),
                          autoFillHints: const [AutofillHints.email],
                          keyboardType: TextInputType.emailAddress,
                          controller:
                              context.read<LoginCubit>().emailController,
                          errorText:
                              state is LoginError ? state.emailError : null,
                        ),
                      ),
                      if (!isKeyboardVisible)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: const OrDivider(),
                        ),
                      if (!isKeyboardVisible)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SocialMediaButton(isGoogle: true, onClick: () {}),
                            SocialMediaButton(isGoogle: false, onClick: () {}),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20.h,
                left: 24.w,
                right: 24.w,
                child: PrimaryFilledButton(
                  text: context.tr(LocaleKeys.send_verification_code),
                  onClick: () {
                    context.read<LoginCubit>().onSendVerificationCodeClicked();
                  },
                  isActive: state is LoginButtonEnabled,
                  borderRadius: 100.r,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
