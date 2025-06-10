import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlueArrowBack extends StatelessWidget {
  const BlueArrowBack({super.key, required this.onClicked});

  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onClicked,
      icon: Icon(
        Icons.arrow_forward_ios,
        color: context.colors.primaryCTAColor,
        size: 20.r,
      ),
    );
  }
}
