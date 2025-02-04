import 'package:clients/core/networking/failures.dart';
import 'package:clients/features/auth/OTP/data/datasource/otp_service.dart';
import 'package:clients/features/auth/model/authed_user.dart';
import 'package:dartz/dartz.dart';

abstract class OtpRepository {
  Future<Either<String, BackendFailure>> resendOtp(String email);

  Future<Either<AuthedUser, BackendFailure>> verifyOtp(
      {required int otp, required String email});
}

class OtpRepositoryImpl extends OtpRepository {
  final OtpService _otpService;

  OtpRepositoryImpl({required OtpService otpService})
      : _otpService = otpService;

  @override
  Future<Either<String, BackendFailure>> resendOtp(String email) async {
    return _otpService.resendOtp(email);
  }

  @override
  Future<Either<AuthedUser, BackendFailure>> verifyOtp(
      {required int otp, required String email}) async {
    return _otpService.verifyOtp(otp, email);
  }
}
