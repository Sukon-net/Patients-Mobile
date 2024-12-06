import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/widgets/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SecondaryCtaButton extends StatelessWidget {
  final String icon;
  final String text;
  const SecondaryCtaButton({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      splashColor: Colors.grey,
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: context.colors.secondaryCTAColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(width: 1.w, color: context.colors.borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              width: 24.w,
              height: 24.h,
            ),
            HorizontalSpacer(8.w),
            Text(
              text,
              style: TextStyles.size16Weight700,
            ),
          ],
        ),
      ),
    );
  }
}
