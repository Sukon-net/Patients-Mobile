import 'package:easy_localization/easy_localization.dart';

extension DatetimeExtensions on DateTime {
  String toFormattedDateString() => DateFormat('dd/MM/yyyy').format(this);

  String toFormattedTimeString() => DateFormat('hh:mm').format(this);

  String toFormattedDateTimeString() =>
      DateFormat('dd/MM/yyyy hh:mm').format(this);

  String getDayName() => DateFormat('EEEE').format(this);
}
