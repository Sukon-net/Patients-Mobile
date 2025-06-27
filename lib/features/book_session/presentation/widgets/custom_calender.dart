import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/spacers.dart';
import 'calender_card.dart';

class CustomCalender extends StatelessWidget {
  const CustomCalender({
    super.key,
    required this.availableDays,
    this.selectedDate,
    this.onDaySelected,
  });

  final List<String> availableDays;
  final DateTime? selectedDate;
  final Function(DateTime)? onDaySelected;

  List<DateTime> generateAvailableDates(List<String> days) {
    final now = DateTime.now();
    final end = now.add(const Duration(days: 30));
    final result = <DateTime>[];

    for (var date = now;
        date.isBefore(end);
        date = date.add(const Duration(days: 1))) {
      final dayName = DateFormat('EEEE', 'en').format(date);
      if (days.contains(dayName)) {
        result.add(date);
      }
    }
    return result;
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final availableDates = generateAvailableDates(availableDays);
    final locale = context.locale.languageCode;
    return SizedBox(
      height: 68.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
        itemCount: availableDates.length,
        separatorBuilder: (BuildContext context, int index) =>
            HorizontalSpacer(8.w),
        itemBuilder: (BuildContext context, int index) {
          final date = availableDates[index];
          final dayName = DateFormat.E(locale).format(date);
          final dayNumber = locale == 'ar'
              ? DateFormat('MM/dd', locale).format(date)
              : DateFormat('dd/MM', locale).format(date);
          final isSelected =
              selectedDate != null && isSameDay(selectedDate!, date);

          return CalenderCard(
            dayName: dayName,
            dayNumber: dayNumber,
            isSelected: isSelected,
            onClick: () => onDaySelected?.call(date),
          );
        },
      ),
    );
  }
}
