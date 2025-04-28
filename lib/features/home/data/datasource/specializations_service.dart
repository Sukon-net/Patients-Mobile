import 'dart:developer';

import 'package:clients/core/flavors/flavor_config.dart';
import 'package:clients/core/networking/api_constants.dart';
import 'package:clients/core/networking/failures.dart';
import 'package:clients/core/utils/try_api_request.dart';
import 'package:clients/features/home/model/specialization.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class SpecializationsService {
  final Dio _dio;

  SpecializationsService({required Dio dio}) : _dio = dio;

  Future<Either<BackendFailure, List<Specialization>>> getSpecializations() {
    return tryApiRequest(() async {
      final response = await _dio.get(ApiConstants.getSpecializations);
      if (FlavorConfig.isDevelopment()) {
        log("get specializations data source: ${response.extra}");
      }
      final List<Specialization> dataList = response.data['data']['data'];
      final specializationsList = dataList
          .map((e) => Specialization.fromJson(e as Map<String, dynamic>))
          .toList();
      return specializationsList;
    });
  }
}
