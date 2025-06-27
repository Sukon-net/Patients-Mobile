import 'package:clients/core/networking/api_constants.dart';
import 'package:clients/core/networking/failures.dart';
import 'package:clients/core/utils/try_api_request.dart';
import 'package:clients/features/home/model/appointment.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class MyAppointmentsService {
  final Dio _dio;

  MyAppointmentsService({required Dio dio}) : _dio = dio;

  Future<Either<BackendFailure, List<Appointment>>> getMyAppointments(
      {String? state}) async {
    return tryApiRequest(() async {
      final response = await _dio.get(
        ApiConstants.getAppointments,
        queryParameters: state != null ? {"type": state} : null,
      );
      final dataList = response.data['data']['data'] as List;
      final appointmentsList = dataList
          .map((e) => Appointment.fromJson(e as Map<String, dynamic>))
          .toList();
      return appointmentsList;
    });
  }
}
