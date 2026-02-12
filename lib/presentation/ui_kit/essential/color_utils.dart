import 'package:flutter/material.dart';

class ColorUtils {
  static Color fromHex(String hexColor) {
    String hex = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }
}