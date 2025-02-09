import 'package:clients/core/networking/api_constants.dart';
import 'package:clients/core/networking/failures.dart';
import 'package:clients/features/auth/model/authed_user.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class CompleteProfileService {
  final Dio _dio;
  const CompleteProfileService(this._dio);

  Future<Either<AuthedUser, BackendFailure>> completeProfile(String firstName,
      String lastName, String email, String phoneNumber, String gender) async {
    try {
      final response = await _dio.post(ApiConstants.updateProfile, data: {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'mobile': phoneNumber,
        'gender': gender,
        '_method': 'put',
      });
      return left(AuthedUser.fromJson(response.data));
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
