import 'package:clients/core/flavors/flavor_config.dart';

class ApiConstants {
  const ApiConstants._();

  static String baseUrl = FlavorConfig.instance.values.apiBaseUrl;
  static const String register = "auth/register";
  static const String login = "auth/login";
  static const String verifyOTP = "auth/verify-otp";
  static const String resendOTP = "auth/resend-otp";
  static const String updateProfile = "auth/update-profile";
  static const String completeRegistration = "auth/complete-registration";
  static const String canChangeEmail = "auth/can-change-email";
  static const String changeEmail = "auth/change-email";
  static const String viewProfile = "auth/view-profile";
  static const String getSpecializations = "specializations/index";

  /// Filtered Doctors according to: "Specializations" by passing 'specialization' name as query parameter, "Top Rates" by passing 'sort_by_rating' as query parameter
  static const String getAllDoctors = "patient-dashboard/doctors/index";

  static String getDoctorInfo(int id) => "patient-dashboard/doctors/show/$id";

  /// passing date & duration as query parameter
  static String getDoctorAvailableSlots(int id) =>
      "patient-dashboard/doctors/$id/available-slots";

  static String getDoctorAvailableDays(int id) =>
      "patient-dashboard/doctors/$id/available-days";
}
