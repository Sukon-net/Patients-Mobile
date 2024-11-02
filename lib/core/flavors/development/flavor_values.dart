import '../flavor_config.dart';

void setupProductionFlavor() {
  FlavorConfig.initialize(
    name: 'production',
    values: const FlavorValues(
      apiBaseUrl: 'https://api.sukon.net/',
    ),
  );
}
