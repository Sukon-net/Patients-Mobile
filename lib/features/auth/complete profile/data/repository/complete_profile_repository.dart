import 'package:clients/core/networking/failures.dart';
import 'package:clients/features/model/user.dart';
import 'package:dartz/dartz.dart';

import '../model/complete_profile_request.dart';
import '../service/complete_profile_service.dart';

abstract class CompleteProfileRepository {
  Future<Either<User, BackendFailure>> completeUserProfile({
    required CompleteProfileRequest compProfileReq,
  });
}

class CompleteProfileRepositoryImpl implements CompleteProfileRepository {
  final CompleteProfileService _service;

  CompleteProfileRepositoryImpl(
      {required CompleteProfileService completeProfileService})
      : _service = completeProfileService;

  @override
  Future<Either<User, BackendFailure>> completeUserProfile({
    required CompleteProfileRequest compProfileReq,
  }) {
    return _service.completeProfile(compProfileReq);
  }
}
