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
    this.width,
    this.isMyAPPointmentsCard = false,
    this.onViewDetailsClicked,
  });

  final Appointment appointment;
  final double? width;
  final bool? isMyAPPointmentsCard;
  final void Function()? onViewDetailsClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: context.colors.appCardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: appointment.status == AppointmentsStatus.ongoing
              ? context.colors.primaryCTAColor
              : context.colors.appCardBorder,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: context.colors.primaryBackgroundColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: context.colors.disabledBackgroundColor,
              ),
            ),
            child: Column(
              spacing: 16.h,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          appointment.doctor.fullNameWithTitle,
                          style: TextStyles.size12Weight400.copyWith(
                            color: context.colors.accentTextColor,
                          ),
                        ),
                        Text(
                          //TODO: add session tittle
                          appointment.doctor.role,
                          style: TextStyles.size16Weight500.copyWith(
                            color: context.colors.primaryTextColor,
                          ),
                        ),
                      ],
                    ),
                    if (isMyAPPointmentsCard == true)
                      Container(
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 9.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                          border: Border.all(
                            color: appointment.status.color,
                          ),
                        ),
                        child: Row(
                          spacing: 7.w,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.circle_sharp,
                              color: appointment.status.color,
                              size: 8.r,
                            ),
                            Text(
                              appointment.status.name.tr(),
                              style: TextStyles.size12Weight600.copyWith(
                                color: appointment.status.color,
                              ),
                            ),
                          ],
                        ),
                      )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIcon(
                      iconPath: Assets.assetsOnlineIcon,
                      label: context.tr(LocaleKeys.online),
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
              ],
            ),
          ),
          VerticalSpacer(12.h),
          if (isMyAPPointmentsCard == false)
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
            )
          else
            Builder(
              builder: (context) {
                switch (appointment.status) {
                  case AppointmentsStatus.ongoing:
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 50.w,
                              vertical: 10.h,
                            ),
                            backgroundColor: context.colors.primaryCTAColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            LocaleKeys.join_now.tr(),
                            style: TextStyles.size14Weight600.copyWith(
                              color: context.colors.onPrimaryCTAColor,
                            ),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 50.w,
                              vertical: 10.h,
                            ),
                            side: BorderSide(
                              color: context.colors.appCardBackground,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            LocaleKeys.cancel.tr(),
                            style: TextStyles.size14Weight600.copyWith(
                              color: context.colors.primaryCTAColor,
                            ),
                          ),
                        ),
                      ],
                    );
                  case AppointmentsStatus.completed:
                    return SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: context.colors.primaryCTAColor,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          LocaleKeys.comment.tr(),
                          style: TextStyles.size14Weight600.copyWith(
                            color: context.colors.primaryCTAColor,
                          ),
                        ),
                      ),
                    );
                  default:
                    return SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: context.colors.primaryCTAColor,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          LocaleKeys.cancel.tr(),
                          style: TextStyles.size14Weight600.copyWith(
                            color: context.colors.primaryCTAColor,
                          ),
                        ),
                      ),
                    );
                }
              },
            ),
        ],
      ),
    );
  }
}
