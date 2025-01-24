import 'package:flutter/material.dart';

class ThemeUtils {
  static ThemeData createTheme({
    required String font,
    required ColorScheme colorScheme,
  }) {
    Color? scaffoldBackgroundColor;
    Color cardColor = colorScheme.surfaceContainerLowest;

    if (colorScheme.brightness == Brightness.dark) {
      scaffoldBackgroundColor = Colors.black;
      cardColor = colorScheme.surfaceContainer;
    }

    return ThemeData(
      fontFamily: font,
      colorScheme: colorScheme,
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
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
      cardColor: cardColor,
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
