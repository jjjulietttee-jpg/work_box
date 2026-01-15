import 'package:flutter/material.dart';

import '../../../../core/shared/widgets/glass_card.dart';
import '../../../../core/theme/app_spacing.dart';

class SettingsAppInfo extends StatelessWidget {
  const SettingsAppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: const ListTile(
        title: Text('App Info'),
        subtitle: Text('WorkBox v1.0.0'),
        trailing: Icon(Icons.info_outline),
      ),
    );
  }
}

