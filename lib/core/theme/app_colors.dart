import 'dart:ui';

abstract class AppColors {
  abstract final Color primaryCTAColor;
  abstract final Color onPrimaryCTAColor;
  abstract final Color secondaryCTAColor;
  abstract final Color onSecondaryCTAColor;
  abstract final Color primaryBackgroundColor;
  abstract final Color primaryTextColor;
  abstract final Color secondaryTextColor;
  abstract final Color accentTextColor;
  abstract final Color borderColor;
  abstract final Color errorColor;
  abstract final Color errorAccentColor;
  abstract final Color dividerColor;
}

class LightAppColors extends AppColors {
  @override
  final Color primaryCTAColor = const Color(0xFF14A5F8);

  @override
  final Color onPrimaryCTAColor = const Color(0xFFFFFFFF);

  @override
  final Color secondaryCTAColor = const Color(0xFFFFFFFF);

  @override
  final Color onSecondaryCTAColor = const Color(0xFF343434);

  @override
  final Color primaryBackgroundColor = const Color(0xFFFFFFFF);

  @override
  final Color primaryTextColor = const Color(0xFF121217);

  @override
  final Color secondaryTextColor = const Color(0xFF222744);

  @override
  final Color accentTextColor = const Color(0xFF6C6C89);

  @override
  final Color borderColor = const Color(0xFFD1D1DB);

  @override
  final Color errorColor = const Color(0xFFAF1208);

  @override
  final Color errorAccentColor = const Color(0xFFFFF1F0);

  @override
  final Color dividerColor = const Color(0xFFA9A9BC);
}

class DarkAppColors extends AppColors {
  @override
  final Color primaryCTAColor = const Color(0xFF14A5F8);

  @override
  final Color onPrimaryCTAColor = const Color(0xFFFFFFFF);

  @override
  final Color secondaryCTAColor = const Color(0xFFFFFFFF);

  @override
  final Color onSecondaryCTAColor = const Color(0xFF343434);

  @override
  final Color primaryBackgroundColor = const Color(0xFFFFFFFF);

  @override
  final Color primaryTextColor = const Color(0xFF121217);

  @override
  final Color secondaryTextColor = const Color(0xFF222744);

  @override
  final Color accentTextColor = const Color(0xFF6C6C89);

  @override
  final Color borderColor = const Color(0xFFD1D1DB);

  @override
  final Color errorColor = const Color(0xFFAF1208);

  @override
  final Color errorAccentColor = const Color(0xFFFFF1F0);

  @override
  final Color dividerColor = const Color(0xFFA9A9BC);
}
