import 'package:clients/core/constants/assets.dart';
import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_routing_extensions.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/utils/helpers.dart';
import 'package:clients/core/widgets/custom_avatar.dart';
import 'package:clients/core/widgets/spacers.dart';
import 'package:clients/features/home/logic/home_cubit.dart';
import 'package:clients/features/home/model/appointment.dart';
import 'package:clients/features/home/model/doctor.dart';
import 'package:clients/features/home/model/specialization.dart';
import 'package:clients/features/home/widgets/ad_area.dart';
import 'package:clients/features/home/widgets/analysis_card.dart';
import 'package:clients/features/home/widgets/search_text_form_field.dart';
import 'package:clients/features/home/widgets/sukon_specialization_loading.dart';
import 'package:clients/features/home/widgets/upcoming_app_card.dart';
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
part '../widgets/upcoming_appointments.dart';
part '../widgets/welcome_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //Dummy Appointment
  final List<Appointment> _appointments = List.generate(
    5,
    (index) => Appointment(
      //     doctorName: "دكتور احمد حمدي",
      //     sessionType: "اونلاين",
      //    therapyType: "الجلسة الاسبوعية للأسرة",
      startTime: "09:15",
      endTime: "10:10",
      day: "15/05/23",
    ),
  );

  //Dummy Top Rated
  final List<Doctor> _topRates = List.generate(
    5,
    (index) => Doctor(
      id: 1,
      firstName: 'احمد',
      lastName: 'حمدي',
      role: '$index',
      avatar: '',
      yearOfExperience: '12',
      bio: '',
      specializations: [],
      sessionUSDPrice: 2,
      sessionEGPPrice: 3,
      availableSlots: [],
      title: 'د/',
    ),
  );

  //Dummy Specialization
  final List<Specialization> _dummySpecialization = List.generate(
    6,
    (index) {
      if (index == 4) {
        return Specialization(id: 8, name: LocaleKeys.general_psychiatry.tr());
      }
      return Specialization(
          id: index + 1, name: LocaleKeys.general_psychiatry.tr());
    },
  );

  @override
  Widget build(BuildContext context) {
    final backgroundColor = context.colors.errorAccentColor;
    final textColor = context.colors.primaryTextColor;
    final borderColor = context.colors.errorColor;

    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.specializationsStatus == SpecializationsStatus.error) {
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
                      //TODO: add img and handel on notification clicked
                      child: _WelcomeWidget(
                        name: 'نادين',
                        imgUrl: "",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.specializations_of_sukon.tr(),
                                style: TextStyles.size20Weight600.copyWith(
                                  color: context.colors.primaryTextColor,
                                ),
                              ),
                              IconButton(
                                onPressed: state.specializations != null &&
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
                                    : null,
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: context.colors.primaryCTAColor,
                                  size: 20.r,
                                ),
                              ),
                            ],
                          ),
                          if (state.specializationsStatus ==
                              SpecializationsStatus.error)
                            Padding(
                              padding: EdgeInsetsDirectional.only(top: 12.h),
                              child: CustomErrorWidget(
                                width: double.infinity,
                                height: 250.h,
                                text: context.tr(
                                    LocaleKeys.error_when_load_specialization),
                              ),
                            )
                          else if (state.specializationsStatus ==
                              SpecializationsStatus.success)
                            Padding(
                              padding: EdgeInsetsDirectional.only(top: 8.h),
                              child: SukonSpecialization(
                                specializations: state.specializations!,
                              ),
                            )
                          else
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
                    Padding(
                      padding: EdgeInsets.only(top: 24.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.upcoming_appointments.tr(),
                            style: TextStyles.size20Weight600.copyWith(
                              color: context.colors.primaryTextColor,
                            ),
                          ),
                          IconButton(
                            //TODO: we see more appointments clicked
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: context.colors.primaryCTAColor,
                              size: 20.r,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // _UpcomingAppointments(
                    //   doctor: Doctor(
                    //     id: 2,
                    //     firstName: "firstName",
                    //     lastName: "lastName",
                    //     avatar: "avatar",
                    //     yearOfExperience: "yearOfExperiance",
                    //     bio: "bio",
                    //     specializations: [],
                    //     sessionUSDPrice: 0,
                    //     sessionEGPPrice: 0,
                    //     availableSlots: [],
                    //     role: 'دكتور',
                    //     title: 'د/',
                    //   ),
                    //   onViewDetailsClicked: () {},
                    //   onSeeMoreIconClicked: () {},
                    // ),
                    Padding(
                      padding: EdgeInsets.only(top: 24.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.our_top_rated_partners.tr(),
                            style: TextStyles.size20Weight600.copyWith(
                              color: context.colors.primaryTextColor,
                            ),
                          ),
                          IconButton(
                            //TODO: we see more top rated clicked
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: context.colors.primaryCTAColor,
                              size: 20.r,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12.h, bottom: 16.h),
                      child: SizedBox(
                        height: 126.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => DoctorCard(
                            doctor: _topRates[index],
                            width: 300.w,
                            onTab: () {
                              //TODO edit arguments => doctor id
                              context.pushNamed(Routes.doctorInfo,
                                  arguments: 7);
                            },
                          ),
                          separatorBuilder: (context, index) =>
                              HorizontalSpacer(12.w),
                          itemCount: _topRates.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.assetsHomeIcon),
            label: LocaleKeys.home.tr(),
            activeIcon: SvgPicture.asset(Assets.assetsHomeActiveIcon),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.assetsTasksIcon),
            label: LocaleKeys.your_tasks.tr(),
            activeIcon: SvgPicture.asset(Assets.assetsTasksActiveIcon),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.assetsCalendarIcon),
            label: LocaleKeys.calendar.tr(),
            activeIcon: SvgPicture.asset(Assets.assetsCalendarActiveIcon),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.assetsMessagesIcon),
            label: LocaleKeys.messages.tr(),
            activeIcon: SvgPicture.asset(Assets.assetsMessagesActiveIcon),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.assetsMoreIcon),
            label: LocaleKeys.more.tr(),
            activeIcon: SvgPicture.asset(Assets.assetsMoreActiveIcon),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onTab,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: context.colors.primaryCTAColor,
        unselectedItemColor: context.colors.navBarLabel,
        selectedLabelStyle: TextStyles.size12Weight500,
        unselectedLabelStyle: TextStyles.size12Weight400,
      ),
    );
  }
}
