import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/failures.dart';
import '../../../../core/utils/try_api_request.dart';
import '../../../home/model/doctor.dart';

class SpecializationsFilterService {
  final Dio _dio;

  SpecializationsFilterService({required Dio dio}) : _dio = dio;

  Future<Either<BackendFailure, List<Doctor>>> getDoctors(
      String? specialization) async {
    return tryApiRequest(
      () async {
        final response = await _dio.get(
          ApiConstants.getAllDoctors,
          queryParameters: specialization != null
              ? {
                  "specialization": specialization,
                }
              : null,
        );
        final dataList = response.data['data']['data'] as List;
        final doctorsList = dataList
            .map((e) => Doctor.fromJson(e as Map<String, dynamic>))
            .toList();
        return doctorsList;
      },
    );
  }
}
