import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/shimmers/box_shimmer.dart';
import '../../../core/widgets/spacers.dart';

class TopRatedDocLoading extends StatelessWidget {
  const TopRatedDocLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return BoxShimmer(
            width: 300.w,
            height: 130.h,
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
