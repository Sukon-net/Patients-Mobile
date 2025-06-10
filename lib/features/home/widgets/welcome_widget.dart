part of '../presentation/home_screen.dart';

class _WelcomeWidget extends StatelessWidget {
  const _WelcomeWidget({
    required this.name,
    required this.imgUrl,
    required this.onNotificationClicked,
  });

  final String name;
  final String imgUrl;
  final void Function() onNotificationClicked;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomAvatar(
          imageUrl: imgUrl,
          radius: 28.r,
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
