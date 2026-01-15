import 'package:flutter/material.dart';

import '../../../../core/shared/widgets/glass_card.dart';
import '../../../../core/theme/app_spacing.dart';

class SettingsAboutApp extends StatelessWidget {
  const SettingsAboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About This App',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'WorkBox is a utility application that provides essential tools including a calculator, unit converter, and notes manager. The app is designed to work offline and does not require an internet connection for core functionality.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Data Collection: This app does not collect, store, or transmit any personal data. All data is stored locally on your device.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Account: No account registration is required. The app works with a local profile.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
