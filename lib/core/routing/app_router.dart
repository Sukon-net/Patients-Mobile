import 'dart:developer';

import 'package:clients/core/routing/routes.dart';
import 'package:clients/core/widgets/loading_widget.dart';
import 'package:clients/features/auth/OTP/logic/otp_cubit.dart';
import 'package:clients/features/auth/OTP/presentation/otp_screen.dart';
import 'package:clients/features/auth/complete%20profile/logic/complete_profile_cubit.dart';
import 'package:clients/features/auth/complete%20profile/presentation/complete_profile_screen.dart';
import 'package:clients/features/auth/login/logic/login_cubit.dart';
import 'package:clients/features/auth/login/presentation/login_screen.dart';
import 'package:clients/features/book_session/logic/book_session_cubit.dart';
import 'package:clients/features/book_session/presentation/book_session_screen.dart';
import 'package:clients/features/book_session/presentation/session_booked_screen.dart';
import 'package:clients/features/doctor_info/logic/doctor_info_cubit.dart';
import 'package:clients/features/doctor_info/presentation/doctor_info_screen.dart';
import 'package:clients/features/main_layout.dart';
import 'package:clients/features/onboarding/onboarding_screen.dart';
import 'package:clients/features/payment/logic/payment_cubit.dart';
import 'package:clients/features/payment/presentation/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/model/doctor.dart';
import '../../features/specializations_filter/logic/specializations_filter_cubit.dart';
import '../../features/specializations_filter/presentation/specializations_filter_screen.dart';
import '../di/dependency_container.dart';

class AppRouter {
  const AppRouter._();

  static Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    log("App Router: ${settings.name}");

    switch (settings.name) {
      case Routes.onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
          settings: settings,
        );

      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => LoginCubit(sl()),
            child: const LoginScreen(),
          ),
          settings: settings,
        );

      /// need email address as arguments
      case Routes.otp:
        final emailAddress = arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                OtpCubit(sl(), emailAddress)..startTimer(),
            child: const OtpScreen(),
          ),
          settings: settings,
        );

      case Routes.completeProfile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => CompleteProfileCubit(sl()),
            child: const CompleteProfileScreen(),
          ),
          settings: settings,
        );

      case Routes.mainLayout:
        return MaterialPageRoute(
          builder: (_) => MainLayout(pageIndex: arguments as int?),
          settings: settings,
        );

      /// need doctor id as arguments
      case Routes.doctorInfo:
        final doctorId = arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                DoctorInfoCubit(sl())..getDoctorInfo(doctorId),
            child: const DoctorInfoScreen(),
          ),
          settings: settings,
        );

      /// need specialization id & specializations as arguments
      case Routes.specializationsFilter:
        final screenArguments =
            arguments as SpecializationsFilterScreenArguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => SpecializationsFilterCubit(
                screenArguments.specializationId, sl(),
                specializations: screenArguments.specializations),
            child: SpecializationsFilterScreen(
              specializations: screenArguments.specializations,
            ),
          ),
          settings: settings,
        );

      /// need doctor as arguments
      case Routes.bookSession:
        final doctor = arguments as Doctor;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                BookSessionCubit(doctor.id, sl())..getDoctorAvailableDays(),
            child: BookSessionScreen(
              doctor: doctor,
            ),
          ),
          settings: settings,
        );
      case Routes.loading:
        return MaterialPageRoute(
          builder: (_) => const LoadingScreen(),
          settings: settings,
        );

      case Routes.payment:
        final paymentArguments = arguments as PaymentScreenArguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => PaymentCubit(sl()),
            child: PaymentScreen(arguments: paymentArguments),
          ),
          settings: settings,
        );

      case Routes.sessionBooked:
        final sessionBookedArguments =
            arguments as SessionBookedScreenArguments;
        return MaterialPageRoute(
          builder: (_) => SessionBookedScreen(
            arguments: sessionBookedArguments,
          ),
          settings: settings,
        );

      default:
        return _buildInvalidRoute(settings);
    }
  }

  static MaterialPageRoute _buildInvalidRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        );
      },
      settings: settings,
    );
  }
}
