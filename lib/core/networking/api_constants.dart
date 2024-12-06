import 'package:clients/core/flavors/flavor_config.dart';

class ApiConstants {
  const ApiConstants._();

  static String baseUrl = FlavorConfig.instance.values.apiBaseUrl;
  static const String register = "auth/register/";
  static const String login = "auth/login/";
  static const String verifyOTP = "auth/verify-otp/";
  static const String resendOTP = "auth/resend-otp/";
  static const String updateProfile = "auth/update-profile/";
  static const String canChangeEmail = "auth/can-change-email/";
  static const String changeEmail = "auth/change-email/";
  static const String viewProfile = "auth/view-profile/";
}
