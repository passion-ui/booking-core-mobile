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

    return ThemeData(
      fontFamily: font,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
      ),
    );
  }
}
