import 'dart:io';

import 'package:clients/core/networking/api_constants.dart';
import 'package:clients/core/routing/navigator_service.dart';
import 'package:clients/core/utils/extensions/num_duration_extensions.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
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
            HttpHeaders.acceptLanguageHeader: NavigatorService.context.locale,
            HttpHeaders.acceptHeader: "application/json"
          },
        ),
      );
      _addLoggingInterceptor();
      // _addCacheInterceptor();
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

  static void _addCacheInterceptor() async {
    final directory = await getApplicationCacheDirectory();
    final cacheOptions = CacheOptions(
      store: HiveCacheStore(directory.path),
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
      priority: CachePriority.normal,
      maxStale: const Duration(days: 7),
    );

    _dio?.interceptors.add(DioCacheInterceptor(options: cacheOptions));
  }
}
