import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  static const String _keyDarkMode = 'dark_mode';
  static const String _keyThemeMode = 'theme_mode';
  static const String _keyUserName = 'user_name';
  static const String _keyHasShownProfileDialog = 'has_shown_profile_dialog';

  SettingsCubit() : super(SettingsState()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt(_keyThemeMode);
    final themeMode = themeModeIndex != null
        ? ThemeModeOption.values[themeModeIndex.clamp(0, 2)]
        : ThemeModeOption.dark;
    
    bool isDarkMode;
    if (themeMode == ThemeModeOption.system) {
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      isDarkMode = brightness == Brightness.dark;
    } else {
      isDarkMode = themeMode == ThemeModeOption.dark;
    }
    
    final storedDarkMode = prefs.getBool(_keyDarkMode);
    if (storedDarkMode != null) {
      isDarkMode = storedDarkMode;
    }
    
    final userName = prefs.getString(_keyUserName);
    emit(state.copyWith(
      isDarkMode: isDarkMode,
      themeMode: themeMode,
      userName: userName,
    ));
  }

  Future<void> setUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserName, name);
    emit(state.copyWith(userName: name));
  }

  Future<bool> shouldShowProfileDialog() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool(_keyHasShownProfileDialog) ?? false);
  }

  Future<void> markProfileDialogShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyHasShownProfileDialog, true);
  }

  Future<void> setThemeMode(ThemeModeOption mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyThemeMode, mode.index);
    
    bool isDarkMode;
    if (mode == ThemeModeOption.system) {
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      isDarkMode = brightness == Brightness.dark;
    } else {
      isDarkMode = mode == ThemeModeOption.dark;
    }
    
    await prefs.setBool(_keyDarkMode, isDarkMode);
    emit(state.copyWith(
      themeMode: mode,
      isDarkMode: isDarkMode,
    ));
  }

  void updateThemeFromSystem() {
    if (state.themeMode == ThemeModeOption.system) {
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      final isDarkMode = brightness == Brightness.dark;
      if (state.isDarkMode != isDarkMode) {
        emit(state.copyWith(isDarkMode: isDarkMode));
      }
    }
  }

  Future<void> toggleTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyDarkMode, isDark);
    final newMode = isDark ? ThemeModeOption.dark : ThemeModeOption.light;
    await prefs.setInt(_keyThemeMode, newMode.index);
    emit(state.copyWith(
      isDarkMode: isDark,
      themeMode: newMode,
    ));
  }
}

