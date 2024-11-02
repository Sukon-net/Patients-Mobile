class FlavorConfig {
  final String name;
  final FlavorValues values;

  static FlavorConfig? _instance;

  const FlavorConfig._internal({
    required this.name,
    required this.values,
  });

  static void initialize({
    required String name,
    required FlavorValues values,
  }) {
    _instance = FlavorConfig._internal(
      name: name,
      values: values,
    );
  }

  static FlavorConfig get instance => _instance!;

  static bool isProduction() => _instance!.name == 'production';
  static bool isDevelopment() => _instance!.name == 'development';
}

class FlavorValues {
  final String apiBaseUrl;

  const FlavorValues({required this.apiBaseUrl});
}
