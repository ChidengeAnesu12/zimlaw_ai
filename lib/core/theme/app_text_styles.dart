import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized typography using Inter, per design spec.
/// Each style is theme-aware via the [isDark] flag rather than duplicating
/// every style for light/dark — call site decides which mode it's in.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle _base({
    required double fontSize,
    required FontWeight fontWeight,
    required bool isDark,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
    );
  }

  // ---------- Display / Headlines ----------
  static TextStyle h1({bool isDark = false}) => _base(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        isDark: isDark,
        height: 1.2,
      );

  static TextStyle h2({bool isDark = false}) => _base(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        isDark: isDark,
        height: 1.25,
      );

  static TextStyle h3({bool isDark = false}) => _base(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        isDark: isDark,
        height: 1.3,
      );

  // ---------- Body ----------
  static TextStyle bodyLarge({bool isDark = false}) => _base(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        isDark: isDark,
        height: 1.5,
      );

  static TextStyle bodyMedium({bool isDark = false}) => _base(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        isDark: isDark,
        height: 1.5,
      );

  static TextStyle bodySmall({bool isDark = false}) => _base(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        isDark: isDark,
        height: 1.4,
      );

  // ---------- Labels / Buttons ----------
  static TextStyle buttonLabel({bool isDark = false}) => _base(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        isDark: isDark,
        letterSpacing: 0.2,
      );

  static TextStyle caption({bool isDark = false}) => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: isDark
            ? AppColors.textSecondaryDark
            : AppColors.textSecondaryLight,
      );

  // ---------- Secondary text variant ----------
  static TextStyle secondary({bool isDark = false, double fontSize = 14}) =>
      GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: isDark
            ? AppColors.textSecondaryDark
            : AppColors.textSecondaryLight,
      );
}