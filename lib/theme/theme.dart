import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF416FDF),
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color(0xFF6EAEE7),
  onSecondary: Color(0xFFFFFFFF),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  surface: Color(0xFFF9FAF3), // ✅ background → surface
  onSurface: Color(0xFF1A1C18), // ✅ onBackground → onSurface
  shadow: Color(0xFF000000),
  outlineVariant: Color(0xFFC2C8BC),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF416FDF),
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color(0xFF6EAEE7),
  onSecondary: Color(0xFFFFFFFF),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  surface: Color(0xFFF9FAF3), // ✅ background → surface
  onSurface: Color(0xFF1A1C18), // ✅ onBackground → onSurface
  shadow: Color(0xFF000000),
  outlineVariant: Color(0xFFC2C8BC),
);

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>( // ✅ MaterialStateProperty → WidgetStateProperty
        lightColorScheme.primary,
      ),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white), // ✅ MaterialStateProperty → WidgetStateProperty
      elevation: WidgetStateProperty.all<double>(5.0), // ✅ MaterialStateProperty → WidgetStateProperty
      padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
);
