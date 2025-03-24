import 'package:clients/core/storage/secure_storage/secure_storage_helper.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final String? token = await SecureStorageHelper.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    //TODO if error 401 unauthorized => return to login
    if (err.response?.statusCode == 401) {}
  }
}
