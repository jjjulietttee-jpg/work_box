import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/widgets/glass_card.dart';
import '../../../../core/theme/app_spacing.dart';
import '../cubit/settings_cubit.dart';

class SettingsThemeSelector extends StatelessWidget {
  const SettingsThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return GlassCard(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Column(
            children: [
              ListTile(
                title: const Text('Theme'),
                subtitle: Text(_getThemeModeText(state.themeMode)),
                trailing: const Icon(Icons.palette_outlined),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: SegmentedButton<ThemeModeOption>(
                  segments: const [
                    ButtonSegment(
                      value: ThemeModeOption.system,
                      label: Text('System'),
                      icon: Icon(Icons.brightness_auto),
                    ),
                    ButtonSegment(
                      value: ThemeModeOption.light,
                      label: Text('Light'),
                      icon: Icon(Icons.light_mode),
                    ),
                    ButtonSegment(
                      value: ThemeModeOption.dark,
                      label: Text('Dark'),
                      icon: Icon(Icons.dark_mode),
                    ),
                  ],
                  selected: {state.themeMode},
                  onSelectionChanged: (Set<ThemeModeOption> selection) {
                    if (selection.isNotEmpty) {
                      context.read<SettingsCubit>().setThemeMode(selection.first);
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getThemeModeText(ThemeModeOption mode) {
    switch (mode) {
      case ThemeModeOption.system:
        return 'Follow system theme';
      case ThemeModeOption.light:
        return 'Light theme';
      case ThemeModeOption.dark:
        return 'Dark theme';
    }
  }
}
