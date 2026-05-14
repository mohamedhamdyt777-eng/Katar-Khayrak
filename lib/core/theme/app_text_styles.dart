import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get headlineLarge => GoogleFonts.readexPro(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get headlineMedium => GoogleFonts.readexPro(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get titleLarge => GoogleFonts.readexPro(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get bodyLarge => GoogleFonts.readexPro(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get bodyMedium => GoogleFonts.readexPro(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get labelLarge => GoogleFonts.readexPro(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );
}
