part of '../../presentation/home_screen.dart';

class _UpcomingAppointments extends StatelessWidget {
  const _UpcomingAppointments({
    super.key,
    required this.onUpcomingAppClicked,
    required this.appointments,
    required this.onViewDetailsClicked,
    required this.onSeeMoreIconClicked,
  });

  final void Function() onUpcomingAppClicked;
  final void Function() onViewDetailsClicked;
  final void Function() onSeeMoreIconClicked;
  final List<Appointment> appointments;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.upcoming_appointments.tr(),
              style: TextStyles.size20Weight600.copyWith(
                color: context.colors.primaryTextColor,
              ),
            ),
            IconButton(
              onPressed: onUpcomingAppClicked,
              icon: SvgPicture.asset(Assets.assetsBlueArrowBackIcon),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: SizedBox(
            height: 185.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => UpcomingAppCard(
                appointment: appointments[index],
                onViewDetailsClicked: onViewDetailsClicked,
                onSeeMoreIconClicked: onSeeMoreIconClicked,
              ),
              separatorBuilder: (context, index) => HorizontalSpacer(12.w),
              itemCount: appointments.length,
            ),
          ),
        ),
      ],
    );
  }
}
