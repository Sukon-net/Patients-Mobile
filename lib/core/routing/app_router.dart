import 'package:clients/core/routing/routes.dart';
import 'package:clients/features/auth/OTP/logic/otp_cubit.dart';
import 'package:clients/features/auth/OTP/presentation/otp_screen.dart';
import 'package:clients/features/auth/complete%20profile/logic/complete_profile_cubit.dart';
import 'package:clients/features/auth/complete%20profile/presentation/complete_profile_screen.dart';
import 'package:clients/features/auth/login/logic/login_cubit.dart';
import 'package:clients/features/auth/login/presentation/login_screen.dart';
import 'package:clients/features/doctor_info/logic/doctor_info_cubit.dart';
import 'package:clients/features/doctor_info/presentation/doctor_info_screen.dart';
import 'package:clients/features/home/logic/home_cubit.dart';
import 'package:clients/features/home/presentation/home_screen.dart';
import 'package:clients/features/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/specializations_filter/logic/specializations_filter_cubit.dart';
import '../../features/specializations_filter/presentation/specializations_filter_screen.dart';
import '../di/dependency_container.dart';

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
            create: (BuildContext context) => LoginCubit(sl()),
            child: const LoginScreen(),
          ),
        );
      case Routes.otp:
        final emailAddress = arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                OtpCubit(sl(), emailAddress)..startTimer(),
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
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                HomeCubit(sl())..getSpecializations(),
            child: const HomeScreen(),
          ),
        );
      case Routes.doctorInfo:
        final doctorId = arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                DoctorInfoCubit(sl())..getDoctorInfo(doctorId),
            child: const DoctorInfoScreen(),
          ),
        );
      case Routes.specializationsFilter:
        final screenArguments =
            arguments as SpecializationsFilterScreenArguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => SpecializationsFilterCubit(
                screenArguments.specializationId, sl()),
            child: SpecializationsFilterScreen(
              specializations: screenArguments.specializations,
            ),
          ),
        );
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
