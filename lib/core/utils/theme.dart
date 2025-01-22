import 'package:flutter/material.dart';

class ThemeUtils {
  static ThemeData createTheme({
    required String font,
    required ColorScheme colorScheme,
  }) {
    Color? scaffoldBackgroundColor;

    if (colorScheme.brightness == Brightness.dark) {
      scaffoldBackgroundColor = Colors.black;
    }

    final defaultTheme = ThemeData.fallback(useMaterial3: true);
    return ThemeData(
      fontFamily: font,
      colorScheme: colorScheme,
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 0.5,
      ),
    );
  }
}
