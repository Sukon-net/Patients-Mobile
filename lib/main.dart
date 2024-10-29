import 'package:flutter/material.dart';

void mainCommon({required bool isDevelopment}) {
  runApp(MyApp(isDevelopment: isDevelopment));
}

class MyApp extends StatelessWidget {
  final bool isDevelopment;
  const MyApp({super.key, required this.isDevelopment});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: isDevelopment,
      home: const Placeholder(),
    );
  }
}
