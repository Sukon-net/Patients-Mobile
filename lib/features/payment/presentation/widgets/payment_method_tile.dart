import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/utils/extensions/num_duration_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String? subtitle;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      dense: true,
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(
          color: context.colors.paymentMethodBorderColor,
        ),
      ),
      tileColor: context.colors.paymentMethodBackgroundColor,
      title: Text(
        title,
        style: TextStyles.size14Weight600.copyWith(
          color: context.colors.primaryTextColor,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyles.size12Weight400.copyWith(
                color: context.colors.primaryCTAColor,
              ),
            )
          : null,
      trailing: SvgPicture.asset(icon, width: 18.w, height: 18.h),
      leading: AnimatedContainer(
          duration: 100.ms,
          width: 18.w,
          height: 18.h,
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected
                  ? context.colors.primaryCTAColor
                  : context.colors.primaryTextColor,
            ),
          ),
          child: AnimatedScale(
            duration: 100.ms,
            scale: isSelected ? 1 : 0,
            child: Center(
              child: Container(
                width: 10.w,
                height: 10.h,
                margin: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: context.colors.primaryCTAColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          )),
      onTap: onTap,
    );
  }
}
