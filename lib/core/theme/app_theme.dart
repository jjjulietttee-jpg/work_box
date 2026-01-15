import 'package:flutter/material.dart';
import 'package:work_box/core/theme/app_border_radius.dart';
import 'package:work_box/core/theme/app_colors.dart';
import 'package:work_box/core/theme/app_fonts.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    scaffoldBackgroundColor: Colors.grey[50],
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.accentPrimary,
      brightness: Brightness.light,
      primary: AppColors.accentPrimary,
      secondary: AppColors.accentSecondary,
      surface: Colors.white,
      error: AppColors.errorRed,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black87,
      onError: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: Colors.black87),
      titleTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        side: BorderSide(color: Colors.grey[300]!, width: 1),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey[300],
      thickness: 1,
    ),
    textTheme: TextTheme(
      displayLarge: AppFonts.displayLarge.copyWith(
        color: Colors.black87,
      ),
      displayMedium: AppFonts.displayMedium.copyWith(
        color: Colors.black87,
      ),
      displaySmall: AppFonts.displaySmall.copyWith(
        color: Colors.black87,
      ),
      headlineLarge: AppFonts.headlineLarge.copyWith(
        color: Colors.black87,
      ),
      headlineMedium: AppFonts.headlineMedium.copyWith(
        color: Colors.black87,
      ),
      headlineSmall: AppFonts.headlineSmall.copyWith(
        color: Colors.black87,
      ),
      titleLarge: AppFonts.titleLarge.copyWith(color: Colors.black87),
      titleMedium: AppFonts.titleMedium.copyWith(color: Colors.black87),
      titleSmall: AppFonts.titleSmall.copyWith(color: Colors.black87),
      bodyLarge: AppFonts.bodyLarge.copyWith(color: Colors.black54),
      bodyMedium: AppFonts.bodyMedium.copyWith(color: Colors.black54),
      bodySmall: AppFonts.bodySmall.copyWith(color: Colors.black38),
    ),
  );

  static final ThemeData dark = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBg,
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accentPrimary,
      secondary: AppColors.accentSecondary,
      surface: AppColors.cardBg,
      error: AppColors.errorRed,
      onPrimary: AppColors.textPrimary,
      onSecondary: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
      onError: AppColors.textPrimary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: AppColors.textPrimary),
      titleTextStyle: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.cardBg,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        side: BorderSide(color: AppColors.glassBorder, width: 1),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.textTertiary,
      thickness: 1,
    ),
    textTheme: TextTheme(
      displayLarge: AppFonts.displayLarge.copyWith(
        color: AppColors.textPrimary,
      ),
      displayMedium: AppFonts.displayMedium.copyWith(
        color: AppColors.textPrimary,
      ),
      displaySmall: AppFonts.displaySmall.copyWith(
        color: AppColors.textPrimary,
      ),
      headlineLarge: AppFonts.headlineLarge.copyWith(
        color: AppColors.textPrimary,
      ),
      headlineMedium: AppFonts.headlineMedium.copyWith(
        color: AppColors.textPrimary,
      ),
      headlineSmall: AppFonts.headlineSmall.copyWith(
        color: AppColors.textPrimary,
      ),
      titleLarge: AppFonts.titleLarge.copyWith(color: AppColors.textPrimary),
      titleMedium: AppFonts.titleMedium.copyWith(color: AppColors.textPrimary),
      titleSmall: AppFonts.titleSmall.copyWith(color: AppColors.textPrimary),
      bodyLarge: AppFonts.bodyLarge.copyWith(color: AppColors.textSecondary),
      bodyMedium: AppFonts.bodyMedium.copyWith(color: AppColors.textSecondary),
      bodySmall: AppFonts.bodySmall.copyWith(color: AppColors.textTertiary),
    ),
  );
}
