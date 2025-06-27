import 'package:clients/core/constants/assets.dart';
import 'package:clients/core/di/dependency_container.dart';
import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/utils/helpers.dart';
import 'package:clients/core/utils/toastifications.dart';
import 'package:clients/core/widgets/spacers.dart';
import 'package:clients/features/book_session/presentation/widgets/custom_calender.dart';
import 'package:clients/features/home/model/appointment.dart';
import 'package:clients/features/home/model/doctor.dart';
import 'package:clients/features/home/widgets/appointment_card.dart';
import 'package:clients/features/model/user.dart';
import 'package:clients/features/my_appointments/logic/my_appointments_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MyAppointmentsScreen extends StatelessWidget {
  const MyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = context.colors.errorAccentColor;
    final textColor = context.colors.primaryTextColor;
    final borderColor = context.colors.errorColor;

    return BlocProvider(
      create: (context) => MyAppointmentsCubit(sl()),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<MyAppointmentsCubit, MyAppointmentsState>(
            listener: (context, state) {
              if (state.status == MyAppointmentsStatus.error) {
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
              //TODO: don't forget comment
              //final List<Appointment> _appointments = state.appointments ?? [];
              final List<Appointment> _appointments = [
                const Appointment(
                  id: 6,
                  date: "2025-06-23",
                  startTime: "10:30",
                  duration: 30,
                  status: AppointmentsStatus.ongoing,
                  doctor: Doctor(
                    id: 7,
                    firstName: "احمد",
                    role: "دكتور",
                    specializations: [],
                  ),
                  patient: User(),
                ),
                const Appointment(
                  id: 7,
                  date: "2025-06-23",
                  startTime: "11:00",
                  duration: 30,
                  status: AppointmentsStatus.completed,
                  doctor: Doctor(
                    id: 8,
                    firstName: "محمد",
                    role: "دكتور",
                    specializations: [],
                  ),
                  patient: User(),
                ),
                const Appointment(
                  id: 7,
                  date: "2025-06-23",
                  startTime: "11:00",
                  duration: 30,
                  status: AppointmentsStatus.pending,
                  doctor: Doctor(
                    id: 8,
                    firstName: "محمد",
                    role: "دكتور",
                    specializations: [],
                  ),
                  patient: User(),
                ),
                const Appointment(
                  id: 7,
                  date: "2025-06-23",
                  startTime: "11:00",
                  duration: 30,
                  status: AppointmentsStatus.upcoming,
                  doctor: Doctor(
                    id: 8,
                    firstName: "محمد",
                    role: "دكتور",
                    specializations: [],
                  ),
                  patient: User(),
                ),
              ];

              final List<String> separatedPluralAppointments =
                  Helpers.seperateLocalizedPlural(
                LocaleKeys.appointment.plural(_appointments.length),
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 24.w,
                      end: 24.w,
                      top: 8.h,
                      bottom: 4.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.tr(LocaleKeys.my_appointments),
                          style: TextStyles.size24Weight600.copyWith(
                            color: context.colors.primaryTextColor,
                          ),
                        ),
                        InkWell(
                          //TODO: Add filter logic
                          onTap: () {},
                          borderRadius: BorderRadius.circular(50.r),
                          child: Container(
                            padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 10.r,
                              vertical: 12.r,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              border: Border.all(
                                color: context.colors.borderColor,
                              ),
                            ),
                            child: SvgPicture.asset(Assets.assetsFilterIcon),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 24.w),
                    child: Text(
                      Helpers.getNowDayFormatted(),
                      style: TextStyles.size12Weight400.copyWith(
                        color: context.colors.accentTextColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 24.w,
                      top: 6.h,
                      bottom: 20.h,
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: "${context.tr(LocaleKeys.you_have)} ",
                        style: TextStyles.size20Weight600.copyWith(
                          color: context.colors.primaryTextColor,
                        ),
                        children: [
                          if (separatedPluralAppointments[0].trim().isNotEmpty)
                            TextSpan(
                              text: "${separatedPluralAppointments[0]} ",
                              style: TextStyles.size20Weight600.copyWith(
                                color: context.colors.primaryCTAColor,
                              ),
                            ),
                          TextSpan(
                            text: separatedPluralAppointments[1],
                            style: TextStyles.size20Weight600.copyWith(
                              color: _appointments.length < 3
                                  ? context.colors.primaryCTAColor
                                  : context.colors.primaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomCalender(
                    availableDays: const [
                      'Saturday',
                      'Sunday',
                      'Monday',
                      'Tuesday',
                      'Wednesday',
                      'Thursday',
                      'Friday',
                    ],
                    selectedDate: DateTime.now(),
                  ),
                  VerticalSpacer(8.h),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 24.h,
                        vertical: 12.h,
                      ),
                      itemBuilder: (BuildContext context, int index) =>
                          AppointmentCard(
                        appointment: _appointments[index],
                        isMyAPPointmentsCard: true,
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          VerticalSpacer(16.h),
                      itemCount: _appointments.length,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
