import 'package:clients/core/networking/failures.dart';
import 'package:clients/features/home/data/datasource/home_service.dart';
import 'package:clients/features/home/model/appointment.dart';
import 'package:clients/features/home/model/doctor.dart';
import 'package:clients/features/home/model/specialization.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<BackendFailure, List<Specialization>>> getSpecializations();

  Future<Either<BackendFailure, List<Doctor>>> getTopRatedDoctors();

  Future<Either<BackendFailure, List<Appointment>>> getAppointments();
}

class HomeRepositoryImpl extends HomeRepository {
  final HomeService _service;

  HomeRepositoryImpl({required HomeService homeService})
      : _service = homeService;

  @override
  Future<Either<BackendFailure, List<Specialization>>> getSpecializations() {
    return _service.getSpecializations();
  }

  @override
  Future<Either<BackendFailure, List<Doctor>>> getTopRatedDoctors() {
    return _service.getTopRatedDoctors();
  }

  @override
  Future<Either<BackendFailure, List<Appointment>>> getAppointments() {
    return _service.getAppointments();
  }
}
