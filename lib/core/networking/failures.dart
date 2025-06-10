import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class BackendFailure {
  final String message;

  const BackendFailure({required this.message});

  static BackendFailure fromDioException(DioException e) {
    if (e.response?.statusCode == 401) {
      return UnauthorizedFailure();
    }
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return NoInternetFailure();
      case DioExceptionType.sendTimeout:
        return SendTimeoutError();
      case DioExceptionType.receiveTimeout:
        return ReceiveTimeoutError();
      case DioExceptionType.badCertificate:
        return BadCertificateError();
      case DioExceptionType.badResponse:
        return ServerError();
      case DioExceptionType.cancel:
        return CancelError();
      case DioExceptionType.connectionError:
        return CancelError();
      case DioExceptionType.unknown:
        return UnknownFailure();
    }
  }
}

final class UnauthorizedFailure extends BackendFailure {
  UnauthorizedFailure([String? msg])
      : super(message: msg ?? LocaleKeys.unauthorized.tr());
}

final class InvalidEmailFailure extends BackendFailure {
  InvalidEmailFailure([String? msg])
      : super(message: msg ?? LocaleKeys.invalid_email_format.tr());
}

final class InvalidOtpFailure extends BackendFailure {
  InvalidOtpFailure([String? msg])
      : super(message: msg ?? LocaleKeys.verification_code_is_wrong.tr());
}

final class NoInternetFailure extends BackendFailure {
  NoInternetFailure([String? msg])
      : super(message: msg ?? LocaleKeys.no_internet_connection.tr());
}

final class UnknownFailure extends BackendFailure {
  UnknownFailure([String? msg])
      : super(message: msg ?? LocaleKeys.unknown_error_has_occurred.tr());
}

final class ServerError extends BackendFailure {
  ServerError([String? msg]) : super(message: msg ?? "Server Error");
}

final class CancelError extends BackendFailure {
  CancelError([String? msg])
      : super(message: msg ?? LocaleKeys.no_internet_connection.tr());
}

final class ReceiveTimeoutError extends BackendFailure {
  ReceiveTimeoutError([String? msg])
      : super(message: msg ?? "Receive Timeout Error");
}

final class SendTimeoutError extends BackendFailure {
  SendTimeoutError([String? msg]) : super(message: msg ?? "Send Timeout Error");
}

final class BadCertificateError extends BackendFailure {
  BadCertificateError([String? msg])
      : super(message: msg ?? "Bad Certificate Error");
}

final class ConnectionError extends BackendFailure {
  ConnectionError([String? msg]) : super(message: msg ?? "Connection Error");
}
