import 'package:clients/core/constants/assets.dart';
import 'package:clients/core/routing/routes.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_extension.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/widgets/or_divider.dart';
import 'package:clients/core/widgets/primary_filled_button.dart';
import 'package:clients/core/widgets/social_media_button.dart';
import 'package:clients/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Center(
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.symmetric(vertical: 32.h),
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.assetsSvgHorizontalLogo),
                        const Spacer(),
                        TextButton(
                          onPressed: context.switchLanguage,
                          child: Row(
                            children: [
                              Text(
                                context.tr(LocaleKeys.switch_locale),
                                style: TextStyles.size14Weight500.copyWith(
                                    color: context.colors.primaryTextColor),
                              ),
                              SizedBox(width: 4.w),
                              SvgPicture.asset(
                                Assets.assetsIconsLanguage,
                                width: 20.w,
                                height: 20.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(Assets.assetsImagesOnboarding),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: Text(
                      context.tr(LocaleKeys.onboarding_main_text),
                      style: TextStyles.size24Weight700,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  PrimaryFilledButton(
                    text: context.tr(LocaleKeys.onboarding_button_text),
                    onClick: () {
                      Navigator.pushNamed(context, Routes.login);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: const OrDivider(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SocialMediaButton(
                        isGoogle: true,
                        //TODO: when google pressed
                        onClick: () {},
                      ),
                      SocialMediaButton(
                        isGoogle: false,
                        //TODO: when facebook pressed
                        onClick: () {},
                      ),
                    ],
                  ),
                  TextButton(
                    // TODO: when continue as a guest pressed
                    onPressed: () { },
                    child: Text(
                      context.tr(LocaleKeys.continue_as_a_guest),
                      style: TextStyles.size16Weight500.copyWith(
                        color: context.colors.primaryCTAColor,
                        decoration: TextDecoration.underline,
                        decorationColor: context.colors.primaryCTAColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 36.w),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: context.tr(LocaleKeys.text_span_1),
                        style: TextStyles.size14Weight400
                            .copyWith(color: context.colors.primaryTextColor),
                        children: [
                          TextSpan(
                            text: context.tr(LocaleKeys.terms_of_service),
                            style: TextStyles.size14Weight400.copyWith(
                              color: context.colors.primaryCTAColor,
                              decoration: TextDecoration.underline,
                              decorationColor: context.colors.primaryCTAColor,
                            ),
                            //TODO: Terms of Service
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                          TextSpan(
                            text: context.tr(LocaleKeys.and),
                            style: TextStyles.size14Weight400.copyWith(
                              color: context.colors.primaryTextColor,
                            ),
                          ),
                          TextSpan(
                            text: context.tr(LocaleKeys.privacy_policy),
                            style: TextStyles.size14Weight400.copyWith(
                              color: context.colors.primaryCTAColor,
                              decoration: TextDecoration.underline,
                              decorationColor: context.colors.primaryCTAColor,
                            ),
                            //TODO: Privacy Policy
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                          TextSpan(
                            text: context.tr(LocaleKeys.text_span_2),
                            style: TextStyles.size14Weight400.copyWith(
                              color: context.colors.primaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}