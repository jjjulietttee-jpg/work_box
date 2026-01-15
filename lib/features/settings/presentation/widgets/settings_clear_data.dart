import 'package:flutter/material.dart';

import '../../../../core/shared/widgets/glass_card.dart';
import '../../../../core/shared/widgets/confirmation_dialog.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/services/storage_service.dart';

class SettingsClearData extends StatelessWidget {
  const SettingsClearData({super.key});

  void _showClearDataDialog(BuildContext context) {
    ConfirmationDialog.show(
      context: context,
      title: 'Clear Data',
      message:
          'Are you sure you want to delete all app data? This action cannot be undone.',
      confirmText: 'Clear',
      cancelText: 'Cancel',
      icon: Icons.delete_outline,
      confirmColor: Theme.of(context).colorScheme.error,
      onConfirm: () async {
        final storageService = StorageService();
        await storageService.resetAll();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data cleared')),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: ListTile(
        title: const Text('Clear Data'),
        subtitle: const Text('Delete all app data'),
        trailing: const Icon(Icons.delete_outline),
        onTap: () => _showClearDataDialog(context),
      ),
    );
  }
}

