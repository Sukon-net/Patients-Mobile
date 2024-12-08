import 'package:clients/core/constants/assets.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({
    super.key,
    required this.isGoogle,
    required this.onClick,
  });

  final bool isGoogle;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 163.w,
      child: OutlinedButton.icon(
        onPressed: onClick,
        label: Text(
          context.tr(isGoogle ? LocaleKeys.google : LocaleKeys.facebook),
          style: TextStyles.size16Weight700
              .copyWith(color: context.colors.primaryTextColor),
        ),
        icon: isGoogle
            ? SvgPicture.asset(Assets.assetsIconsGoogle)
            : SvgPicture.asset(Assets.assetsIconsFacebook),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.sp),
          ),
          padding: EdgeInsetsDirectional.symmetric(
            vertical: 16.h,
          ),
          side: BorderSide(
            color: context.colors.borderColor,
            width: 1.r,
          ),
        ),
      ),
    );
  }
}
