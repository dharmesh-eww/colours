import 'package:flutter/material.dart';
import '../constants/color_constants.dart';

// Light Theme (primary game theme)
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: AppColors.primaryPurple,
    secondary: AppColors.primaryCyan,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
  ),
  scaffoldBackgroundColor: AppColors.backgroundDark,
  cardColor: AppColors.cardColor,
  dividerColor: AppColors.divider,
  fontFamily: 'Nunito',
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    foregroundColor: AppColors.textPrimary,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w800,
    ),
    displayMedium: TextStyle(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(color: AppColors.textPrimary),
    bodyMedium: TextStyle(color: AppColors.textSecondary),
  ),
);

// Dark Theme (fallback / unused since the app is forced to light)
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: AppColors.primaryPurple,
    secondary: AppColors.primaryCyan,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
  ),
  scaffoldBackgroundColor: AppColors.backgroundDark,
  cardColor: AppColors.cardColor,
  dividerColor: AppColors.divider,
  fontFamily: 'Nunito',
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    foregroundColor: AppColors.textPrimary,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w800,
    ),
    displayMedium: TextStyle(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(color: AppColors.textPrimary),
    bodyMedium: TextStyle(color: AppColors.textSecondary),
  ),
);