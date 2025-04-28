part of '../../presentation/home_screen.dart';

class _UpcomingAppointments extends StatelessWidget {
  const _UpcomingAppointments({
    super.key,
    required this.doctor,
    required this.onViewDetailsClicked,
    required this.onSeeMoreIconClicked,
  });

  final void Function() onViewDetailsClicked;
  final void Function() onSeeMoreIconClicked;
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: SizedBox(
            height: 185.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => UpcomingAppCard(
                doctor: doctor,
                onViewDetailsClicked: onViewDetailsClicked,
                onSeeMoreIconClicked: onSeeMoreIconClicked,
              ),
              separatorBuilder: (context, index) => HorizontalSpacer(12.w),
              itemCount: 5,
            ),
          ),
        ),
      ],
    );
  }
}
