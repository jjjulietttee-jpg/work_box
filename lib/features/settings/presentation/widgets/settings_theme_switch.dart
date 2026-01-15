import 'package:flutter/material.dart';

import '../../../../core/shared/widgets/glass_card.dart';
import '../../../../core/theme/app_spacing.dart';

class SettingsThemeSwitch extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onChanged;

  const SettingsThemeSwitch({
    super.key,
    required this.isDarkMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: SwitchListTile(
        title: const Text('Dark Mode'),
        subtitle: Text(isDarkMode ? 'Dark theme enabled' : 'Light theme enabled'),
        value: isDarkMode,
        onChanged: onChanged,
      ),
    );
  }
}

