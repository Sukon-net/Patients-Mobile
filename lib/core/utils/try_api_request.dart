import 'package:clients/core/networking/failures.dart';
import 'package:clients/features/auth/model/authed_user/logic/auth_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../di/dependency_container.dart';

typedef ApiResponse<T> = Future<Either<BackendFailure, T>>;

ApiResponse<T> tryApiRequest<T>(Future<T> Function() request) async {
  try {
    final result = await request();
    return right(result);
  } on DioException catch (e) {
    if (e.response?.statusCode == 401 || e.error == UnauthorizedFailure) {
      sl<AuthCubit>().logout();
      return left(UnauthorizedFailure());
    }
    if (e.response?.data is Map<String, dynamic> &&
        e.response?.data['message'] != null) {
      return left(BackendFailure(message: e.response?.data['message']));
    }
    return left(BackendFailure.fromDioException(e));
  } catch (e) {
    return left(UnknownFailure(e.toString()));
  }
}
