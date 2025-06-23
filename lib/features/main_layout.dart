import 'package:clients/core/constants/assets.dart';
import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/features/home/presentation/home_screen.dart';
import 'package:clients/features/messages/presentation/messages_screen.dart';
import 'package:clients/features/more/presentation/more_screen.dart';
import 'package:clients/features/my_appointments/presentation/my_appointments_screen.dart';
import 'package:clients/features/tasks/presentation/tasks_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const TasksScreen(),
    const MyAppointmentsScreen(),
    const MessagesScreen(),
    const MoreScreen(),
  ];

  void _onTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
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