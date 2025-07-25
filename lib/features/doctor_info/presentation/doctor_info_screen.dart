import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/routing/routes.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_routing_extensions.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/utils/extensions/num_duration_extensions.dart';
import 'package:clients/core/widgets/add_to_favourite.dart';
import 'package:clients/core/widgets/loading_widget.dart';
import 'package:clients/core/widgets/primary_filled_button.dart';
import 'package:clients/core/widgets/top_app_bar.dart';
import 'package:clients/features/doctor_info/logic/doctor_info_cubit.dart';
import 'package:clients/features/doctor_info/widgets/popular_spe_widget.dart';
import 'package:clients/features/doctor_info/widgets/rating_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:see_more/see_more.dart';

import '../../../core/constants/assets.dart';
import '../../../core/utils/toastifications.dart';
import '../../../core/widgets/custom_avatar.dart';
import '../../../core/widgets/custom_icon.dart';
import '../../../core/widgets/spacers.dart';

class DoctorInfoScreen extends StatelessWidget {
  const DoctorInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = context.colors.errorAccentColor;
    final textColor = context.colors.primaryTextColor;
    final borderColor = context.colors.errorColor;

    return Scaffold(
      appBar: TopAppBar(
        widget: Text(
          context.tr(LocaleKeys.doctor_details),
          style: TextStyles.size24Weight600.copyWith(
            color: context.colors.primaryTextColor,
          ),
        ),
      ),
      body: BlocConsumer<DoctorInfoCubit, DoctorInfoState>(
        listener: (context, state) {
          if (state.status == DoctorInfoStatus.error) {
            Toastifications.show(
              context: context,
              message: state.errorMessage,
              textColor: textColor,
              borderColor: borderColor,
              backgroundColor: backgroundColor,
            );
          }
        },
        builder: (context, state) {
          if (state.status == DoctorInfoStatus.loading) {
            return const LoadingWidget();
          }
          if (state.status == DoctorInfoStatus.success) {
            final doctorInfo = state.doctor;

            return Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 32.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            top: 16.h,
                            bottom: 4.h,
                          ),
                          child: CustomAvatar(
                            imageUrl: doctorInfo!.avatar,
                            radius: 50,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${doctorInfo.title} ${doctorInfo.firstName} ${doctorInfo.lastName}",
                                  style: TextStyles.size18Weight600.copyWith(
                                    color: context.colors.primaryTextColor,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    top: 4.h,
                                    bottom: 11.h,
                                  ),
                                  child: Text(
                                    doctorInfo.role,
                                    style: TextStyles.size12Weight400.copyWith(
                                      color: context.colors.accentTextColor,
                                    ),
                                  ),
                                ),
                                RatingWidget(
                                  ratingValue: doctorInfo.rating ?? 0,
                                ),
                              ],
                            ),
                            AddToFavourite(
                              //TODO: when add to fav clicked
                              isFavourite: state.isFavourite,
                              onTab: () {
                                context
                                    .read<DoctorInfoCubit>()
                                    .onAddToFavClicked();
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                            vertical: 16.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomIcon(
                                iconPath: Assets.assetsAppointmentsIcon,
                                label: LocaleKeys.appointment.plural(
                                    doctorInfo.availableSlotsCount ?? 0),
                              ),
                              VerticalDividerWidget(24.h),
                              CustomIcon(
                                iconPath: Assets.assetsChatIcon,
                                label: "${doctorInfo.comment}",
                              ),
                              VerticalDividerWidget(24.h),
                              CustomIcon(
                                iconPath: Assets.assetsExperienceIcon,
                                label: LocaleKeys.year
                                    .plural(doctorInfo.yearsOfExperience),
                              ),
                            ],
                          ),
                        ),
                        if (doctorInfo.bio != null) ...[
                          Text(
                            context.tr(LocaleKeys.description),
                            style: TextStyles.size16Weight500.copyWith(
                              color: context.colors.primaryTextColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              top: 4.h,
                              bottom: 24.h,
                            ),
                            child: SeeMoreWidget(
                              doctorInfo.bio!,
                              textStyle: TextStyles.size14Weight400.copyWith(
                                color: context.colors.subTextColor,
                              ),
                              seeMoreText: context.tr(LocaleKeys.read_more),
                              seeMoreStyle: TextStyles.size14Weight400.copyWith(
                                color: context.colors.primaryCTAColor,
                              ),
                              seeLessText: context.tr(LocaleKeys.read_less),
                              seeLessStyle: TextStyles.size14Weight400.copyWith(
                                color: context.colors.primaryCTAColor,
                              ),
                              animationDuration: 200.ms,
                              trimLength: 140,
                            ),
                          ),
                        ],
                        Text(
                          context.tr(LocaleKeys.popular_specializations),
                          style: TextStyles.size16Weight500.copyWith(
                            color: context.colors.primaryTextColor,
                          ),
                        ),
                        if (doctorInfo.specializations != null)
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 16.h),
                            child: PopularSpeWidget(
                              specializations: List.generate(
                                doctorInfo.specializations!.length,
                                (index) =>
                                    doctorInfo.specializations![index].name,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 25.5.w,
                  right: 25.5.w,
                  bottom: 34.h,
                  child: PrimaryFilledButton(
                    text: context.tr(LocaleKeys.make_an_appointment),
                    borderRadius: 16.r,
                    onClick: () {
                      context.pushNamed(
                        Routes.bookSession,
                        arguments: state.doctor,
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text("No doctor information available"));
        },
      ),
    );
  }
}
