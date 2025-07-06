import 'package:clients/core/networking/failures.dart';
import 'package:clients/features/book_session/data/datasource/book_session_service.dart';
import 'package:clients/features/book_session/model/time_range.dart';
import 'package:dartz/dartz.dart';

abstract class BookSessionRepo {
  Future<Either<BackendFailure, List<String>>> getDoctorsAvailableDays(
      int doctorId);

  Future<Either<BackendFailure, List<TimeRange>>> getDoctorAvailableSlots(
      int doctorId, String date, String duration);

  Future<Either<BackendFailure, void>> bookSession(
      int doctorId, String date, String slot, String duration, String complain);
}

class BookSessionRepoImpl extends BookSessionRepo {
  final BookSessionService _service;

  BookSessionRepoImpl({required BookSessionService service})
      : _service = service;

  @override
  Future<Either<BackendFailure, List<TimeRange>>> getDoctorAvailableSlots(
      int doctorId, String date, String duration) {
    return _service.getDoctorAvailableSlots(doctorId, date, duration);
  }

  @override
  Future<Either<BackendFailure, List<String>>> getDoctorsAvailableDays(
      int doctorId) {
    return _service.getDoctorsAvailableDays(doctorId);
  }

  @override
  Future<Either<BackendFailure, void>> bookSession(int doctorId, String date,
      String slot, String duration, String complain) {
    return _service.bookSession(doctorId, date, slot, duration, complain);
  }
}
