import 'package:clients/core/flavors/flavor_config.dart';
import 'package:flutter/material.dart';

void mainCommon() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: FlavorConfig.isDevelopment(),
      home: const Placeholder(),
    );
  }
}
