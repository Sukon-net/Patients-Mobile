import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/text_styles.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.width,
    required this.height,
    required this.text,
  });

  final double width;
  final double height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: context.colors.errorAccentColor,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyles.size16Weight400.copyWith(
            color: context.colors.errorColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
