import 'package:clients/core/constants/assets.dart';
import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/widgets/spacers.dart';
import 'package:clients/features/onboarding/widgets/onboarding_top_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OnboardingTopAppBar(),
              VerticalSpacer(32.h),
              Image.asset(Assets.assetsImagesOnboardingImage),
              VerticalSpacer(24.h),
              Text(
                context.tr(LocaleKeys.onboarding_welcome_message),
                style: TextStyles.size30Weight700.copyWith(
                  color: context.colors.primaryTextColor,
                ),
              ),
              VerticalSpacer(24.h),
            ],
          ),
        ),
      ),
    );
  }
}
