import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_extension.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/widgets/spacers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingTopAppBar extends StatelessWidget {
  const OnboardingTopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              context.switchLanguage();
            },
            child: Row(
              children: [
                Icon(
                  Icons.language,
                  size: 20.w,
                  color: context.colors.primaryTextColor.withOpacity(0.6),
                ),
                HorizontalSpacer(4.w),
                Text(
                  LocaleKeys.switch_locale.tr(),
                  style: TextStyles.size14Weight500.copyWith(
                    color: context.colors.primaryTextColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
