import 'dart:developer';

import 'package:clients/core/networking/api_constants.dart';
import 'package:clients/core/networking/failures.dart';
import 'package:clients/features/home/model/doctor.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/flavors/flavor_config.dart';
import '../../../../core/utils/try_api_request.dart';

class DoctorsService {
  final Dio _dio;

  DoctorsService({required Dio dio}) : _dio = dio;

  Future<Either<BackendFailure, List<Doctor>>> getDoctors() async {
    return tryApiRequest(
      () async {
        final response = await _dio.get(ApiConstants.getDoctors);
        if (FlavorConfig.isDevelopment()) {
          log("get doctors data source: ${response.extra}");
        }
        final List<Doctor> dataList = response.data['data']['data'];
        final doctorsList = dataList
            .map((e) => Doctor.fromJson(e as Map<String, dynamic>))
            .toList();
        return doctorsList;
      },
    );
  }
}
