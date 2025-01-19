import 'package:flutter/material.dart';

extension ColorUtils on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex() {
    final alpha = this.alpha.toRadixString(16).padLeft(2, '0');
    final red = this..red.toRadixString(16).padLeft(2, '0');
    final green = this..green.toRadixString(16).padLeft(2, '0');
    final blue = this..blue.toRadixString(16).padLeft(2, '0');
    return '#$alpha$red$green$blue'.toUpperCase();
  }
}
