import 'package:clients/core/utils/extensions/context_routing_extensions.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/widgets/spacers.dart';
import 'package:clients/features/specializations_filter/presentation/widgets/specialization_chip.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../core/l10n/generated/locale_keys.g.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/toastifications.dart';
import '../../../core/widgets/custom_error_widget.dart';
import '../../../core/widgets/shimmers/box_shimmer.dart';
import '../../../core/widgets/top_app_bar.dart';
import '../../home/model/specialization.dart';
import '../../home/widgets/upcoming_app_card.dart';
import '../logic/specializations_filter_cubit.dart';

class SpecializationsFilterScreenArguments {
  final int specializationId;
  final List<Specialization> specializations;

  SpecializationsFilterScreenArguments(
      {required this.specializationId, required this.specializations});
}

class SpecializationsFilterScreen extends StatelessWidget {
  SpecializationsFilterScreen({super.key, required this.specializations});

  final List<Specialization> specializations;
  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener _positionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetController _scrollOffsetController =
      ScrollOffsetController();
  final ScrollOffsetListener _scrollOffsetListener =
      ScrollOffsetListener.create();

  @override
  Widget build(BuildContext context) {
    final backgroundColor = context.colors.errorAccentColor;
    final textColor = context.colors.primaryTextColor;
    final borderColor = context.colors.errorColor;

    return Scaffold(
      appBar: TopAppBar(
        widget: Text(
          context.tr(LocaleKeys.specializations_of_sukon),
          style: TextStyles.size24Weight600.copyWith(
            color: context.colors.primaryTextColor,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<SpecializationsFilterCubit, SpecializationsFilterState>(
                buildWhen: (previous, current) =>
                    previous.selectedIndex != current.selectedIndex,
                builder: (context, state) {
                  if (state.selectedIndex >= 0 &&
                      _scrollController.isAttached) {
                    _scrollController.jumpTo(
                      index: state.selectedIndex,
                      alignment: 0.0,
                    );
                  }

                  return SizedBox(
                    height: 80.h,
                    child: ScrollablePositionedList.separated(
                        itemScrollController: _scrollController,
                        itemPositionsListener: _positionsListener,
                        scrollOffsetController: _scrollOffsetController,
                        scrollOffsetListener: _scrollOffsetListener,
                        scrollDirection: Axis.horizontal,
                        itemCount: specializations.length + 1,
                        separatorBuilder: (_, __) => HorizontalSpacer(8.w),
                        itemBuilder: (context, index) {
                          final isAll = index == 0;
                          final name = isAll
                              ? context.tr(LocaleKeys.all)
                              : specializations[index - 1].name;
                          return SpecializationChip(
                              name: name,
                              isSelected: state.selectedIndex == index,
                              onSelected: (_) {
                                context
                                    .read<SpecializationsFilterCubit>()
                                    .changeSelectedIndex(
                                      isAll ? 0 : specializations[index - 1].id,
                                      isAll
                                          ? null
                                          : specializations[index - 1].name,
                                    );
                              });
                        }),
                  );
                }),
            Expanded(
              child: BlocConsumer<SpecializationsFilterCubit,
                  SpecializationsFilterState>(
                listener: (context, state) {
                  if (state.status == SpecializationsFilterStatus.error) {
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
                  final doctors = state.doctors;

                  if (state.status == SpecializationsFilterStatus.loading) {
                    List.generate(
                      3,
                      (index) => Padding(
                        padding: EdgeInsetsDirectional.only(bottom: 16.h),
                        child: BoxShimmer(
                          width: double.infinity,
                          height: 126.h,
                          borderRadius: 12.r,
                        ),
                      ),
                    );
                  }
                  if (state.status == SpecializationsFilterStatus.success) {
                    if (doctors == null || doctors.isEmpty) {
                      CustomErrorWidget(
                        width: 200.h,
                        height: 250.h,
                        text: context
                            .tr(LocaleKeys.error_when_load_doctors_specialized),
                      );
                    } else {
                      return SingleChildScrollView(
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        child: Column(
                          children: [
                            ...List.generate(
                              doctors.length,
                              (index) => Padding(
                                padding:
                                    EdgeInsetsDirectional.only(bottom: 16.h),
                                child: DoctorCard(
                                  doctor: doctors[index],
                                  width: double.infinity,
                                  onTab: () {
                                    context.pushNamed(
                                      Routes.doctorInfo,
                                      arguments: doctors[index].id,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                  return const Center(child: Text("No doctors available"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
