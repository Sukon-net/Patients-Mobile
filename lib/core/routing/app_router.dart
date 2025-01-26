import 'package:clients/core/routing/routes.dart';
import 'package:clients/features/auth/OTP/logic/otp_cubit.dart';
import 'package:clients/features/auth/OTP/presentation/otp_screen.dart';
import 'package:clients/features/auth/complete%20profile/logic/complete_profile_cubit.dart';
import 'package:clients/features/auth/complete%20profile/presentation/complete_profile_screen.dart';
import 'package:clients/features/auth/login/logic/login_cubit.dart';
import 'package:clients/features/auth/login/presentation/login_screen.dart';
import 'package:clients/features/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  const AppRouter._();

  static Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => LoginCubit(),
            child: const LoginScreen(),
          ),
        );
      case Routes.otp:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => OtpCubit(),
            child: const OtpScreen(),
          ),
        );
      case Routes.completeProfile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => CompleteProfileCubit(),
            child: const CompleteProfileScreen(),
          ),
        );
      case Routes.home:
        return MaterialPageRoute(builder: (_) => Container());
      default:
        return _buildInvalidRoute(settings);
    }
  }

  static MaterialPageRoute _buildInvalidRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text('No route defined for ${settings.name}'),
        ),
      );
    });
  }
}
