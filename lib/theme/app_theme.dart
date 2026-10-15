import 'package:flutter/material.dart';

ThemeData criarTema() {
  final cores = ColorScheme.fromSeed(seedColor: const Color(0xFFB94045));
  return ThemeData(
    useMaterial3: true,
    colorScheme: cores,
    scaffoldBackgroundColor: const Color(0xFFFAF8F7),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
  );
}
