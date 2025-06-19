import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/shimmers/box_shimmer.dart';
import '../../../core/widgets/spacers.dart';

class HorizonalCardsLoading extends StatelessWidget {
  const HorizonalCardsLoading(
      {super.key, required this.height, required this.width});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return BoxShimmer(
            width: width,
            height: height,
            borderRadius: 12.r,
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            HorizontalSpacer(12.w),
        itemCount: 5,
      ),
    );
  }
}
