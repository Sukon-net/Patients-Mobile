import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryFilledButton extends StatelessWidget {
  const PrimaryFilledButton({
    super.key,
    required this.text,
    required this.onClick,
    this.isActive = true,
  });

  final String text;
  final bool isActive;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: FilledButton(
        onPressed: isActive ? onClick : null,
        style: FilledButton.styleFrom(
          backgroundColor: context.colors.primaryCTAColor,
          disabledBackgroundColor: context.colors.disabledPrimaryCTAColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.h),
        ),
        child: Text(
          text,
          style: TextStyles.size18Weight600.copyWith(
            color: context.colors.onPrimaryCTAColor,
          ),
        ),
      ),
    );
  }
}
