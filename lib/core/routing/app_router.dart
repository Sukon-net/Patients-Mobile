import 'package:clients/core/routing/routes.dart';
import 'package:flutter/material.dart';

class AppRouter {
  const AppRouter._();

  static Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => Container());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => Container());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => Container());
      default:
        return _buildInvalidRoute(settings);
    }
  }

  static MaterialPageRoute _buildInvalidRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text('No route defined for ${settings.name}'),
        ),
      );
    });
  }
}
