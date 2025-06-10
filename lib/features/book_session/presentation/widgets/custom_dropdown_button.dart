import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/assets.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    required this.dropdownValue,
    required this.itemsList,
    required this.onChange,
  });

  final String? dropdownValue;
  final List<String> itemsList;
  final void Function(String? value) onChange;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        value: dropdownValue,
        hint: Text(
          context.tr(LocaleKeys.choose),
          style: TextStyles.size14Weight500.copyWith(
            color: context.colors.grayColor,
          ),
        ),
        items: itemsList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(
              value,
              style: TextStyles.size14Weight500.copyWith(
                color: context.colors.onSecondaryCTAColor,
              ),
            ),
          );
        }).toList(),
        onChanged: onChange,
        iconStyleData: IconStyleData(
          icon: SvgPicture.asset(
            Assets.assetsBottomArrowIcon,
          ),
        ),
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: context.colors.blackWith10Opacity),
          ),
          padding: EdgeInsetsDirectional.only(start: 16.w, end: 8.w),
          width: MediaQuery.of(context).size.width / 2 - 24,
          height: 48.h,
        ),
        dropdownStyleData: DropdownStyleData(
          elevation: 0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: context.colors.blackWith10Opacity),
          ),
        ),
      ),
    );
  }
}
