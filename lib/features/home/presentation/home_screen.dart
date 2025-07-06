import 'dart:ui';

import 'package:clients/core/constants/assets.dart';
import 'package:clients/core/di/dependency_container.dart';
import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_routing_extensions.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/utils/helpers.dart';
import 'package:clients/core/widgets/blue_arrow_back.dart';
import 'package:clients/core/widgets/custom_avatar.dart';
import 'package:clients/core/widgets/spacers.dart';
import 'package:clients/features/auth/logic/auth_cubit.dart';
import 'package:clients/features/home/logic/home_cubit.dart';
import 'package:clients/features/home/widgets/ad_area.dart';
import 'package:clients/features/home/widgets/analysis_card.dart';
import 'package:clients/features/home/widgets/appointment_card.dart';
import 'package:clients/features/home/widgets/horizontal_cards_loading.dart';
import 'package:clients/features/home/widgets/search_text_form_field.dart';
import 'package:clients/features/home/widgets/sukon_specialization_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/routing/routes.dart';
import '../../../core/utils/toastifications.dart';
import '../../../core/widgets/custom_error_widget.dart';
import '../../specializations_filter/presentation/specializations_filter_screen.dart';
import '../widgets/sukon_specialization.dart';

part '../widgets/analysis_widget.dart';
part '../widgets/welcome_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor = context.colors.errorAccentColor;
    final textColor = context.colors.primaryTextColor;
    final borderColor = context.colors.errorColor;

    return BlocProvider(
      create: (context) => HomeCubit(sl())
        ..getSpecializations()
        ..getTopRatedDoctors()
        ..getUpcomingAppointments(),
      child: Scaffold(
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state.specializationsStatus == SpecializationsStatus.error ||
                state.topRatedDocStatus == TopRatedDocStatus.error ||
                state.appointmentsStatus == AppointmentsStatus.error) {
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
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 16.h),
                        child: _WelcomeWidget(
                          name:
                              context.read<AuthCubit>().currentUser?.firstName,
                          imgUrl: context.read<AuthCubit>().currentUser?.avatar,
                          onNotificationClicked: () {},
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: SearchTextFormField(
                          hint: LocaleKeys.find_what_you_want.tr(),
                        ),
                      ),
                      _AnalysisWidget(
                        dateTime: Helpers.getNowDayFormatted(),
                        achievedTasksOfDay: 4,
                        totalTasksOfDay: 5,
                        appointmentsOfDay: 4,
                        achievedTaskOfWeek: 2,
                        totalTaskOfWeek: 7,
                        onUpdateClicked: () {},
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: Column(
                          children: [
                            if (state.specializationsStatus !=
                                SpecializationsStatus.error)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    LocaleKeys.specializations_of_sukon.tr(),
                                    style: TextStyles.size20Weight600.copyWith(
                                      color: context.colors.primaryTextColor,
                                    ),
                                  ),
                                  BlueArrowBack(
                                    onClicked: () {
                                      state.specializations != null &&
                                              state.specializations!.isNotEmpty
                                          ? () {
                                              context.pushNamed(
                                                Routes.specializationsFilter,
                                                arguments:
                                                    SpecializationsFilterScreenArguments(
                                                  specializationId: 0,
                                                  specializations:
                                                      state.specializations!,
                                                ),
                                              );
                                            }
                                          : null;
                                    },
                                  ),
                                ],
                              ),
                            if (state.specializationsStatus ==
                                SpecializationsStatus.success)
                              Padding(
                                padding: EdgeInsetsDirectional.only(top: 8.h),
                                child: SukonSpecialization(
                                  specializations: state.specializations!,
                                ),
                              )
                            else if (state.specializationsStatus ==
                                SpecializationsStatus.loading)
                              Padding(
                                padding: EdgeInsetsDirectional.only(top: 16.h),
                                child: const SukonSpecializationLoading(),
                              )
                          ],
                        ),
                      ),
                      AdArea(
                        width: MediaQuery.of(context).size.width,
                        height: 159.h,
                      ),
                      if (state.appointmentsStatus !=
                              AppointmentsStatus.error &&
                          state.appointments != null &&
                          state.appointments!.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 24.h, bottom: 8.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.upcoming_appointments.tr(),
                                style: TextStyles.size20Weight600.copyWith(
                                  color: context.colors.primaryTextColor,
                                ),
                              ),

                              //TODO: we see more appointments clicked
                              BlueArrowBack(onClicked: () {}),
                            ],
                          ),
                        ),
                      if (state.appointmentsStatus ==
                          AppointmentsStatus.loading)
                        HorizonalCardsLoading(
                          height: 190.h,
                          width: 260.w,
                        )
                      else if (state.appointmentsStatus ==
                          AppointmentsStatus.success)
                        if (state.appointments != null &&
                            state.appointments!.isNotEmpty)
                          SizedBox(
                            height: 200.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => AppointmentCard(
                                appointment: state.appointments![index],
                                onViewDetailsClicked: () {},
                                width: 280.w,
                              ),
                              separatorBuilder: (context, index) =>
                                  HorizontalSpacer(12.w),
                              itemCount: state.appointments?.length ?? 0,
                            ),
                          ),
                      Padding(
                        padding: EdgeInsets.only(top: 24.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LocaleKeys.our_top_rated_partners.tr(),
                                  style: TextStyles.size20Weight600.copyWith(
                                    color: context.colors.primaryTextColor,
                                  ),
                                ),

                                // TODO: we see more top rated clicked
                                BlueArrowBack(onClicked: () {}),
                              ],
                            ),
                            if (state.topRatedDocStatus ==
                                TopRatedDocStatus.error)
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  top: 12.h,
                                  bottom: 16.h,
                                ),
                                child: CustomErrorWidget(
                                  width: double.infinity,
                                  height: 140.h,
                                  text: context.tr(LocaleKeys
                                      .error_when_load_top_rated_doctors),
                                ),
                              )
                            else if (state.topRatedDocStatus ==
                                TopRatedDocStatus.success)
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 12.h, bottom: 16.h),
                                child: SizedBox(
                                  height: 140.h,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => DoctorCard(
                                      doctor: state.topRatedDoctors![index],
                                      width: 320.w,
                                      onTab: () {
                                        context.pushNamed(
                                          Routes.doctorInfo,
                                          arguments:
                                              state.topRatedDoctors![index].id,
                                        );
                                      },
                                    ),
                                    separatorBuilder: (context, index) =>
                                        HorizontalSpacer(12.w),
                                    itemCount: state.topRatedDoctors!.length,
                                  ),
                                ),
                              )
                            else
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 12.h, bottom: 16.h),
                                child: HorizonalCardsLoading(
                                  height: 130.h,
                                  width: 300.w,
                                ),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
