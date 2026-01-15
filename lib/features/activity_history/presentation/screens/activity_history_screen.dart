import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/widgets/custom_app_bar.dart';
import '../../../../core/shared/widgets/confirmation_dialog.dart';
import '../../../../core/theme/app_spacing.dart';
import '../cubit/activity_history_cubit.dart';
import '../widgets/activity_item_widget.dart';
import '../widgets/activity_empty_state.dart';

class ActivityHistoryScreen extends StatefulWidget {
  const ActivityHistoryScreen({super.key});

  @override
  State<ActivityHistoryScreen> createState() => _ActivityHistoryScreenState();
}

class _ActivityHistoryScreenState extends State<ActivityHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ActivityHistoryCubit>().loadActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Activity History',
        showBackButton: true,
      ),
      body: BlocBuilder<ActivityHistoryCubit, ActivityHistoryState>(
        builder: (context, state) {
          if (state is ActivityHistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ActivityHistoryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ActivityHistoryCubit>().loadActivities();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is ActivityHistoryLoaded) {
            if (state.activities.isEmpty) {
              return const ActivityEmptyState();
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: state.activities.length,
                    itemBuilder: (context, index) {
                      final activity = state.activities[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: ActivityItemWidget(activity: activity),
                      );
                    },
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => _showClearDialog(context),
                        icon: const Icon(Icons.delete_outline),
                        label: const Text('Clear History'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.error,
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showClearDialog(BuildContext context) {
    ConfirmationDialog.show(
      context: context,
      title: 'Clear History',
      message: 'Are you sure you want to clear all activity history? This action cannot be undone.',
      confirmText: 'Clear',
      cancelText: 'Cancel',
      icon: Icons.delete_outline,
      confirmColor: Theme.of(context).colorScheme.error,
      onConfirm: () {
        context.read<ActivityHistoryCubit>().clearHistory();
      },
    );
  }
}
