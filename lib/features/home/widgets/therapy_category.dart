import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/text_styles.dart';

class TherapyCategory extends StatelessWidget {
  const TherapyCategory({
    super.key,
    required this.iconPath,
    required this.name,
    required this.onIconClicked,
  });

  final String iconPath;
  final String name;
  final void Function() onIconClicked;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: context.colors.backgroundCategoryIconColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: onIconClicked,
              icon: SvgPicture.asset(iconPath),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Text(
              name,
              style: TextStyles.size14Weight400.copyWith(
                color: context.colors.primaryTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
