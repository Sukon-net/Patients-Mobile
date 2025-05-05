import 'package:clients/core/constants/assets.dart';
import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/routing/navigator_service.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/widgets/spacers.dart';
import 'package:clients/features/home/model/doctor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/widgets/custom_avatar.dart';
import '../../../core/widgets/custom_icon.dart';

part 'doctor_card.dart';

class UpcomingAppCard extends StatelessWidget {
  const UpcomingAppCard({
    super.key,
    required this.doctor,
    required this.onViewDetailsClicked,
    required this.onSeeMoreIconClicked,
  });

  final Doctor doctor;
  final void Function() onViewDetailsClicked;
  final void Function() onSeeMoreIconClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      //TODO replace this fixed width with dynamic size of container
      width: 260.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: context.colors.backgroundSpecializationIconColor,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              doctor.firstName,
              style: TextStyles.size12Weight400.copyWith(
                color: context.colors.accentTextColor,
              ),
            ),
            Text(
              doctor.role,
              style: TextStyles.size16Weight500.copyWith(
                color: context.colors.primaryTextColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                children: [
                  const CustomIcon(
                      iconPath: Assets.assetsOnlineIcon,
                      label: "appointment.sessionType"),
                  VerticalDividerWidget(24.h),
                  CustomIcon(
                      iconPath: Assets.assetsTimerIcon,
                      label:
                          "${doctor.availableSlots![0].startTime}-${doctor.availableSlots![0].endTime}"),
                  VerticalDividerWidget(24.h),
                  CustomIcon(
                      iconPath: Assets.assetsDateIcon,
                      label: doctor.availableSlots![0].day),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 174.w,
                  height: 40.h,
                  child: FilledButton(
                    onPressed: onViewDetailsClicked,
                    style: FilledButton.styleFrom(
                      backgroundColor:
                          context.colors.secondaryCTABackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      LocaleKeys.view_details.tr(),
                      style: TextStyles.size14Weight500.copyWith(
                        color: context.colors.primaryCTAColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 42.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: context.colors.backgroundSpecializationIconColor,
                    ),
                  ),
                  child: IconButton(
                    onPressed: onSeeMoreIconClicked,
                    icon: SvgPicture.asset(Assets.assetsSeeMoreIcon),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
