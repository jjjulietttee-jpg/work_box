import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/widgets/glass_card.dart';
import '../../../../core/shared/widgets/confirmation_dialog.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/services/activity_tracker_service.dart';
import '../../../../core/bloc/bloc_providers.dart' show getIt;
import '../../../notes/presentation/cubit/notes_cubit.dart';
import '../../../activity_history/presentation/cubit/activity_history_cubit.dart';

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
        
        // Clear activity history
        try {
          final activityCubit = getIt<ActivityHistoryCubit>();
          await activityCubit.clearHistory();
        } catch (_) {
          // ActivityHistoryCubit might not be available
        }
        
        ActivityTrackerService.trackDataReset();
        
        if (context.mounted) {
          try {
            context.read<NotesCubit>().loadNotes();
          } catch (_) {
            // NotesCubit might not be available in this context
          }
          
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

