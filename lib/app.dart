import 'package:clients/core/flavors/flavor_config.dart';
import 'package:clients/core/test_localizations.dart';
import 'package:clients/generated/locale_keys.g.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: "IBMSans",
      ),
      onGenerateTitle: (context) => context.tr(LocaleKeys.app_name),
      debugShowCheckedModeBanner: FlavorConfig.isDevelopment(),
      home: const Scaffold(
        body: TestingWidget(),
      ),
    );
  }
}
