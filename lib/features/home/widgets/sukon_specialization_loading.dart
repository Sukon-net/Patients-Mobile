import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/shimmers/box_shimmer.dart';
import '../../../core/widgets/shimmers/circle_shimmer.dart';

class SukonSpecializationLoading extends StatelessWidget {
  const SukonSpecializationLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 255.h,
      child: Column(
        spacing: 16.h,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              3,
              (index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleShimmer(size: 60.r),
                    SizedBox(height: 10.h),
                    BoxShimmer(
                      width: 56.w,
                      height: 16.h,
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              3,
              (index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleShimmer(size: 60.r),
                    SizedBox(height: 10.h),
                    BoxShimmer(
                      width: 56.w,
                      height: 16.h,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
