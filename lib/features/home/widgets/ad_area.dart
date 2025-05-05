import 'package:clients/core/constants/assets.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdArea extends StatelessWidget {
  const AdArea({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: context.colors.adGradientColors),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: SvgPicture.asset(
        Assets.assetsGrayLogo,
        fit: BoxFit.none,
      ),
    );
  }
}
