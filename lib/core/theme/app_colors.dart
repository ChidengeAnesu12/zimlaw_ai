import 'package:flutter/material.dart';

/// Centralized color palette for ZimLaw AI.
/// Do not hardcode colors anywhere else in the app — always reference this file.
class AppColors {
  AppColors._(); // prevents instantiation

  // ---------- Brand Colors ----------
  static const Color primary = Color(0xFF0B6E4F);     // Deep legal green
  static const Color secondary = Color(0xFF1F2937);   // Slate / charcoal
  static const Color accent = Color(0xFF10B981);      // Emerald accent

  // ---------- Backgrounds ----------
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color backgroundDark = Color(0xFF0F172A);

  // ---------- Surfaces (cards, sheets) ----------
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E293B);

  // ---------- Glass Effect ----------
  static const Color glassLight = Color(0x99FFFFFF);  // white @ 60% alpha
  static const Color glassDark = Color(0x991E293B);    // surfaceDark @ 60% alpha
  static const Color glassBorderLight = Color(0x33FFFFFF);
  static const Color glassBorderDark = Color(0x33FFFFFF);

  // ---------- Text ----------
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF64748B);
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);

  // ---------- Semantic ----------
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // ---------- Borders / Dividers ----------
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderDark = Color(0xFF334155);

  // ---------- Feature Card Tints (from your Home dashboard mockup) ----------
  static const Color legalAssistantTint = Color(0xFFDCFCE7); // soft green
  static const Color legalResearchTint = Color(0xFFDBEAFE);  // soft blue
  static const Color landPropertyTint = Color(0xFFFEF3C7);   // soft amber
  static const Color findLawyerTint = Color(0xFFEDE9FE);     // soft purple

  // ---------- Gradients ----------
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0B6E4F), Color(0xFF10B981)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkSplashGradient = LinearGradient(
    colors: [Color(0xFF0F172A), Color(0xFF134E3A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}