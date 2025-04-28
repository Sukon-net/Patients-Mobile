import 'package:flutter/cupertino.dart';

class NavigatorService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;

  static Future<dynamic> pushNamed(String routeName, {Object? arguments}) =>
      navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);

  static Future<dynamic> pushNamedAndRemoveUntil(String routeName,
          {Object? arguments, RoutePredicate? predicate}) =>
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName,
        predicate ?? (route) => false,
        arguments: arguments,
      );

  static Future<dynamic> pushReplacementNamed(String routeName,
          {Object? arguments}) =>
      navigatorKey.currentState!.pushReplacementNamed(
        routeName,
        arguments: arguments,
      );

  static void pop<T>({T? returnValue}) =>
      navigatorKey.currentState!.pop(returnValue);
}
