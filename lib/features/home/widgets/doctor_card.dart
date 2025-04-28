part of 'upcoming_app_card.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.doctor,
    this.width,
    this.onTab,
  });

  final Doctor doctor;
  final double? width;
  final void Function()? onTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: context.colors.blackWith10Opacity,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAvatar(
                    imageUrl: doctor.avatar!,
                    radius: 24.r,
                    shape: BoxShape.rectangle,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.w, left: 6.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${doctor.title} ${doctor.firstName} ${doctor.lastName}",
                            style: TextStyles.size16Weight500.copyWith(
                              color: context.colors.primaryTextColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            doctor.role!,
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
                ],
              ),
              Container(
                width: double.infinity,
                height: 1.h,
                color: NavigatorService.context.colors.blackWith10Opacity,
                margin: EdgeInsets.symmetric(vertical: 8.w),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIcon(
                    iconPath: Assets.assetsAppointmentsIcon,
                    label:
                        "${doctor.availableSlots!.length} ${LocaleKeys.appointment.tr()}",
                  ),
                  VerticalDividerWidget(24.h),
                  CustomIcon(
                    iconPath: Assets.assetsChatIcon,
                    label: "${doctor.comment}",
                  ),
                  VerticalDividerWidget(24.h),
                  CustomIcon(
                    iconPath: Assets.assetsExperienceIcon,
                    label: "${doctor.yearOfExperience} ${LocaleKeys.year.tr()}",
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
    );
  }
}
