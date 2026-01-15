import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/shared/widgets/custom_app_bar.dart';
import '../cubit/settings_cubit.dart';
import '../widgets/settings_theme_switch.dart';
import '../widgets/settings_app_info.dart';
import '../widgets/settings_clear_data.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Settings'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return Column(
                children: [
                  SettingsThemeSwitch(
                    isDarkMode: state.isDarkMode,
                    onChanged: (value) {
                      context.read<SettingsCubit>().toggleTheme(value);
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const SettingsAppInfo(),
                  const SizedBox(height: AppSpacing.md),
                  const SettingsClearData(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
