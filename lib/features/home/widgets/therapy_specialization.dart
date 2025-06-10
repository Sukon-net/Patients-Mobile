import 'package:clients/core/constants/assets.dart';
import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/widgets/shimmers/box_shimmer.dart';
import 'package:clients/core/widgets/shimmers/circle_shimmer.dart';
import 'package:clients/features/home/model/specialization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/text_styles.dart';

class TherapySpecialization extends StatelessWidget {
  const TherapySpecialization({
    super.key,
    required this.specialization,
    required this.onClick,
  });

  final Specialization? specialization;
  final void Function() onClick;

  // id -1 => for view more if there is more than 6 specializations ^_^
  // id 0 => for view all ^_^
  static const _specializationIcons = {
    1: Assets.assetsGeneralPsychiatryIcon,
    2: Assets.assetsMentalDisordersIcon,
    3: Assets.assetsAddictionTreatmentIcon,
    4: Assets.assetsChildrenAndTeenagersIcon,
    5: Assets.assetsFamilyTherapyIcon,
    6: Assets.assetsCognitiveBehavioralIcon,
  };

  @override
  Widget build(BuildContext context) {
    bool isIdExist = _specializationIcons.containsKey(specialization!.id);
    bool isIdViewMore = specialization!.id == -1;

    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onClick,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10.h,
          children: [
            if (specialization != null) ...[
              Container(
                width: 60.w,
                height: 60.h,
                padding: EdgeInsetsDirectional.all(13.r),
                decoration: BoxDecoration(
                  color: isIdViewMore
                      ? context.colors.secondaryCTABackgroundColor
                      : context.colors.backgroundSpecializationIconColor,
                  shape: BoxShape.circle,
                ),
                child: isIdViewMore
                    ? Icon(
                        Icons.arrow_forward,
                        color: context.colors.primaryCTAColor,
                      )
                    : SvgPicture.asset(
                        isIdExist
                            ? _specializationIcons[specialization!.id]!
                            : Assets.assetsSvgLogoBlue,
                      ),
              ),
              Text(
                isIdViewMore
                    ? context.tr(LocaleKeys.view_all)
                    : specialization!.name,
                style: TextStyles.size14Weight400.copyWith(
                  color: context.colors.primaryTextColor,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ] else ...[
              CircleShimmer(size: 60.r),
              BoxShimmer(width: 50.w, height: 12.h),
            ]
          ],
        ),
      ),
    );
  }
}
