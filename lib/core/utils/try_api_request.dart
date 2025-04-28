import 'package:clients/core/networking/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../features/auth/logic/auth_cubit.dart';
import '../di/dependency_container.dart';

typedef ApiResponse<T> = Future<Either<BackendFailure, T>>;

ApiResponse<T> tryApiRequest<T>(Future<T> Function() request) async {
  try {
    final result = await request();
    return right(result);
  } on DioException catch (e) {
    if (e.response?.statusCode == 401 || e.error == UnauthorizedFailure) {
      sl<AuthCubit>().logout();
    }
    return left(BackendFailure.fromDioException(e));
  } catch (e) {
    return left(UnknownFailure(e.toString()));
  }
}
