import 'package:clients/app.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/widgets/error_screen.dart';
import 'package:clients/core/widgets/loading_widget.dart';
import 'package:clients/core/widgets/spacer.dart';
import 'package:clients/features/auth/login/logic/login_cubit.dart';
import 'package:clients/features/auth/widgets/top_app_bar.dart';
import 'package:clients/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        appBar: const TopAppBar(),
        body: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            switch (state) {
              case LoginInitial():
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VerticalSpacer(48.h),
                      Text(
                        LocaleKeys.login_or_signup,
                        style: TextStyles.size24Weight600.copyWith(
                          color: context.colors.primaryTextColor,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        LocaleKeys.we_will_send_verification_code,
                        style: TextStyles.size14Weight400.copyWith(
                          color: context.colors.subTextColor,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        LocaleKeys.email,
                        style: TextStyles.size16Weight500.copyWith(
                          color: context.colors.primaryTextColor,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                );
              case LoginLoading():
                return const LoadingWidget();
              case LoginLoaded():
              // TODO: Handle this case.
              case LoginError():
              // TODO: Handle this case.
            }
            return const ErrorScreen("Unknown state");
          },
        ),
      ),
    );
  }
}
