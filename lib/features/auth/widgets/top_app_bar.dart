import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/assets.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: 24.h,
            left: 24.w,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                width: 48.w,
                height: 48.h,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    side: BorderSide(color: context.colors.borderColor),
                  ),
                ),
                child: Icon(
                  Icons.arrow_forward_sharp,
                  color: context.colors.primaryTextColor,
                ),
              ),
            ),
          ),
          Positioned(
            top: 40.h,
            right: MediaQuery.sizeOf(context).width / 2 - 27,
            child: SvgPicture.asset(Assets.assetsSvgLogoBlue),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 40.h);
}
