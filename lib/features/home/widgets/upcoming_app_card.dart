import 'package:clients/core/constants/assets.dart';
import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/routing/navigator_service.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/features/home/model/appointment.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../model/user.dart';
import '../model/top_rated.dart';
import 'custom_avatar.dart';

part 'top_rated_card.dart';

class UpcomingAppCard extends StatelessWidget {
  const UpcomingAppCard({
    super.key,
    required this.appointment,
    required this.onViewDetailsClicked,
    required this.onSeeMoreIconClicked,
  });

  final Appointment appointment;
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
          color: context.colors.backgroundCategoryIconColor,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appointment.doctorName,
              style: TextStyles.size12Weight400.copyWith(
                color: context.colors.accentTextColor,
              ),
            ),
            Text(
              appointment.therapyType,
              style: TextStyles.size16Weight500.copyWith(
                color: context.colors.primaryTextColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                children: [
                  _customIcon(Assets.assetsOnlineIcon, appointment.sessionType),
                  _verticalDivider(),
                  _customIcon(Assets.assetsTimerIcon,
                      "${appointment.startTime}-${appointment.endTime}"),
                  _verticalDivider(),
                  _customIcon(Assets.assetsDateIcon, appointment.dayTime),
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
                      color: context.colors.backgroundCategoryIconColor,
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

Widget _customIcon(String iconPath, String label) {
  return Column(
    children: [
      SvgPicture.asset(iconPath),
      Text(
        label,
        style: TextStyles.size12Weight400.copyWith(
          color: NavigatorService.context.colors.onSecondaryBorderColor,
        ),
      )
    ],
  );
}

Widget _verticalDivider() {
  return Container(
    width: 1.w,
    height: 24.h,
    color: NavigatorService.context.colors.blackWith10Opacity,
    margin: EdgeInsets.symmetric(horizontal: 12.w),
  );
}
