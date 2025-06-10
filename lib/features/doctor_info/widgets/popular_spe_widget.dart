import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularSpeWidget extends StatelessWidget {
  const PopularSpeWidget({super.key, required this.specializations});

  final List<String> specializations;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 8.w,
      runSpacing: 12.h,
      children: List.generate(
        specializations.length,
        (index) => Container(
          padding: EdgeInsetsDirectional.symmetric(
            vertical: 8.h,
            horizontal: 16.w,
          ),
          decoration: BoxDecoration(
            color: context.colors.secondaryCTABackgroundColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            specializations[index],
            style: TextStyles.size12Weight500.copyWith(
              color: context.colors.primaryCTAColor,
            ),
          ),
        ),
      ),
    );
  }
}
