import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/l10n/generated/locale_keys.g.dart';
import '../../../model/user.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({
    super.key,
    required this.onGenderSelectionChange,
    required this.currentSelection,
  });

  final void Function(Gender gender) onGenderSelectionChange;
  final Gender? currentSelection;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GenderButton(
          text: context.tr(LocaleKeys.male),
          onClick: () => onGenderSelectionChange(Gender.male),
          isActive: currentSelection == Gender.male,
        ),
        GenderButton(
          text: context.tr(LocaleKeys.female),
          onClick: () => onGenderSelectionChange(Gender.female),
          isActive: currentSelection == Gender.female,
        ),
      ],
    );
  }
}

class GenderButton extends StatelessWidget {
  const GenderButton({
    super.key,
    required this.text,
    required this.onClick,
    this.isActive = false,
  });

  final String text;
  final bool isActive;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.w,
      child: OutlinedButton(
        onPressed: onClick,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsetsDirectional.symmetric(
            vertical: 8.5.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          side: BorderSide(
            color: isActive
                ? context.colors.primaryCTAColor
                : context.colors.borderColor,
            width: 1.r,
          ),
        ),
        child: Text(
          text,
          style: TextStyles.size16Weight400.copyWith(
            color: isActive
                ? context.colors.primaryCTAColor
                : context.colors.accentTextColor,
          ),
        ),
      ),
    );
  }
}
