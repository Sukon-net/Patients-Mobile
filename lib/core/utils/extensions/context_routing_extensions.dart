import 'package:clients/core/routing/navigator_service.dart';
import 'package:flutter/material.dart';

extension ContextRoutingExtensions on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return NavigatorService.navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return NavigatorService.navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, RoutePredicate? predicate}) {
    return NavigatorService.navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, predicate ?? (_) => false,
        arguments: arguments);
  }

  void pop({dynamic returnValue}) =>
      NavigatorService.navigatorKey.currentState!.pop(returnValue);
}
