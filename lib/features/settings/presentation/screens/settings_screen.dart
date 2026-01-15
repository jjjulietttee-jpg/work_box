import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/shared/widgets/custom_app_bar.dart';
import '../widgets/settings_profile_section.dart';
import '../widgets/settings_app_version.dart';
import '../widgets/settings_theme_selector.dart';
import '../widgets/settings_clear_data.dart';
import '../widgets/settings_contact_support.dart';
import '../widgets/settings_privacy_terms.dart';
import '../widgets/settings_about_app.dart';
import '../widgets/profile_name_dialog.dart';
import '../cubit/settings_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowProfileDialog();
    });
  }

  Future<void> _checkAndShowProfileDialog() async {
    final cubit = context.read<SettingsCubit>();
    final shouldShow = await cubit.shouldShowProfileDialog();
    if (shouldShow && mounted) {
      await ProfileNameDialog.show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Settings'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              const SettingsProfileSection(),
              const SizedBox(height: AppSpacing.md),
              const SettingsAppVersion(),
              const SizedBox(height: AppSpacing.md),
              const SettingsThemeSelector(),
              const SizedBox(height: AppSpacing.md),
              const SettingsClearData(),
              const SizedBox(height: AppSpacing.md),
              const SettingsContactSupport(),
              const SizedBox(height: AppSpacing.md),
              const SettingsPrivacyTerms(),
              const SizedBox(height: AppSpacing.md),
              const SettingsAboutApp(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
