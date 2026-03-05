import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Text style tokens built on top of the Inter font family.
/// Usage: `Theme.of(context).textTheme.<style>` is recommended at call‑site;
/// these constants are used internally by [AppTheme] to build the text theme.
class AppTextStyles {
  AppTextStyles._();

  static String? get _fontFamily => GoogleFonts.inter().fontFamily;

  static TextTheme get textTheme => TextTheme(
    headlineLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 28,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      height: 1.3,
    ),
    headlineMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.3,
      height: 1.3,
    ),
    titleLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ),
    titleMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ),
    bodyLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    bodyMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    bodySmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    labelLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ),
    labelMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.4,
    ),
    labelSmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 10,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.4,
    ),
  );
}
