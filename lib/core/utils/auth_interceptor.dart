import 'package:clients/core/di/dependency_container.dart';
import 'package:clients/core/networking/api_constants.dart';
import 'package:clients/core/storage/secure_storage/secure_storage_helper.dart';
import 'package:clients/features/auth/logic/auth_cubit.dart';
import 'package:clients/features/model/user.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final authCubit = sl<AuthCubit>();
    final isGuest = authCubit.currentUser == User.guest;
    if (isGuest) {
      handler.next(options);
      return;
    }
    final String? token = await SecureStorageHelper.getAccessToken();
    if (token != null &&
        ![ApiConstants.verifyOTP, ApiConstants.register]
            .contains(options.path)) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      sl<AuthCubit>().logout();
    }
  }
}
