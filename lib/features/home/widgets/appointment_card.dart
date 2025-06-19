import 'package:clients/core/constants/assets.dart';
import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/routing/navigator_service.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/widgets/spacers.dart';
import 'package:clients/features/home/model/appointment.dart';
import 'package:clients/features/home/model/doctor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/widgets/custom_avatar.dart';
import '../../../core/widgets/custom_icon.dart';

part 'doctor_card.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.onViewDetailsClicked,
    required this.onSeeMoreIconClicked,
    this.width,
  });

  final Appointment appointment;
  final double? width;
  final void Function() onViewDetailsClicked;
  final void Function() onSeeMoreIconClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: context.colors.backgroundSpecializationIconColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            appointment.doctor.fullNameWithTitle,
            style: TextStyles.size12Weight400.copyWith(
              color: context.colors.accentTextColor,
            ),
          ),
          Text(
            //TODO: add session specialization
            appointment.doctor.role,
            style: TextStyles.size16Weight500.copyWith(
              color: context.colors.primaryTextColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomIcon(
                  iconPath: Assets.assetsOnlineIcon,
                  //TODO: add session type
                  label: "online",
                ),
                VerticalDividerWidget(24.h),
                CustomIcon(
                  iconPath: Assets.assetsTimerIcon,
                  label:
                      "${appointment.startTime.toString()}-${appointment.endTimeString}",
                ),
                VerticalDividerWidget(24.h),
                CustomIcon(
                  iconPath: Assets.assetsDateIcon,
                  label: appointment.date.toString(),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FilledButton(
                onPressed: onViewDetailsClicked,
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 50.w,
                    vertical: 10.h,
                  ),
                  backgroundColor: context.colors.secondaryCTABackgroundColor,
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
                  icon: Icon(
                    Icons.more_horiz,
                    color: context.colors.primaryCTAColor,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
