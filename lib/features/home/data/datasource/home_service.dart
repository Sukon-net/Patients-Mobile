import 'package:clients/core/networking/api_constants.dart';
import 'package:clients/core/networking/failures.dart';
import 'package:clients/core/utils/try_api_request.dart';
import 'package:clients/features/home/model/appointment.dart';
import 'package:clients/features/home/model/doctor.dart';
import 'package:clients/features/home/model/specialization.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeService {
  final Dio _dio;

  HomeService({required Dio dio}) : _dio = dio;

  Future<Either<BackendFailure, List<Specialization>>> getSpecializations() {
    return tryApiRequest(() async {
      final response = await _dio.get(ApiConstants.getSpecializations);
      final dataList = response.data['data']['data'] as List;
      final specializationsList = dataList
          .map((e) => Specialization.fromJson(e as Map<String, dynamic>))
          .toList();
      return specializationsList;
    });
  }

  Future<Either<BackendFailure, List<Doctor>>> getTopRatedDoctors() {
    return tryApiRequest(() async {
      final response = await _dio.get(
        ApiConstants.getAllDoctors,
        queryParameters: {"sort_by_rating": "asc"},
      );
      final dataList = response.data['data']['data'] as List;
      final topRatedDocList = dataList
          .map((e) => Doctor.fromJson(e as Map<String, dynamic>))
          .toList();
      return topRatedDocList;
    });
  }

  Future<Either<BackendFailure, List<Appointment>>> getAppointments() {
    return tryApiRequest(() async {
      final response = await _dio.get(ApiConstants.getAppointments);
      final dataList = response.data['data']['data'] as List;
      final appointmentsList = dataList.map((e) => Appointment.fromJson(e as Map<String, dynamic>)).toList();
      return appointmentsList;
    });
  }
}
