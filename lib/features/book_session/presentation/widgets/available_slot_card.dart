import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailableSlotCard extends StatelessWidget {
  const AvailableSlotCard({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onSlotSelected,
  });

  final String text;
  final bool isSelected;
  final void Function(String? slot) onSlotSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: () => onSlotSelected(text),
      child: Container(
        padding:
            EdgeInsetsDirectional.symmetric(vertical: 10.h, horizontal: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: isSelected
              ? context.colors.primaryCTAColor
              : context.colors.primaryBackgroundColor,
          border: Border.all(
            color: isSelected
                ? context.colors.primaryCTAColor
                : context.colors.blackWith10Opacity,
          ),
        ),
        child: Text(
          text,
          style: TextStyles.size14Weight500.copyWith(
            color: isSelected
                ? context.colors.primaryBackgroundColor
                : context.colors.primaryTextColor,
          ),
        ),
      ),
    );
  }
}
