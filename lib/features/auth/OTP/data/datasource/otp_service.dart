import 'package:clients/core/networking/api_constants.dart';
import 'package:clients/core/networking/failures.dart';
import 'package:clients/features/auth/model/authed_user/authed_user.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class OtpService {
  final Dio _dio;

  OtpService({required Dio dio}) : _dio = dio;

  Future<Either<String, BackendFailure>> resendOtp(String email) async {
    try {
      final response = await _dio.post(
        ApiConstants.resendOTP,
        data: {
          'is_changed': false,
          'type': 'Patient',
          'email': email,
        },
      );
      if (response.statusCode == 200) return left('');
      if (response.statusCode == 422) {
        return right(InvalidOtpFailure());
      } else {
        return right(UnknownFailure());
      }
    } catch (e) {
      return right(NoInternetFailure());
    }
  }

  Future<Either<AuthedUser, BackendFailure>> verifyOtp(
      int otp, String email) async {
    try {
      final response = await _dio.post(
        ApiConstants.verifyOTP,
        data: {
          'code': otp,
          'is_changed': false,
          'type': 'Patient',
          'email': email,
        },
      );
      AuthedUser authedUser = AuthedUser.fromJson(response.data['data']);
      return left(authedUser);
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.data is Map<String, dynamic>) {
          return right(BackendFailure(message: e.response!.data['message']));
        }
        return right(UnknownFailure());
      }
      return right(NoInternetFailure());
    } catch (e) {
      return right(UnknownFailure());
    }
  }
}
