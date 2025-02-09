import 'package:clients/core/constants/assets.dart';
import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/utils/helpers.dart';
import 'package:clients/core/widgets/spacers.dart';
import 'package:clients/features/home/model/appointment.dart';
import 'package:clients/features/home/model/top_rated.dart';
import 'package:clients/features/home/widgets/analysis_card.dart';
import 'package:clients/features/home/widgets/custom_avatar.dart';
import 'package:clients/features/home/widgets/private_widgets/ad_area.dart';
import 'package:clients/features/home/widgets/search_text_form_field.dart';
import 'package:clients/features/home/widgets/therapy_category.dart';
import 'package:clients/features/home/widgets/upcoming_app_card.dart';
import 'package:clients/features/model/user.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

part '../widgets/private_widgets/analysis_widget.dart';
part '../widgets/private_widgets/sukon_categories.dart';
part '../widgets/private_widgets/top_rated_widget.dart';
part '../widgets/private_widgets/upcoming_appointments.dart';
part '../widgets/private_widgets/welcome_widget.dart';

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
      doctorName: "دكتور احمد حمدي",
      sessionType: "اونلاين",
      therapyType: "الجلسة الاسبوعية للأسرة",
      startTime: "09:15",
      endTime: "10:10",
      dayTime: "15/05/23",
    ),
  );

  //Dummy Top Rated
  final List<TopRated> _topRates = List.generate(
    5,
    (index) => TopRated(
      avatar: "",
      doctorName: "دكتور أحمد حمدي",
      doctorTittle: "استشاري أمراض النفسية و العصبية و علاج الأدمان",
      category: "الطب النفسي العام",
      appointments: 2,
      numOfComments: 230,
      numOfExperiences: 12,
      rated: 2.9,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: _WelcomeWidget(
                    name: 'فريدة',
                    onNotificationClicked: () {},
                    gender: Gender.female,
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
                  child: _SukonCategories(
                    onSukonCategoriesClicked: () {},
                  ),
                ),
                AdArea(
                  width: MediaQuery.of(context).size.width,
                  height: 159.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  child: _UpcomingAppointments(
                    appointments: _appointments,
                    onUpcomingAppClicked: () {},
                    onViewDetailsClicked: () {},
                    onSeeMoreIconClicked: () {},
                  ),
                ),
                Text(
                  LocaleKeys.our_top_rated_partners.tr(),
                  style: TextStyles.size20Weight600.copyWith(
                    color: context.colors.primaryTextColor,
                  ),
                ),
                _TopRatedWidget(topRates: _topRates),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.assetsHomeIcon),
            label: LocaleKeys.home.tr(),
            activeIcon: SvgPicture.asset(Assets.assetsHomeActiveIcon),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.assetsSearchNavBarIcon),
            label: LocaleKeys.search.tr(),
            activeIcon: SvgPicture.asset(Assets.assetsSearchNavBarActiveIcon),
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
