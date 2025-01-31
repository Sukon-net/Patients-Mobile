import '../flavor_config.dart';

void setupDevelopmentFlavor() {
  FlavorConfig.initialize(
    name: 'development',
    values: const FlavorValues(
      apiBaseUrl: 'http://api.sukon.net/v1/',
    ),
  );
}
