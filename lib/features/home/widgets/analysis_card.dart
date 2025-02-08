import 'package:clients/core/constants/assets.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

import '../../../core/l10n/generated/locale_keys.g.dart';

class AnalysisCard extends StatelessWidget {
  const AnalysisCard({
    super.key,
    required this.isTasks,
    this.achievedTasksOfDay,
    this.maxTasksOfDay,
    this.appointmentsOfDay,
  });

  final bool isTasks;
  final int? achievedTasksOfDay;
  final int? maxTasksOfDay;
  final int? appointmentsOfDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 152.5.w,
      height: 85.h,
      decoration: BoxDecoration(
        color: context.colors.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isTasks
                ? SvgPicture.asset(Assets.assetsTaskIcon)
                : SvgPicture.asset(Assets.assetsTimeIcon),
            Text(
              isTasks
                  ? LocaleKeys.today_s_tasks.tr()
                  : LocaleKeys.today_s_appointments.tr(),
              style: TextStyles.size12Weight500.copyWith(
                color: context.colors.primaryTextColor,
              ),
            ),
            Text(
              isTasks
                  ? "$achievedTasksOfDay${LocaleKeys.back_slash.tr()}$maxTasksOfDay"
                  : "$appointmentsOfDay ${LocaleKeys.appointments.tr()}",
              style: TextStyles.size10Weight400.copyWith(
                color: context.colors.primaryTextColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: isTasks
                  ? LinearProgressBar(
                      borderRadius: BorderRadius.circular(4.r),
                      currentStep: achievedTasksOfDay ?? 0,
                      maxSteps: maxTasksOfDay ?? 1,
                      backgroundColor: context.colors.secondaryProgressColor,
                      progressColor: context.colors.primaryProgressColor,
                    )
                  : SvgPicture.asset("assets/images/square_bar.svg"),
            ),
          ],
        ),
      ),
    );
  }
}
