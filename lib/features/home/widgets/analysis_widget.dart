part of '../presentation/home_screen.dart';

class _AnalysisWidget extends StatelessWidget {
  const _AnalysisWidget({
    required this.onUpdateClicked,
    required this.dateTime,
    required this.achievedTasksOfDay,
    required this.totalTasksOfDay,
    required this.achievedTaskOfWeek,
    required this.totalTaskOfWeek,
    required this.appointmentsOfDay,
  });

  final String dateTime;
  final void Function() onUpdateClicked;
  final int achievedTasksOfDay;
  final int totalTasksOfDay;
  final int achievedTaskOfWeek;
  final int totalTaskOfWeek;
  final int appointmentsOfDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 250.h,
      decoration: BoxDecoration(
        color: context.colors.primaryCTAColor,
        borderRadius: BorderRadius.circular(16.r),
        image: const DecorationImage(
          image: AssetImage(Assets.assetsHomeLogo),
          alignment: Alignment.topLeft,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 16.w,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.companion_of_health.tr(),
                      style: TextStyles.size16Weight600
                          .copyWith(color: context.colors.onPrimaryCTAColor),
                    ),
                    Text(
                      dateTime,
                      style: TextStyles.size12Weight400.copyWith(
                        color: context.colors.onPrimaryCTAColor,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(50.r),
                  onTap: onUpdateClicked,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 10.h, sigmaX: 10.w),
                      child: Container(
                        padding: EdgeInsetsDirectional.symmetric(
                          vertical: 8.h,
                          horizontal: 16.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                          color: context.colors.whiteWith40Opacity,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.refresh,
                              color: context.colors.onPrimaryCTAColor,
                              size: 20.r,
                            ),
                            HorizontalSpacer(4.w),
                            Text(
                              LocaleKeys.update.tr(),
                              style: TextStyles.size14Weight400.copyWith(
                                color: context.colors.onPrimaryCTAColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnalysisCard(
                    isTasks: true,
                    achievedTasksOfDay: achievedTasksOfDay,
                    maxTasksOfDay: totalTasksOfDay,
                  ),
                  AnalysisCard(
                    isTasks: false,
                    appointmentsOfDay: appointmentsOfDay,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.weekly_achievement.tr(),
                      style: TextStyles.size16Weight500.copyWith(
                        color: context.colors.onPrimaryCTAColor,
                      ),
                    ),
                    Text(
                      "${LocaleKeys.tasks_of_the_week.tr()} ($achievedTaskOfWeek${LocaleKeys.back_slash.tr()}$totalTaskOfWeek)",
                      style: TextStyles.size14Weight400.copyWith(
                        color: context.colors.onPrimaryCTAColor,
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset("assets/images/Chart.svg"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
