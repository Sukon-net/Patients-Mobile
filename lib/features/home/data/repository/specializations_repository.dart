import 'package:clients/core/networking/failures.dart';
import 'package:clients/features/home/data/datasource/specializations_service.dart';
import 'package:clients/features/home/model/specialization.dart';
import 'package:dartz/dartz.dart';

abstract class SpecializationsRepository {
  Future<Either<BackendFailure, List<Specialization>>> getSpecializations();
}

class SpecializationsRepositoryImpl extends SpecializationsRepository {
  final SpecializationsService _specializationsService;

  SpecializationsRepositoryImpl(
      {required SpecializationsService specializationsService})
      : _specializationsService = specializationsService;

  @override
  Future<Either<BackendFailure, List<Specialization>>> getSpecializations() {
    return _specializationsService.getSpecializations();
  }
}
