import 'package:flutter/material.dart';
import '../constants/color_constants.dart';

class AppTextStyle {
  // ── White / Light (dark theme) ────────────────────────────────────────────
  static TextStyle boldWhite({double? fontSize, TextOverflow? overflow}) => _base(
    color: AppColors.textPrimary,
    weight: FontWeight.w800,
    size: fontSize,
    overflow: overflow,
  );

  static TextStyle semiBoldWhite({double? fontSize, TextOverflow? overflow}) => _base(
    color: AppColors.textPrimary,
    weight: FontWeight.w700,
    size: fontSize,
    overflow: overflow,
  );

  static TextStyle mediumWhite({double? fontSize, TextOverflow? overflow}) => _base(
    color: AppColors.textPrimary,
    weight: FontWeight.w500,
    size: fontSize,
    overflow: overflow,
  );

  static TextStyle regularWhite({double? fontSize, TextOverflow? overflow}) => _base(
    color: AppColors.textPrimary,
    weight: FontWeight.w400,
    size: fontSize,
    overflow: overflow,
  );

  // ── Secondary / Muted ─────────────────────────────────────────────────────
  static TextStyle regularSecondary({double? fontSize, TextOverflow? overflow}) => _base(
    color: AppColors.textSecondary,
    weight: FontWeight.w400,
    size: fontSize,
    overflow: overflow,
  );

  static TextStyle mediumSecondary({double? fontSize, TextOverflow? overflow}) => _base(
    color: AppColors.textSecondary,
    weight: FontWeight.w500,
    size: fontSize,
    overflow: overflow,
  );

  // ── Accent ────────────────────────────────────────────────────────────────
  static TextStyle boldCyan({double? fontSize, TextOverflow? overflow}) => _base(
    color: AppColors.primaryCyan,
    weight: FontWeight.w700,
    size: fontSize,
    overflow: overflow,
  );

  static TextStyle boldGold({double? fontSize, TextOverflow? overflow}) => _base(
    color: AppColors.accentGold,
    weight: FontWeight.w700,
    size: fontSize,
    overflow: overflow,
  );

  static TextStyle boldPurple({double? fontSize, TextOverflow? overflow}) => _base(
    color: AppColors.primaryPurple,
    weight: FontWeight.w700,
    size: fontSize,
    overflow: overflow,
  );

  // ── Legacy (light theme) ─────────────────────────────────────────────────
  static TextStyle regularBlack({double? fontSize, TextOverflow? overflow}) =>
      _base(color: Colors.black, weight: FontWeight.w400, size: fontSize, overflow: overflow);

  static TextStyle mediumBlack({double? fontSize, TextOverflow? overflow}) =>
      _base(color: Colors.black, weight: FontWeight.w500, size: fontSize, overflow: overflow);

  static TextStyle semiBoldBlack({double? fontSize, TextOverflow? overflow}) =>
      _base(color: Colors.black, weight: FontWeight.w600, size: fontSize, overflow: overflow);

  static TextStyle boldBlack({double? fontSize, TextOverflow? overflow}) =>
      _base(color: Colors.black, weight: FontWeight.w700, size: fontSize, overflow: overflow);

  // ── Base builder ─────────────────────────────────────────────────────────
  static TextStyle _base({
    required Color color,
    required FontWeight weight,
    double? size,
    TextOverflow? overflow,
  }) => TextStyle(
    color: color,
    fontSize: size,
    fontWeight: weight,
    overflow: overflow,
    letterSpacing: weight.value >= FontWeight.w600.value ? 0.3 : 0,
  );
}
