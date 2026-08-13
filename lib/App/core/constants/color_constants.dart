import 'package:flutter/material.dart';

class AppColors {
  // ── Background / Surface ─────────────────────────────────────────────────
  static const Color backgroundDark = Color(0xFFF8FAFC); // slate 50
  static const Color backgroundColor = backgroundDark;
  static const Color surface = Color(0xFFFFFFFF); // pure white
  static const Color cardColor = Color(0xFFFFFFFF);

  // ── Brand & Accents ───────────────────────────────────────────────────────
  static const Color primaryPurple = Color(0xFF6366F1); // indigo 500
  static const Color primaryPurpleLight = Color(0xFF818CF8); // indigo 400
  static const Color primaryCyan = Color(0xFF0EA5E9); // sky 500
  static const Color accentGold = Color(0xFFD97706); // amber 600 (high contrast gold on light background)

  // ── Text ─────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF0F172A); // slate 900
  static const Color textSecondary = Color(0xFF64748B); // slate 500

  // ── Game / Home / Theme specific ─────────────────────────────────────────
  static const Color playButtonGreen = Color(0xFF10B981); // emerald 500
  static const Color playButtonGreenDark = Color(0xFF059669);
  static const Color homeNavyDark = Color(0xFFF1F5F9); // slate 100
  static const Color homeCardNavy = Color(0xFFFFFFFF);
  static const Color homeCardBorder = Color(0xFFE2E8F0); // slate 200
  static const Color homeProgressRing = Color(0xFF10B981);
  static const Color bottomNavBackground = Color(0xFFFFFFFF);

  // ── Divider ──────────────────────────────────────────────────────────────
  static const Color divider = Color(0xFFE2E8F0);

  // ── Gradient Presets ─────────────────────────────────────────────────────
  static const List<Color> splashGradient = [
    Color(0xFFEEF2F6),
    Color(0xFFE2E8F0),
    Color(0xFFF8FAFC),
  ];

  static const List<Color> primaryGradient = [
    Color(0xFF6366F1),
    Color(0xFF0EA5E9),
  ];

  static const List<Color> playScreenGradient = [
    Color(0xFFF8FAFC),
    Color(0xFFF1F5F9),
    Color(0xFFF8FAFC),
  ];
}