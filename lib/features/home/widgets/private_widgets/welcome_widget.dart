part of '../../presentation/home_screen.dart';

class _WelcomeWidget extends StatelessWidget {
  const _WelcomeWidget({
    super.key,
    required this.name,
    required this.onNotificationClicked,
    required this.gender,
  });

  final String name;
  final void Function() onNotificationClicked;
  final Gender gender;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomAvatar(
          imageUrl: '',
          size: 61.r,
          borderColor: context.colors.imgBorderColor,
          gender: gender,
          backgroundColor: context.colors.borderColor,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.welcome.tr(),
                  style: TextStyles.size16Weight400.copyWith(
                    color: context.colors.accentTextColor,
                  ),
                ),
                Text(
                  name + LocaleKeys.how_are_you.tr(),
                  style: TextStyles.size20Weight600.copyWith(
                    color: context.colors.primaryTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: onNotificationClicked,
          icon: SvgPicture.asset(
            Assets.assetsNotificationIcon,
            width: 24.w,
            height: 24.h,
          ),
        )
      ],
    );
  }
}
