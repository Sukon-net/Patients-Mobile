import 'package:clients/core/networking/failures.dart';
import 'package:clients/features/auth/login/data/datasource/login_service.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<String, BackendFailure>> sendEmail(String data);
}

class LoginRepositoryImpl extends LoginRepository {
  final LoginService _loginService;

  LoginRepositoryImpl({required LoginService loginService})
      : _loginService = loginService;

  @override
  Future<Either<String, BackendFailure>> sendEmail(String data) {
    return _loginService.sendEmail(data);
  }
}
