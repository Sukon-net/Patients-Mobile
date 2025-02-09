part of 'upcoming_app_card.dart';

class TopRatedCard extends StatelessWidget {
  const TopRatedCard({super.key, required this.topRated});

  final TopRated topRated;

  @override
  Widget build(BuildContext context) {
    return Container(
      //TODO replace this fixed width with dynamic size of container
      width: 329.w,
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
                  imageUrl: '',
                  size: 48,
                  borderColor: context.colors.blackWith10Opacity,
                  gender: Gender.male,
                  backgroundColor: context.colors.blackWith10Opacity,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.w, left: 6.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          topRated.doctorName,
                          style: TextStyles.size16Weight500
                              .copyWith(color: context.colors.primaryTextColor),
                        ),
                        Text(
                          topRated.doctorTittle,
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
                  decoration: BoxDecoration(
                    color: context.colors.backgroundCategoryIconColor,
                    borderRadius: BorderRadius.circular(32.r),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    child: Text(
                      topRated.category,
                      style: TextStyles.size12Weight400.copyWith(
                        color: context.colors.primaryTextColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 305.w,
              height: 1.h,
              color: NavigatorService.context.colors.blackWith10Opacity,
              margin: EdgeInsets.symmetric(vertical: 8.w),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _customIcon(
                  Assets.assetsAppointmentsIcon,
                  "${topRated.appointments} ${LocaleKeys.appointment.tr()}",
                ),
                _verticalDivider(),
                _customIcon(
                  Assets.assetsChatIcon,
                  "${topRated.numOfComments}",
                ),
                _verticalDivider(),
                _customIcon(
                  Assets.assetsExperienceIcon,
                  "${topRated.numOfExperiences} ${LocaleKeys.year.tr()}",
                ),
                _verticalDivider(),
                _customIcon(
                  Assets.assetsStarRateIcon,
                  "${topRated.rated}",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
