import 'package:clients/core/routing/navigator_service.dart';
import 'package:easy_localization/easy_localization.dart';

class Helpers {
  static String getNowDayFormatted() {
    DateTime now = DateTime.now();
    String localeString = NavigatorService.context.locale.toString();
    String formattedDay =
        DateFormat('EEEE، d MMMM y', localeString).format(now);
    return formattedDay;
  }
}
