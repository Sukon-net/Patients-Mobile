part of 'appointment_card.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.doctor,
    this.width,
    this.borderColor,
    this.showBackground = false,
    this.onTab,
  });

  final Doctor doctor;
  final double? width;
  final Color? borderColor;
  final bool? showBackground;
  final void Function()? onTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      borderRadius: BorderRadius.circular(12.r),
      child: Stack(
        children: [
          if (showBackground == true) ...[
            Positioned(
              left: 0.w,
              child: SvgPicture.asset(
                Assets.assetsDocCardBackgroundTop,
              ),
            ),
            Positioned(
              right: 0.w,
              bottom: 0.h,
              child: SvgPicture.asset(
                Assets.assetsDocCardBackgroundBottom,
              ),
            ),
          ],
          Container(
            width: width ?? double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: borderColor ?? context.colors.blackWith10Opacity,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomAvatar(
                        imageUrl: doctor.avatar!,
                        radius: 24.r,
                        shape: BoxShape.rectangle,
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.only(start: 8.w, end: 6.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${doctor.title}${doctor.firstName} ${doctor.lastName}",
                                style: TextStyles.size16Weight500.copyWith(
                                  color: context.colors.primaryTextColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                doctor.role,
                                style: TextStyles.size12Weight400.copyWith(
                                  color: context.colors.accentTextColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsetsDirectional.symmetric(
                          vertical: 4.h,
                          horizontal: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: context.colors.disabledBackgroundColor,
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: Text(
                          "${context.tr(LocaleKeys.starting_from)} ${doctor.sessionEGPPrice ?? 0} ${context.tr(LocaleKeys.egp)}",
                          style: TextStyles.size12Weight400.copyWith(
                            color: context.colors.primaryTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.h,
                    color: NavigatorService.context.colors.blackWith10Opacity,
                    margin: EdgeInsets.symmetric(vertical: 16.w),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomIcon(
                        iconPath: Assets.assetsAppointmentsIcon,
                        label: doctor.availableSlotsCount == null
                            ? LocaleKeys.appointment.plural(0)
                            : LocaleKeys.appointment
                                .plural(doctor.availableSlotsCount as num),
                      ),
                      VerticalDividerWidget(24.h),
                      CustomIcon(
                        iconPath: Assets.assetsChatIcon,
                        label: "${doctor.comment}",
                      ),
                      VerticalDividerWidget(24.h),
                      CustomIcon(
                        iconPath: Assets.assetsExperienceIcon,
                        label: LocaleKeys.year.plural(doctor.yearsOfExperience),
                      ),
                      VerticalDividerWidget(24.h),
                      CustomIcon(
                        iconPath: Assets.assetsStarRateIcon,
                        label: "${doctor.rating}",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
