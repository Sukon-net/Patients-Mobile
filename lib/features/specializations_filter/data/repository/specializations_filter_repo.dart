import 'package:dartz/dartz.dart';

import '../../../../core/networking/failures.dart';
import '../../../home/model/doctor.dart';
import '../datasource/specializations_filter_service.dart';

abstract class SpecializationsFilterRepo {
  Future<Either<BackendFailure, List<Doctor>>> getDoctors(
      {String? specialization});
}

class SpecializationsFilterRepoImpl extends SpecializationsFilterRepo {
  final SpecializationsFilterService _service;

  SpecializationsFilterRepoImpl({required SpecializationsFilterService service})
      : _service = service;

  @override
  Future<Either<BackendFailure, List<Doctor>>> getDoctors(
      {String? specialization}) {
    return _service.getDoctors(specialization);
  }
}
