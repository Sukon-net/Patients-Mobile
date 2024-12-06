import '../flavor_config.dart';

void setupDevelopmentFlavor() {
  FlavorConfig.initialize(
    name: 'development',
    values: const FlavorValues(
      apiBaseUrl: 'https://api.sukon.net/dev/',
    ),
  );
}
