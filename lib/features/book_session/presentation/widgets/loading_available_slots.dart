import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/shimmers/box_shimmer.dart';

class LoadingAvailableSlots extends StatelessWidget {
  const LoadingAvailableSlots({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16.h,
      children: [
        Row(
          spacing: 16.w,
          children: [
            ...List.generate(
              3,
              (index) => BoxShimmer(
                width: 94.w,
                height: 45.h,
                borderRadius: 10.r,
              ),
            ),
          ],
        ),
        Row(
          spacing: 16.w,
          children: [
            ...List.generate(
              2,
              (index) => BoxShimmer(
                width: 94.w,
                height: 45.h,
                borderRadius: 10.r,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
