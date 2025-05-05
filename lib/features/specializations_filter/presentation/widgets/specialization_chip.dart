import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecializationChip extends StatelessWidget {
  const SpecializationChip({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onSelected,
  });

  final String name;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        name,
        style: TextStyles.size12Weight500.copyWith(
          color: isSelected
              ? context.colors.onPrimaryCTAColor
              : context.colors.primaryCTAColor,
        ),
      ),
      selected: isSelected,
      side: BorderSide(
        color: context.colors.primaryCTAColor,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
      selectedColor: context.colors.primaryCTAColor,
      backgroundColor: context.colors.onPrimaryCTAColor,
      showCheckmark: false,
      onSelected: onSelected,
    );
  }
}
