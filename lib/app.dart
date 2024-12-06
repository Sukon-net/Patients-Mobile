import 'package:clients/core/flavors/flavor_config.dart';
import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/features/onboarding/onboarding_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      theme: ThemeData(
        primaryColor: context.colors.primaryCTAColor,
        scaffoldBackgroundColor: context.colors.primaryBackgroundColor,
        fontFamily: "IBMSans",
      ),
      onGenerateTitle: (context) => context.tr(LocaleKeys.app_name),
      debugShowCheckedModeBanner: FlavorConfig.isDevelopment(),
      home: const OnboardingScreen(),
    );
  }
}
