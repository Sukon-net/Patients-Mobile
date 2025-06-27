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

  static List<String> seperateLocalizedPlural(String localizedText) {
    final regex = RegExp(r'^(\d+)\s+(.*)$');
    final match = regex.firstMatch(localizedText);

    String numberPart = match?.group(1) ?? '';
    String textPart = match?.group(2) ?? localizedText;

    return [numberPart, textPart];
  }
}
