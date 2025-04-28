import 'package:clients/features/doctor_info/data/datasource/doctor_info_service.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/networking/failures.dart';
import '../../../home/model/doctor.dart';

abstract class DoctorInfoRepository {
  Future<Either<BackendFailure, Doctor>> getDoctorInfo(int doctorId);
}

class DoctorInfoRepositoryImpl extends DoctorInfoRepository {
  final DoctorInfoService _doctorInfoService;

  DoctorInfoRepositoryImpl({required DoctorInfoService doctorInfoService})
      : _doctorInfoService = doctorInfoService;

  @override
  Future<Either<BackendFailure, Doctor>> getDoctorInfo(int doctorId) {
    return _doctorInfoService.getDoctorInfo(doctorId);
  }
}
