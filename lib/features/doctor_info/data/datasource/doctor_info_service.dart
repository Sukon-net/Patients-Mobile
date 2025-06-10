import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/flavors/flavor_config.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/failures.dart';
import '../../../../core/utils/try_api_request.dart';
import '../../../home/model/doctor.dart';

class DoctorInfoService {
  final Dio _dio;

  DoctorInfoService({required Dio dio}) : _dio = dio;

  Future<Either<BackendFailure, Doctor>> getDoctorInfo(int doctorId) async {
    return tryApiRequest(
      () async {
        final response = await _dio.get(ApiConstants.getDoctorInfo(doctorId));
        if (FlavorConfig.isDevelopment()) {
          log("get doctor info data source: ${response.extra}");
        }
        return Doctor.fromJson(response.data['data']
          ..addAll({
            "id": doctorId,
          }));
      },
    );
  }
}
