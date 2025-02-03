import 'package:dio/dio.dart';

class OtpService {
  final Dio _dio;

  OtpService({required Dio dio}) : _dio = dio;

  Future<void> resendOtp() async {
    await _dio.post(
      '/api/v1/auth/otp/resend',
    );
  }

  Future<void> verifyOtp(String otp, String email) async {
    await _dio.post(
      '/api/v1/auth/otp/verify',
      data: {
        'otp': otp,
        'is_changed': false,
        'type': 'Patient',
        'email': email,
      },
    );
  }

}
