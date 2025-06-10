import 'package:clients/core/constants/assets.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/text_styles.dart';

class SearchTextFormField extends StatelessWidget {
  const SearchTextFormField({
    super.key,
    required this.hint,
    this.controller,
  });

  final TextEditingController? controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      cursorColor: context.colors.primaryTextColor,
      cursorErrorColor: context.colors.primaryTextColor,
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
          child: SvgPicture.asset(Assets.assetsSearchIcon),
        ),
        prefixIconConstraints: BoxConstraints(minHeight: 24.h, minWidth: 24.w),

        ///Default State///
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 1.r, color: context.colors.secondaryBorderColor),
          borderRadius: BorderRadius.circular(8.r),
        ),

        ///Focused Handling///
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 2.r, color: context.colors.primaryCTAColor),
          borderRadius: BorderRadius.circular(8.r),
        ),

        ///Hint Text///
        hintText: hint,
        hintStyle: TextStyles.size14Weight400
            .copyWith(color: context.colors.onSecondaryBorderColor),
      ),
    );
  }
}
