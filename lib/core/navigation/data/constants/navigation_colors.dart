import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'bottom_navigation_ui_constants.dart';

class NavigationColors {
  NavigationColors._();

  static Color getSelectedIconColor(bool isDark) {
    if (isDark) {
      // Светлее в темной теме для лучшей видимости
      return const Color.fromARGB(255, 241, 243, 252); // Более светлый оттенок accentPrimary
    }
    return const Color.fromARGB(255, 246, 248, 255);
  }

  static const Color unselectedIconColor = AppColors.textSecondary;

  static Color getSelectedGlowColor() => Colors.grey.withValues(
        alpha: BottomNavigationUIConstants.selectedGlowOpacity,
      );

  static Color getUnselectedGlowColor() => Colors.white.withValues(
        alpha: BottomNavigationUIConstants.unselectedIconOpacity,
      );

  static Color getGlassGlowColor() => Colors.white.withValues(
        alpha: BottomNavigationUIConstants.glassGlowOpacity,
      );

  static Color getIndicatorShadowColor() => Colors.grey.withValues(
        alpha: BottomNavigationUIConstants.indicatorShadowOpacity,
      );

  static Color getContainerShadowColor() => Colors.black.withValues(
        alpha: BottomNavigationUIConstants.shadowOpacity,
      );

  static Color getBorderColor(bool isDark) {
    if (isDark) {
      return Colors.white.withValues(
        alpha: BottomNavigationUIConstants.borderOpacity,
      );
    } else {
      return Colors.black.withValues(
        alpha: BottomNavigationUIConstants.borderOpacityLight,
      );
    }
  }

  static double getBorderWidth(bool isDark) {
    return isDark
        ? BottomNavigationUIConstants.borderWidth
        : BottomNavigationUIConstants.borderWidthLight;
  }

  static Color getGlassColor(bool isDark) => Colors.white.withValues(
        alpha: isDark
            ? BottomNavigationUIConstants.glassColorOpacityDark
            : BottomNavigationUIConstants.glassColorOpacityLight,
      );
}

