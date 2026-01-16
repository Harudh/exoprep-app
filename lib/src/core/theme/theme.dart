import 'package:flutter/material.dart';
import 'package:root/src/core/theme/colors.dart';
import 'package:root/src/core/theme/text_theme.dart';

/// Centralized theme configuration for the application
/// Provides consistent styling across light and dark modes
class AppTheme {
  AppTheme._();

  /// Light theme configuration
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    textTheme: AppTextTheme.lightTextTheme,
    scaffoldBackgroundColor: AppColors.lightBackgroundColor,
    splashColor: AppColors.primaryColor.withValues(alpha: 0.15),
    highlightColor: AppColors.primaryColor.withValues(alpha: 0.10),
    drawerTheme: const DrawerThemeData(backgroundColor: AppColors.lightBackgroundColor),

    // Color scheme
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
      surface: AppColors.lightTextColor,
      onSurface: AppColors.darkTextColor,
      onSecondary: Colors.white,
    ),

    // App bar theme
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.lightBackgroundColor,
      foregroundColor: AppColors.lightTextColor,
      titleTextStyle: AppTextTheme.lightTextTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
    ),

    // Card theme
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.lightSurfaceColor,
    ),

    // Elevated button theme
    elevatedButtonTheme: const ElevatedButtonThemeData(
      /*style: ElevatedButton.styleFrom(
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),*/
    ),

    // Input decoration theme
    inputDecorationTheme: const InputDecorationTheme(
      /*filled: true,
      fillColor: AppColors.lightSurfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.errorColor),
      ),*/
    ),
  );

  /// Dark theme configuration
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    textTheme: AppTextTheme.darkTextTheme,
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    splashColor: AppColors.primaryColor.withValues(alpha: 0.15),
    highlightColor: AppColors.primaryColor.withValues(alpha: 0.10),
    drawerTheme: const DrawerThemeData(backgroundColor: AppColors.darkBackgroundColor),

    // Color scheme
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryColor,
      surface: AppColors.lightSurfaceColor,
      error: AppColors.errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.lightTextColor,
      onError: Colors.white,
    ),

    // App bar theme
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.darkBackgroundColor,
      foregroundColor: AppColors.darkTextColor,
      titleTextStyle: AppTextTheme.darkTextTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
    ),

    // Card theme
    cardTheme: CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.darkSurfaceColor,
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // Input decoration theme
    inputDecorationTheme: const InputDecorationTheme(
      /*  filled: true,
      fillColor: AppColors.darkSurfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.errorColor),
      ),*/
    ),
  );
}
