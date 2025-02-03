import 'package:clients/features/auth/OTP/data/datasource/otp_service.dart';
import 'package:dartz/dartz.dart';

abstract class OtpRepository {
  Future<Either<String, void>> resendOtp();
  Future<Either<String, void>> verifyOtp({required String otp, required String email});
}

class OtpRepositoryImpl extends OtpRepository {
  final OtpService _otpService;

  OtpRepositoryImpl({required OtpService otpService})
      : _otpService = otpService;

  @override
  Future<Either<String, void>> resendOtp() async {
    try {
      await _otpService.resendOtp();
      return right(null);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> verifyOtp({required String otp, required String email}) async {
    try {
      await _otpService.verifyOtp(otp, email);
      return right(null);
    } catch (e) {
      return left(e.toString());
    }
  }

}
