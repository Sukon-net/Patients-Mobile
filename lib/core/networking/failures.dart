import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class BackendFailure {
  final String message;

  const BackendFailure({required this.message});
}

final class InvalidEmailFailure extends BackendFailure {
  InvalidEmailFailure([String? msg])
      : super(message: msg ?? LocaleKeys.invalid_email_format.tr());
}

final class NoInternetFailure extends BackendFailure {
  NoInternetFailure([String? msg])
      : super(message: msg ?? LocaleKeys.no_internet_connection.tr());
}

final class UnknownFailure extends BackendFailure {
  UnknownFailure([String? msg])
      : super(message: msg ?? LocaleKeys.unknown_error_has_occurred.tr());
}

final class InvalidOtpFailure extends BackendFailure {
  InvalidOtpFailure([String? msg])
      : super(message: msg ?? LocaleKeys.verification_code_is_wrong.tr());
}
