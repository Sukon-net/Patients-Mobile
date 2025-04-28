import 'package:clients/core/networking/failures.dart';
import 'package:clients/features/home/data/datasource/doctors_service.dart';
import 'package:clients/features/home/model/doctor.dart';
import 'package:dartz/dartz.dart';

abstract class DoctorsRepository {
  Future<Either<BackendFailure, List<Doctor>>> getDoctors();
}

class DoctorsRepositoryImpl extends DoctorsRepository {
  final DoctorsService _doctorsService;

  DoctorsRepositoryImpl({required DoctorsService doctorsService})
      : _doctorsService = doctorsService;

  @override
  Future<Either<BackendFailure, List<Doctor>>> getDoctors() {
    return _doctorsService.getDoctors();
  }
}
