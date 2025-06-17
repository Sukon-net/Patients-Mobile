import 'package:clients/core/flavors/flavor_config.dart';
import 'package:clients/core/routing/app_router.dart';
import 'package:clients/core/routing/navigator_service.dart';
import 'package:clients/core/routing/routes.dart';
import 'package:clients/core/utils/extensions/context_extension.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/features/auth/logic/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';

import 'core/l10n/generated/locale_keys.g.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (state is Authenticated && !state.hasCompletedSignup) {
            NavigatorService.pushNamedAndRemoveUntil(Routes.completeProfile);
          } else if (state is Authenticated && state.hasCompletedSignup) {
            NavigatorService.pushNamedAndRemoveUntil(Routes.home);
          } else if (state is Guest) {
            NavigatorService.pushNamedAndRemoveUntil(Routes.home);
          } else if (state is Unauthenticated) {
            NavigatorService.pushNamedAndRemoveUntil(Routes.onboarding);
          } else if (state is AuthLoading) {
            NavigatorService.pushNamedAndRemoveUntil(Routes.loading);
          } else if (state is AuthError) {
            NavigatorService.pushNamedAndRemoveUntil(Routes.onboarding);
            context.showSnackBar(message: state.message);
          }
        });
      },
      child: MaterialApp(
        navigatorKey: NavigatorService.navigatorKey,
        locale: context.locale,
        localizationsDelegates: [
          ...context.localizationDelegates,
          ...PhoneFieldLocalization.delegates,
        ],
        supportedLocales: context.supportedLocales,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: Routes.loading,
        theme: _buildAppThemeData(context),
        onGenerateTitle: (context) => context.tr(LocaleKeys.app_name),
        debugShowCheckedModeBanner: FlavorConfig.isDevelopment(),
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
