import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  Color get cardBgColor {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark
        ? const Color(0xFF181C3A)
        : Colors.white;
  }

  Color get cardBgLightColor {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark
        ? const Color(0xFF1E2335)
        : Colors.grey[50]!;
  }

  Color get textPrimaryColor {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark
        ? const Color(0xFFFFFFFF)
        : Colors.black87;
  }

  Color get textSecondaryColor {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark
        ? const Color(0xFFB0B8C9)
        : Colors.black54;
  }

  Color get textTertiaryColor {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark
        ? const Color(0xFF6B7280)
        : Colors.black38;
  }

  Color get glassBorderColor {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark
        ? const Color(0x30FFFFFF)
        : Colors.grey[300]!;
  }

  Color get glowPrimaryColor {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark
        ? const Color(0x405F7CFF)
        : const Color(0x205F7CFF);
  }
}

