import 'package:clients/core/networking/api_constants.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/networking/failures.dart';

class LoginService {
  final Dio _dio;

  LoginService({required Dio dio}) : _dio = dio;

  Future<Either<String, BackendFailure>> sendEmail(String data) async {
    try {
      final response = await _dio.post(ApiConstants.login, data: data);
      if (response.statusCode == 200) return left("");
      if (response.statusCode == 422) {
        return right(InvalidEmailFailure());
      } else {
        return right(UnknownFailure());
      }
    } catch (e) {
      return right(NoInternetFailure());
    }
  }
}
