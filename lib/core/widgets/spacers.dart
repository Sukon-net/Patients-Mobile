import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../routing/navigator_service.dart';

class HorizontalSpacer extends StatelessWidget {
  final double width;

  const HorizontalSpacer(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

class VerticalSpacer extends StatelessWidget {
  final double height;

  const VerticalSpacer(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class VerticalDividerWidget extends StatelessWidget {
  final double height;

  const VerticalDividerWidget(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.w,
      height: height,
      color: NavigatorService.context.colors.blackWith10Opacity,
      margin: EdgeInsets.symmetric(horizontal: 12.w),
    );
  }
}
