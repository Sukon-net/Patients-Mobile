import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../../../core/theme/text_styles.dart';

class PhoneNumberFormField extends StatelessWidget {
  final String label;
  final String hint;
  final PhoneController? controller;
  final String? errorText;

  const PhoneNumberFormField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.errorText,
  });

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
        PhoneFormField(
          controller: controller,
          cursorColor: context.colors.primaryTextColor,
          initialValue: const PhoneNumber(isoCode: IsoCode.EG, nsn: ''),
          validator: PhoneValidator.compose([
            PhoneValidator.required(context),
            PhoneValidator.validMobile(context, errorText: errorText)
          ]),
          decoration: InputDecoration(
            filled: true,
            fillColor: errorText != null
                ? context.colors.errorAccentColor
                : context.colors.primaryBackgroundColor,

            ///Default State///
            enabledBorder: OutlineInputBorder(
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
            //errorText: errorText,

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
          ),
          countrySelectorNavigator:
              const CountrySelectorNavigator.draggableBottomSheet(
            favorites: [
              IsoCode.EG,
              IsoCode.SA,
              IsoCode.PS,
              IsoCode.AE,
            ],
          ),
          countryButtonStyle: const CountryButtonStyle(
            showDialCode: false,
            showIsoCode: true,
            showFlag: false,
          ),
        ),
      ],
    );
  }
}
