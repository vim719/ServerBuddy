import 'package:flutter/material.dart';

import 'client.dart';
import 'screens/anna_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  runApp(const MyApp());
}

/// Builds a theme for the given [brightness].
ThemeData _buildTheme(Brightness brightness) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF1982C4),
      brightness: brightness,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meet Anna | ServerBuddy',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.light),
      home: const AnnaScreen(),
    );
  }
}
