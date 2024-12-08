import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: context.colors.dividerColor,
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Text(
            context.tr(LocaleKeys.or_divider),
            style: TextStyles.size16Weight400.copyWith(
              color: context.colors.dividerColor,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: context.colors.dividerColor,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}