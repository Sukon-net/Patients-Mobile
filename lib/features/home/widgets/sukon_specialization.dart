import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/routing/routes.dart';
import 'package:clients/core/utils/extensions/context_routing_extensions.dart';
import 'package:clients/features/home/model/specialization.dart';
import 'package:clients/features/home/widgets/therapy_specialization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../specializations_filter/presentation/specializations_filter_screen.dart';

class SukonSpecialization extends StatelessWidget {
  const SukonSpecialization({super.key, required this.specializations});

  final List<Specialization> specializations;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 255.h,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
          mainAxisExtent: 125.h,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          if (index == 5 && specializations.length > 6) {
            return TherapySpecialization(
              specialization: Specialization(
                id: -1,
                name: context.tr(LocaleKeys.view_all),
              ),
              onClick: () {
                context.pushNamed(
                  Routes.specializationsFilter,
                  arguments: SpecializationsFilterScreenArguments(
                    specializationId: 0,
                    specializations: specializations,
                  ),
                );
              },
            );
          }
          final specialization = specializations[index];
          return TherapySpecialization(
            specialization: specialization,
            onClick: () {
              context.pushNamed(
                Routes.specializationsFilter,
                arguments: SpecializationsFilterScreenArguments(
                  specializationId: specialization.id,
                  specializations: specializations,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
