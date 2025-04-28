import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../routing/navigator_service.dart';
import '../theme/text_styles.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.iconPath, required this.label});

  final String iconPath;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(iconPath),
        Text(
          label,
          style: TextStyles.size12Weight400.copyWith(
            color: NavigatorService.context.colors.onSecondaryBorderColor,
          ),
        )
      ],
    );
  }
}
