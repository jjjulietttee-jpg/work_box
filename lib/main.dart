import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/bloc/bloc_providers.dart' show BlocProviders, getIt;
import 'core/navigation/presentation/widgets/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/services/activity_tracker_service.dart';
import 'features/settings/presentation/cubit/settings_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BlocProviders.setup();
  
  // Track first launch
  final prefs = await SharedPreferences.getInstance();
  final hasLaunched = prefs.getBool('app_has_launched') ?? false;
  if (!hasLaunched) {
    await prefs.setBool('app_has_launched', true);
    ActivityTrackerService.trackAppFirstLaunch();
  }
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    getIt<SettingsCubit>().updateThemeFromSystem();
  }

  ThemeMode _getThemeMode(SettingsState state) {
    switch (state.themeMode) {
      case ThemeModeOption.system:
        return ThemeMode.system;
      case ThemeModeOption.light:
        return ThemeMode.light;
      case ThemeModeOption.dark:
        return ThemeMode.dark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>.value(
      value: getIt<SettingsCubit>(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'WorkBox',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: _getThemeMode(state),
            routerConfig: AppRouter.router,
            builder: (context, child) {
              return BlocProviders.wrapWithProviders(
                context: context,
                child: child ?? const SizedBox.shrink(),
              );
            },
          );
        },
      ),
    );
  }
}
