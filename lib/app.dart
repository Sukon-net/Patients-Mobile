import 'package:clients/core/flavors/flavor_config.dart';
import 'package:clients/core/routing/app_router.dart';
import 'package:clients/core/routing/navigator_service.dart';
import 'package:clients/core/routing/routes.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/features/home/presentation/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

import 'core/l10n/generated/locale_keys.g.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigatorService.navigatorKey,
      locale: context.locale,
      localizationsDelegates: [
        ...context.localizationDelegates,
        ...PhoneFieldLocalization.delegates,
      ],
      supportedLocales: context.supportedLocales,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: Routes.home,
      theme: _buildAppThemeData(context),
      onGenerateTitle: (context) => context.tr(LocaleKeys.app_name),
      debugShowCheckedModeBanner: FlavorConfig.isDevelopment(),
      home: const Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}

ThemeData _buildAppThemeData(BuildContext context) => ThemeData(
      colorScheme: ColorScheme(
        brightness: context.isDarkTheme ? Brightness.dark : Brightness.light,
        primary: context.colors.primaryCTAColor,
        onPrimary: context.colors.onPrimaryCTAColor,
        secondary: context.colors.secondaryCTAColor,
        onSecondary: context.colors.onSecondaryCTAColor,
        error: context.colors.errorAccentColor,
        onError: context.colors.errorColor,
        surface: context.colors.primaryBackgroundColor,
        onSurface: context.colors.primaryTextColor,
      ),
      brightness: context.isDarkTheme ? Brightness.dark : Brightness.light,
      useMaterial3: true,
      fontFamily: "IBMSans",
    );
