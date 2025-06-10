import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalenderCard extends StatelessWidget {
  const CalenderCard({
    super.key,
    required this.dayName,
    required this.dayNumber,
    required this.isSelected,
    required this.onClick,
  });

  final String dayName;
  final String dayNumber;
  final bool isSelected;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onClick,
      child: Container(
        width: 62.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: isSelected
              ? context.colors.primaryCTAColor
              : context.colors.inactiveCalenderCard,
        ),
        child: Column(
          spacing: 4.h,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayName,
              style: TextStyles.size12Weight500.copyWith(
                color: isSelected
                    ? context.colors.onPrimaryCTAColor
                    : context.colors.primaryTextColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              dayNumber,
              style: TextStyles.size12Weight500.copyWith(
                color: isSelected
                    ? context.colors.onPrimaryCTAColor
                    : context.colors.primaryTextColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
