import 'package:flutter/material.dart';
import 'views/welcome_screen.dart';

void main() {
  runApp(const SplitFlowApp());
}

class SplitFlowApp extends StatelessWidget {
  const SplitFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF6C5CE7);
    return MaterialApp(
      title: 'SplitFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: purple),
        scaffoldBackgroundColor: const Color(0xFFF6F7FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF6F7FC),
          foregroundColor: Color(0xFF202033),
          elevation: 0,
        ),
        cardTheme: const CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}