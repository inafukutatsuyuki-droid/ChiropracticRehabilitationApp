import 'package:flutter/material.dart';

class AppTheme {
  static final ColorScheme _baseScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF1E88E5),
    brightness: Brightness.light,
  ).copyWith(
    surface: Colors.white,
    background: const Color(0xFFF5F8FC),
  );

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: _baseScheme,
        scaffoldBackgroundColor: _baseScheme.background,
        appBarTheme: AppBarTheme(
          backgroundColor: _baseScheme.background,
          foregroundColor: _baseScheme.onSurface,
          elevation: 0,
          centerTitle: false,
        ),
        chipTheme: ChipThemeData(
          backgroundColor: _baseScheme.primary.withOpacity(0.08),
          selectedColor: _baseScheme.primary,
          secondarySelectedColor: _baseScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          labelStyle: TextStyle(color: _baseScheme.onSurface),
          secondaryLabelStyle: TextStyle(color: _baseScheme.onPrimary),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _baseScheme.primary,
            foregroundColor: _baseScheme.onPrimary,
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );
}
