import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({super.key, required this.widget});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 24.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          height: preferredSize.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.r),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
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
                      textDirection: TextDirection.rtl,
                      color: context.colors.primaryTextColor,
                    ),
                  ),
                ),
              ),
              Center(child: widget),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 32.h);
}
