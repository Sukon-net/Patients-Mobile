import 'package:clients/core/di/dependency_container.dart';
import 'package:clients/core/flavors/flavor_config.dart';
import 'package:clients/core/test_localizations.dart';
import 'package:clients/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

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
      ),
      onGenerateTitle: (context) => context.tr(LocaleKeys.app_name),
      debugShowCheckedModeBanner: FlavorConfig.isDevelopment(),
      home: const Scaffold(
        body: TestingWidget(),
      ),
    );
  }
}
