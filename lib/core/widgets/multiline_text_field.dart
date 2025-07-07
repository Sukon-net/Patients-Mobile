import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/text_styles.dart';

class MultilineTextField extends StatelessWidget {
  const MultilineTextField({
    super.key,
    required this.height,
    required this.controller,
  });

  final double height;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        expands: true,
        maxLines: null,
        controller: controller,
        onTapOutside: (_) {
          FocusScope.of(context).unfocus();
        },
        style: TextStyles.size14Weight500.copyWith(
          color: context.colors.primaryTextColor,
        ),
        cursorColor: context.colors.primaryTextColor,
        textAlignVertical: TextAlignVertical.top,
        scrollPadding: EdgeInsets.all(16.r),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: context.colors.blackWith10Opacity,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: context.colors.blackWith10Opacity,
            ),
          ),
        ),
      ),
    );
  }
}
