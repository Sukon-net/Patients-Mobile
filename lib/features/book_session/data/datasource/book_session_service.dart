import 'package:clients/core/networking/api_constants.dart';
import 'package:clients/core/utils/try_api_request.dart';
import 'package:clients/features/book_session/model/time_range.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/networking/failures.dart';

class BookSessionService {
  final Dio _dio;

  BookSessionService({required Dio dio}) : _dio = dio;

  Future<Either<BackendFailure, List<String>>> getDoctorsAvailableDays(
      int doctorId) async {
    return tryApiRequest(() async {
      final response =
          await _dio.get(ApiConstants.getDoctorAvailableDays(doctorId));
      final dataList = response.data['data'] as List;
      final availableDaysList = dataList.map((e) => e.toString()).toList();
      return availableDaysList;
    });
  }

  Future<Either<BackendFailure, List<TimeRange>>> getDoctorAvailableSlots(
      int doctorId, String date, String duration) async {
    return tryApiRequest(() async {
      final response = await _dio.get(
        ApiConstants.getDoctorAvailableSlots(doctorId),
        queryParameters: {
          "date": date,
          "duration": duration,
        },
      );
      final dataList = response.data['data'] as List;
      final availableSlotsList = dataList
          .map((e) => (TimeRange.fromJson(e as Map<String, dynamic>)))
          .toList();
      return availableSlotsList;
    });
  }

  Future<Either<BackendFailure, void>> bookSession(int doctorId, String date,
      String slot, String duration, String complain) {
    return tryApiRequest(() async {
      final response = await _dio.post(ApiConstants.bookSession, data: {
        'doctor_id': doctorId,
        'date': date,
        'start_time': slot,
        'duration': duration,
        'complaint': complain.isEmpty ? "Empty" : complain,
      });
      return response.data['data'];
    });
  }
}
