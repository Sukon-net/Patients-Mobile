import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/l10n/generated/locale_keys.g.dart';
import '../../../../model/user.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({
    super.key,
    required this.onGenderSelectionChange,
    required this.currentSelection,
    this.validator,
  });

  final void Function(Gender gender) onGenderSelectionChange;
  final Gender? currentSelection;
  final FormFieldValidator<Gender>? validator;

  @override
  Widget build(BuildContext context) {
    return FormField<Gender>(
      initialValue: currentSelection,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GenderButton(
                text: context.tr(LocaleKeys.male),
                onClick: () {
                  onGenderSelectionChange(Gender.male);
                  field.didChange(Gender.male);
                },
                isActive: currentSelection == Gender.male,
                isError: field.errorText != null,
              ),
              GenderButton(
                text: context.tr(LocaleKeys.female),
                onClick: () {
                  onGenderSelectionChange(Gender.female);
                  field.didChange(Gender.female);
                },
                isActive: currentSelection == Gender.female,
                isError: field.errorText != null,
              ),
            ],
          ),
          if (field.errorText != null)
            Padding(
              padding: EdgeInsetsDirectional.only(start: 12.w),
              child: Text(
                field.errorText!,
                style: TextStyles.size14Weight400.copyWith(
                  color: context.colors.errorColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class GenderButton extends StatelessWidget {
  const GenderButton({
    super.key,
    required this.text,
    required this.onClick,
    this.isActive = false,
    this.isError = false,
  });

  final String text;
  final bool isActive;
  final bool isError;
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
                : isError
                    ? context.colors.errorColor
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
