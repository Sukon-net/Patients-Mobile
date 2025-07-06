import 'dart:core';

import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/routing/navigator_service.dart';
import 'package:clients/core/routing/routes.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/widgets/custom_error_widget.dart';
import 'package:clients/core/widgets/multiline_text_field.dart';
import 'package:clients/core/widgets/primary_filled_button.dart';
import 'package:clients/core/widgets/shimmers/box_shimmer.dart';
import 'package:clients/core/widgets/spacers.dart';
import 'package:clients/core/widgets/top_app_bar.dart';
import 'package:clients/features/book_session/presentation/widgets/custom_available_slots.dart';
import 'package:clients/features/book_session/presentation/widgets/custom_calender.dart';
import 'package:clients/features/book_session/presentation/widgets/custom_dropdown_button.dart';
import 'package:clients/features/book_session/presentation/widgets/loading_available_slots.dart';
import 'package:clients/features/home/widgets/appointment_card.dart';
import 'package:clients/features/payment/presentation/payment_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/toastifications.dart';
import '../../home/model/doctor.dart';
import '../logic/book_session_cubit.dart';

class BookSessionScreen extends StatelessWidget {
  BookSessionScreen({
    super.key,
    required this.doctor,
  });

  final Doctor doctor;
  final List<String> sessionDurationList = [
    "30 ${NavigatorService.context.tr(LocaleKeys.minute)}",
    "60 ${NavigatorService.context.tr(LocaleKeys.minute)}",
  ];

  @override
  Widget build(BuildContext context) {
    final backgroundColor = context.colors.errorAccentColor;
    final textColor = context.colors.primaryTextColor;
    final borderColor = context.colors.errorColor;

    return Scaffold(
      appBar: TopAppBar(
        widget: Text(
          context.tr(LocaleKeys.request_an_appointment),
          style: TextStyles.size24Weight600.copyWith(
            color: context.colors.primaryTextColor,
          ),
        ),
      ),
      body: BlocConsumer<BookSessionCubit, BookSessionState>(
        listener: (context, state) {
          if (state.availableDaysStatus == AvailableDaysStatues.error ||
              state.availableSlotsStatus == AvailableSlotsStatues.error) {
            Toastifications.show(
              context: context,
              message: state.errorMessage,
              textColor: textColor,
              borderColor: borderColor,
              backgroundColor: backgroundColor,
            );
          }
          if (state.status == BookSessionStatus.success) {
            NavigatorService.pushReplacementNamed(Routes.sessionBooked);
          }
        },
        builder: (context, state) {
          final availableDays = state.availableDays ?? [];
          String? dropdownValue = state.selectedDuration;
          final bool showAvailableSlots =
              state.selectedDate != null && state.selectedDuration != null;

          if (state.status == BookSessionStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: EdgeInsetsDirectional.symmetric(
              vertical: 16.h,
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(horizontal: 24.w),
                          child: DoctorCard(
                            doctor: doctor,
                            borderColor: context.colors.primaryCTAColor,
                            showBackground: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            top: 24.h,
                            bottom: 8.h,
                            start: 24.w,
                            end: 24.w,
                          ),
                          child: Text(
                            context.tr(LocaleKeys.choose_an_appointment),
                            style: TextStyles.size14Weight500.copyWith(
                              color: context.colors.subTitleGray,
                            ),
                          ),
                        ),
                        if (state.availableDaysStatus ==
                            AvailableDaysStatues.loading) ...[
                          Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 24.w),
                            child: Row(
                              spacing: 16.w,
                              children: [
                                ...List.generate(
                                  5,
                                  (index) => BoxShimmer(
                                    width: 54.w,
                                    height: 68.h,
                                    borderRadius: 12.r,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        if (state.availableDaysStatus ==
                            AvailableDaysStatues.success) ...[
                          if (availableDays.isEmpty) ...[
                            Padding(
                              padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: 24.w),
                              child: CustomErrorWidget(
                                width: double.infinity,
                                height: 68.h,
                                text: context
                                    .tr(LocaleKeys.not_available_days_message),
                              ),
                            ),
                          ] else ...[
                            CustomCalender(
                              availableDays: availableDays,
                              selectedDate: state.selectedDate,
                              onDaySelected: (date) {
                                context
                                    .read<BookSessionCubit>()
                                    .onSelectDate(date);
                                if (state.selectedDuration != null) {
                                  context
                                      .read<BookSessionCubit>()
                                      .getDoctorAvailableSlots();
                                }
                              },
                            ),
                          ],
                        ],
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            top: 16.h,
                            bottom: 8.h,
                            start: 24.w,
                            end: 24.w,
                          ),
                          child: Text(
                            context.tr(LocaleKeys.session_duration),
                            style: TextStyles.size14Weight500.copyWith(
                              color: context.colors.subTitleGray,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(horizontal: 24.w),
                          child: CustomDropdownButton(
                            dropdownValue: dropdownValue,
                            itemsList: sessionDurationList,
                            onChange: (String? value) {
                              if (value != null) {
                                context
                                    .read<BookSessionCubit>()
                                    .onSelectDuration(value);
                                if (state.selectedDate != null) {
                                  context
                                      .read<BookSessionCubit>()
                                      .getDoctorAvailableSlots();
                                }
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(horizontal: 24.w),
                          child: AnimatedSwitcher(
                            duration: const Duration(seconds: 1),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, -0.1),
                                  end: Offset.zero,
                                ).animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeOut,
                                  ),
                                ),
                                child: child,
                              );
                            },
                            child: showAvailableSlots
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(
                                          top: 24.h,
                                          bottom: 8.h,
                                        ),
                                        child: Text(
                                          context
                                              .tr(LocaleKeys.available_slots),
                                          style: TextStyles.size14Weight500
                                              .copyWith(
                                            color: context.colors.subTitleGray,
                                          ),
                                        ),
                                      ),
                                      if (state.availableSlotsStatus ==
                                          AvailableSlotsStatues.loading) ...[
                                        const LoadingAvailableSlots(),
                                      ],
                                      if (state.availableSlotsStatus ==
                                          AvailableSlotsStatues.success) ...[
                                        if (state.availableSlots!.isEmpty) ...[
                                          CustomErrorWidget(
                                            width: double.infinity,
                                            height: 100.h,
                                            text: context.tr(
                                              LocaleKeys
                                                  .not_available_slots_message,
                                            ),
                                          )
                                        ] else ...[
                                          CustomAvailableSlots(
                                            availableSlots: List.generate(
                                              state.availableSlots!.length,
                                              (index) {
                                                return state
                                                    .availableSlots![index]
                                                    .convertStartTo12Hour();
                                              },
                                            ),
                                            selectedSlot: state.selectedSlot,
                                            onSlotSelected: (String? slot) {
                                              if (slot != null) {
                                                context
                                                    .read<BookSessionCubit>()
                                                    .onSelectSlot(slot);
                                              }
                                            },
                                          ),
                                        ]
                                      ]
                                    ],
                                  )
                                : SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                  ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            top: 20.h,
                            bottom: 8.h,
                            start: 24.w,
                            end: 24.w,
                          ),
                          child: Text(
                            context.tr(LocaleKeys.complaint),
                            style: TextStyles.size14Weight500.copyWith(
                              color: context.colors.subTitleGray,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(horizontal: 24.w),
                          child: MultilineTextField(
                            height: 120.h,
                            controller: context
                                .read<BookSessionCubit>()
                                .complainController,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                      top: 16.h, start: 24.w, end: 24.w),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "${doctor.sessionEGPPrice} ${context.tr(LocaleKeys.egp)} ${context.tr(LocaleKeys.back_slash)} 30 ${context.tr(LocaleKeys.minute)}   |   ${doctor.sessionEGPPrice! * 2} ${context.tr(LocaleKeys.egp)} ${context.tr(LocaleKeys.back_slash)} 60 ${context.tr(LocaleKeys.minute)}",
                      style: TextStyles.size14Weight500.copyWith(
                        color: context.colors.primaryTextColor,
                      ),
                    ),
                  ),
                ),
                VerticalSpacer(8.h),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
                  child: PrimaryFilledButton(
                    text: context.tr(LocaleKeys.book_an_appointment),
                    onClick: () async {
                      if (state.selectedDate == null ||
                          state.selectedDuration == null ||
                          state.selectedSlot == null) {
                        Toastifications.show(
                          context: context,
                          message: context
                              .tr(LocaleKeys.please_choose_date_and_duration),
                          textColor: textColor,
                          borderColor: borderColor,
                          backgroundColor: backgroundColor,
                        );
                      } else {
                        final paymentResult = await NavigatorService.pushNamed(
                          Routes.payment,
                          arguments: PaymentScreenArguments(
                            amount: state.selectedDuration ==
                                    sessionDurationList.first
                                ? doctor.sessionEGPPrice!
                                : doctor.sessionEGPPrice! * 2,
                            shouldShowSukonWallet: true,
                          ),
                        );
                        if (paymentResult == true) {
                          context.read<BookSessionCubit>().bookSession();
                        }
                      }
                    },
                    borderRadius: 16.r,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
