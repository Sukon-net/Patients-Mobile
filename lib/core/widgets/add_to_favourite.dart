import 'package:clients/core/constants/assets.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/utils/extensions/num_duration_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddToFavourite extends StatefulWidget {
  const AddToFavourite({
    super.key,
    required this.isFavourite,
    required this.onTab,
  });

  final bool isFavourite;
  final void Function() onTab;

  @override
  State<AddToFavourite> createState() => _AddToFavouriteState();
}

class _AddToFavouriteState extends State<AddToFavourite> {
  double _scale = 1.0;

  void _triggerPulseAnimation() async {
    setState(() {
      _scale = 1.2;
    });

    await Future.delayed(100.ms);

    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100.r),
      onTap: () {
        widget.onTab();
        HapticFeedback.lightImpact();
        _triggerPulseAnimation();
      },
      child: AnimatedContainer(
        padding: EdgeInsetsDirectional.all(10.h),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.isFavourite
              ? context.colors.addToFavBackground
              : context.colors.onPrimaryCTAColor,
          border: Border.all(
            color: context.colors.addToFavBorder,
          ),
        ),
        duration: 150.ms,
        child: Center(
          child: AnimatedScale(
            scale: _scale,
            duration: 150.ms,
            curve: Curves.easeInOut,
            child: SvgPicture.asset(
              widget.isFavourite
                  ? Assets.assetsFilledFavHeartIcon
                  : Assets.assetsHeartIcon,
              color: context.colors.readHeartColor,
              width: 20.r,
              height: 20.r,
            ),
          ),
        ),
      ),
    );
  }
}
