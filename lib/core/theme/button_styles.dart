import 'package:flutter/material.dart';
import 'package:work_box/core/theme/app_border_radius.dart';
import 'package:work_box/core/theme/app_colors.dart';

ButtonStyle primaryButtonStyle({double radius = AppBorderRadius.md}) {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color?>(
      (states) => states.contains(WidgetState.disabled)
          ? AppColors.accentPrimary.withOpacity(0.5)
          : AppColors.accentPrimary,
    ),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
    ),
    overlayColor: WidgetStateProperty.resolveWith<Color?>(
      (states) => states.contains(WidgetState.pressed)
          ? AppColors.textPrimary.withOpacity(0.26)
          : AppColors.textPrimary.withOpacity(0.06),
    ),
    elevation: WidgetStateProperty.resolveWith<double>(
      (states) => states.contains(WidgetState.pressed) ? 6.0 : 0.0,
    ),
    shadowColor: WidgetStateProperty.all<Color>(AppColors.glowPrimary),
  );
}
