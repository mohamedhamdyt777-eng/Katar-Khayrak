import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // prevent instantiation

  // ── Brand ────────────────────────────────────────────────
  static const Color primary       = Color(0xFF1B6B4A); // Primary green
  static const Color primaryLight  = Color(0xFF14A567); // Buttons, CTAs
  static const Color primaryDark   = Color(0xFF0A3D28); // Headers, dark accents
  static const Color accent        = Color(0xFFE8A020); // Badges, progress, Zakat

  // ── Semantic ─────────────────────────────────────────────
  static const Color error         = Color(0xFFDC2626);
  static const Color success       = Color(0xFF16A34A);
  static const Color warning       = Color(0xFFF59E0B);
  static const Color info          = Color(0xFF3B82F6);

  // ── Backgrounds — Light ──────────────────────────────────
  static const Color bgLight       = Color(0xFFF8F9FA);
  static const Color surfaceLight  = Color(0xFFFFFFFF);
  static const Color cardLight     = Color(0xFFFFFFFF);

  // ── Backgrounds — Dark ───────────────────────────────────
  static const Color bgDark        = Color(0xFF111827);
  static const Color surfaceDark   = Color(0xFF1F2937);
  static const Color cardDark      = Color(0xFF374151);

  // ── Text ─────────────────────────────────────────────────
  static const Color textPrimary   = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textOnDark    = Color(0xFFF9FAFB);

  // ── Borders ──────────────────────────────────────────────
  static const Color borderLight   = Color(0xFFE5E7EB);
  static const Color borderDark    = Color(0xFF374151);
}
