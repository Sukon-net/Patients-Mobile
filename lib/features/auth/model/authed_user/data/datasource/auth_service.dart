import 'package:clients/core/networking/api_constants.dart';
import 'package:clients/core/networking/failures.dart';
import 'package:clients/features/auth/model/authed_user/authed_user.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthServices {
  final Dio _dio;

  const AuthServices(this._dio);

  Future<Either<AuthedUser, BackendFailure>> getUser() async {
    try {
      final response = await _dio.get(ApiConstants.viewProfile);
      return left(AuthedUser.fromJson(response.data));
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        return right(UnauthorizedFailure());
      }
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
