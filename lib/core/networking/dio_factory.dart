import 'package:clients/core/networking/api_constants.dart';
import 'package:clients/core/routing/navigator_service.dart';
import 'package:clients/core/utils/extensions/num_duration_extensions.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  const DioFactory._();

  static Dio? _dio;

  static Dio getDio() {
    if (_dio == null) {
      Duration timeOut = 30.seconds;
      _dio = Dio(
        BaseOptions(
          connectTimeout: timeOut,
          receiveTimeout: timeOut,
          sendTimeout: timeOut,
          baseUrl: ApiConstants.baseUrl,
          headers: {
            'x-api-key': dotenv.env['API_KEY'],
            'Accept-Language': NavigatorService.context.locale,
          },
        ),
      );
      _addLoggingInterceptor();
    }
    return _dio!;
  }

  static void _addLoggingInterceptor() {
    _dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
      ),
    );
  }
}
