import 'package:clients/core/constants/assets.dart';
import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/routing/routes.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_routing_extensions.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/utils/helpers.dart';
import 'package:clients/core/widgets/primary_filled_button.dart';
import 'package:clients/core/widgets/spacers.dart';
import 'package:clients/core/widgets/top_app_bar.dart';
import 'package:clients/features/home/model/doctor.dart';
import 'package:clients/features/home/widgets/appointment_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class SessionBookedScreenArguments {
  final Doctor? doctor;
  final DateTime? date;
  final String? time;
  final double? price;

  const SessionBookedScreenArguments({
    this.doctor,
    this.date,
    this.time,
    this.price,
  });
}

class SessionBookedScreen extends StatelessWidget {
  const SessionBookedScreen({super.key, required this.arguments});

  final SessionBookedScreenArguments arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        widget: Text(
          context.tr(LocaleKeys.request_an_appointment),
          style: TextStyles.size24Weight600.copyWith(
            color: context.colors.primaryTextColor,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      Assets.assetsSuccessLottie,
                      width: 100.w,
                      height: 100.h,
                    ),
                    VerticalSpacer(8.h),
                    Text(
                      context.tr(LocaleKeys.payment_confirmed),
                      style: TextStyles.size20Weight600.copyWith(
                        color: context.colors.primaryTextColor,
                      ),
                    ),
                    VerticalSpacer(34.h),
                    DoctorCard(
                      doctor: arguments.doctor!,
                      showBackground: true,
                      borderColor: context.colors.primaryCTAColor,
                    ),
                    VerticalSpacer(24.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        color: context.colors.textBackground,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.assetsBlueDateIcon,
                            width: 16.w,
                            height: 16.h,
                          ),
                          HorizontalSpacer(4.w),
                          Text(
                            Helpers.formatDate(arguments.date!),
                            style: TextStyles.size16Weight500.copyWith(
                              color: context.colors.primaryTextColor,
                            ),
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            Assets.assetsBlueTimeIcon,
                            width: 16.w,
                            height: 16.h,
                          ),
                          HorizontalSpacer(4.w),
                          Text(
                            arguments.time!,
                            style: TextStyles.size16Weight500.copyWith(
                              color: context.colors.primaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    VerticalSpacer(10.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        color: context.colors.textBackground,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            Assets.assetsPriceIcon,
                            width: 16.w,
                            height: 16.h,
                          ),
                          HorizontalSpacer(4.w),
                          Text(
                            '${context.tr(LocaleKeys.total_amount)}: ${arguments.price!.toStringAsFixed(2)} ${context.tr(LocaleKeys.egp)}',
                            style: TextStyles.size16Weight500.copyWith(
                              color: context.colors.primaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PrimaryFilledButton(
              text: context.tr(LocaleKeys.view_my_appointments),
              onClick: () {
                context.pushNamedAndRemoveUntil(
                  Routes.mainLayout,
                  arguments: 2,
                );
              },
              borderRadius: 16.r,
            ),
          ],
        ),
      ),
    );
  }
}
