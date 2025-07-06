import 'dart:ui';

abstract class AppColors {
  abstract final Color primaryCTAColor;
  abstract final Color onPrimaryCTAColor;
  abstract final Color disabledPrimaryCTAColor;
  abstract final Color secondaryCTAColor;
  abstract final Color onSecondaryCTAColor;
  abstract final Color primaryBackgroundColor;
  abstract final Color primaryTextColor;
  abstract final Color secondaryTextColor;
  abstract final Color accentTextColor;
  abstract final Color subTextColor;
  abstract final Color borderColor;
  abstract final Color disabledBackgroundColor;
  abstract final Color errorColor;
  abstract final Color errorAccentColor;
  abstract final Color dividerColor;
  abstract final Color imgBorderColor;
  abstract final Color secondaryBorderColor;
  abstract final Color onSecondaryBorderColor;
  abstract final Color navBarLabel;
  abstract final Color secondaryBackgroundColor;
  abstract final Color primaryProgressColor;
  abstract final Color secondaryProgressColor;
  abstract final Color backgroundSpecializationIconColor;
  abstract final Color secondaryCTABackgroundColor;
  abstract final Color blackWith10Opacity;
  abstract final Color addToFavBackground;
  abstract final Color addToFavBorder;
  abstract final Color yellowStarColor;
  abstract final Color unRatedStarColor;
  abstract final Color readHeartColor;
  abstract final Color grayColor;
  abstract final Color whiteWith40Opacity;
  abstract final Color subTitleGray;
  abstract final Color inactiveCalenderCard;
  abstract final Color appCardBackground;
  Color appCardBorder = const Color(0x26979798);
  abstract final List<Color> adGradientColors;
  abstract final Color paymentMethodBorderColor;
  abstract final Color paymentMethodBackgroundColor;
}

class LightAppColors extends AppColors {
  @override
  final Color primaryCTAColor = const Color(0xFF14A5F8);

  @override
  final Color onPrimaryCTAColor = const Color(0xFFFFFFFF);

  @override
  final Color secondaryCTAColor = const Color(0xFFFFFFFF);

  @override
  final Color onSecondaryCTAColor = const Color(0xFF404040);

  @override
  final Color primaryBackgroundColor = const Color(0xFFFFFFFF);

  @override
  final Color primaryTextColor = const Color(0xFF282833);

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

  @override
  final Color disabledPrimaryCTAColor = const Color(0xFFB8E3FF);

  @override
  final Color disabledBackgroundColor = const Color(0xFFF7F7F8);

  @override
  final Color subTextColor = const Color(0xFF8E8E8E);

  @override
  final Color imgBorderColor = const Color(0xFF1C3E7F);

  @override
  final Color secondaryBorderColor = const Color(0xFFEBEBEF);

  @override
  final Color onSecondaryBorderColor = const Color(0xFF55556D);

  @override
  final Color navBarLabel = const Color(0xFF8A8AA3);

  @override
  final Color secondaryBackgroundColor = const Color(0xFF52FFB8);

  @override
  final Color primaryProgressColor = const Color(0xFF0061A6);

  @override
  final Color secondaryProgressColor = const Color(0x3B14A5F8);

  @override
  final Color backgroundSpecializationIconColor = const Color(0xFFF7F7F8);

  @override
  final Color appCardBackground = const Color(0xFFF9F9FA);

  @override
  final List<Color> adGradientColors = [
    const Color(0xFFEBEBEF),
    const Color(0xFFF7F7F8),
  ];

  @override
  final Color secondaryCTABackgroundColor = const Color(0xFFDFF0FF);

  @override
  final Color blackWith10Opacity = const Color(0x1A000000);

  @override
  final Color addToFavBackground = const Color(0xFFEEF7F9);

  @override
  final Color addToFavBorder = const Color(0xFFE0E2E3);

  @override
  final Color yellowStarColor = const Color(0xFFFFC233);

  @override
  final Color unRatedStarColor = const Color(0xFFDDDDDD);

  @override
  final Color readHeartColor = const Color(0xFFFF6462);

  @override
  final Color grayColor = const Color(0xFFAAAAAA);

  @override
  final Color whiteWith40Opacity = const Color(0x66FFFFFF);

  @override
  final Color subTitleGray = const Color(0xFF808080);

  @override
  final Color inactiveCalenderCard = const Color(0xFFF9F9F9);

  @override
  final Color paymentMethodBorderColor = const Color(0x1A868686);

  @override
  final Color paymentMethodBackgroundColor = const Color(0xFFFBFBFB);
}

class DarkAppColors extends AppColors {
  @override
  final Color primaryCTAColor = const Color(0xFF14A5F8);

  @override
  final Color onPrimaryCTAColor = const Color(0xFFFFFFFF);

  @override
  final Color secondaryCTAColor = const Color(0xFFFFFFFF);

  @override
  final Color onSecondaryCTAColor = const Color(0xFF404040);

  @override
  final Color primaryBackgroundColor = const Color(0xFFFFFFFF);

  @override
  final Color primaryTextColor = const Color(0xFF282833);

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

  @override
  final Color disabledPrimaryCTAColor = const Color(0xFFB8E3FF);

  @override
  final Color disabledBackgroundColor = const Color(0xFFF7F7F8);

  @override
  final Color subTextColor = const Color(0xFF8E8E8E);

  @override
  final Color imgBorderColor = const Color(0xFF1C3E7F);

  @override
  final Color secondaryBorderColor = const Color(0xFFEBEBEF);

  @override
  final Color onSecondaryBorderColor = const Color(0xFF55556D);

  @override
  final Color navBarLabel = const Color(0xFF8A8AA3);

  @override
  final Color secondaryBackgroundColor = const Color(0xFF52FFB8);

  @override
  final Color primaryProgressColor = const Color(0xFF0061A6);

  @override
  final Color secondaryProgressColor = const Color(0x3B14A5F8);

  @override
  final Color backgroundSpecializationIconColor = const Color(0xFFF7F7F8);

  @override
  final Color appCardBackground = const Color(0xFFF9F9FA);

  @override
  final List<Color> adGradientColors = [
    const Color(0xFFEBEBEF),
    const Color(0xFFF7F7F8),
  ];

  @override
  final Color secondaryCTABackgroundColor = const Color(0xFFDFF0FF);

  @override
  final Color blackWith10Opacity = const Color(0x1A000000);

  @override
  final Color addToFavBackground = const Color(0xFFEEF7F9);

  @override
  final Color addToFavBorder = const Color(0xFFE0E2E3);

  @override
  final Color yellowStarColor = const Color(0xFFFFC233);

  @override
  final Color unRatedStarColor = const Color(0xFFDDDDDD);

  @override
  final Color readHeartColor = const Color(0xFFFF6462);

  @override
  final Color grayColor = const Color(0xFFAAAAAA);

  @override
  final Color whiteWith40Opacity = const Color(0x66FFFFFF);

  @override
  final Color subTitleGray = const Color(0xFF808080);

  @override
  final Color inactiveCalenderCard = const Color(0xFFF9F9F9);

  @override
  final Color paymentMethodBorderColor = const Color(0x1A868686);

  @override
  final Color paymentMethodBackgroundColor = const Color(0xFFFBFBFB);
}
