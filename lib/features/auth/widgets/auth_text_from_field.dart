import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/text_styles.dart';

class AuthTextFromField extends StatelessWidget {
  const AuthTextFromField({
    super.key,
    required this.label,
    required this.hint,
    this.helperText,
    this.errorText,
    this.controller,
    this.textCapitalization,
    this.keyboardType,
    this.autoFillHints,
    this.enabled = true,
    this.showDisabledState = false,
    this.initialValue,
    this.validator,
  });

  final String label;
  final String hint;
  final TextEditingController? controller;
  final String? helperText;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final List<String>? autoFillHints;
  final bool enabled;
  final bool showDisabledState;
  final String? initialValue;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Text(
            label,
            style: TextStyles.size16Weight500.copyWith(
              color: context.colors.primaryTextColor,
            ),
          ),
        ),
        TextFormField(
          validator: validator,
          initialValue: initialValue,
          enabled: enabled,
          autovalidateMode: AutovalidateMode.onUnfocus,
          controller: controller,
          keyboardType: keyboardType,
          cursorColor: context.colors.primaryTextColor,
          cursorErrorColor: context.colors.primaryTextColor,
          autofillHints: autoFillHints,
          style: TextStyles.size14Weight400.copyWith(
            color: showDisabledState
                ? context.colors.accentTextColor
                : context.colors.primaryTextColor,
          ),
          onTapOutside: (value) {
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: errorText != null
                ? context.colors.errorAccentColor
                : showDisabledState
                    ? context.colors.disabledBackgroundColor
                    : context.colors.primaryBackgroundColor,

            ///Default State///
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1.r, color: context.colors.borderColor),
              borderRadius: BorderRadius.circular(8.r),
            ),

            disabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1.r, color: context.colors.borderColor),
              borderRadius: BorderRadius.circular(8.r),
            ),

            ///Error Handling///
            errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 2.r, color: context.colors.errorColor),
              borderRadius: BorderRadius.circular(8.r),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.r,
                color: context.colors.errorColor,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            errorStyle: TextStyles.size14Weight400.copyWith(
              color: context.colors.errorColor,
            ),
            errorText: errorText,

            ///Focused Handling///
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 2.r, color: context.colors.primaryCTAColor),
              borderRadius: BorderRadius.circular(8.r),
            ),

            ///Hint Text///
            hintText: hint,
            hintStyle: TextStyles.size14Weight400
                .copyWith(color: context.colors.accentTextColor),
            helper: helperText != null
                ? Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      helperText!,
                      style: TextStyles.size14Weight400.copyWith(
                        color: context.colors.accentTextColor,
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
