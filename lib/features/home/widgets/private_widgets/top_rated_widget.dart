part of '../../presentation/home_screen.dart';

class _TopRatedWidget extends StatelessWidget {
  const _TopRatedWidget({super.key, required this.topRates});

  final List<TopRated> topRates;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h, bottom: 16.h),
      child: SizedBox(
        height: 126.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => TopRatedCard(
            topRated: topRates[index],
          ),
          separatorBuilder: (context, index) => HorizontalSpacer(12.w),
          itemCount: topRates.length,
        ),
      ),
    );
  }
}
