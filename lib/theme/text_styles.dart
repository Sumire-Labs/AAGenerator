import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle monoStyle({
    double fontSize = 14,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      height: 1.2,
    );
  }
}
