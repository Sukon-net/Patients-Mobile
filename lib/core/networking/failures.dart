import 'package:clients/core/l10n/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

sealed class BackendFailure {
  String get message;
}

final class InvalidEmailFailure extends BackendFailure {
  @override
  String get message => LocaleKeys.invalid_email_format.tr();
}

final class NoInternetFailure extends BackendFailure {
  @override
  String get message => LocaleKeys.no_internet_connection.tr();
}

final class UnknownFailure extends BackendFailure {
  @override
  String get message => LocaleKeys.unknown_error_has_occurred.tr();
}
