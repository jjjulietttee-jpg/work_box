import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/shared/widgets/glass_card.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/navigation/data/constants/navigation_constants.dart';

class SettingsPrivacyTerms extends StatelessWidget {
  const SettingsPrivacyTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: ListTile(
        title: const Text('Privacy Policy & Terms of Use'),
        subtitle: const Text('View privacy policy and terms of use'),
        trailing: const Icon(Icons.description_outlined),
        onTap: () => context.push('${NavigationConstants.settings}/privacy-policy'),
      ),
    );
  }
}
