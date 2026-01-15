part of 'settings_cubit.dart';

enum ThemeModeOption {
  system,
  light,
  dark,
}

class SettingsState extends Equatable {
  final bool isDarkMode;
  final ThemeModeOption themeMode;
  final String? userName;

  const SettingsState({
    this.isDarkMode = true,
    this.themeMode = ThemeModeOption.dark,
    this.userName,
  });

  SettingsState copyWith({
    bool? isDarkMode,
    ThemeModeOption? themeMode,
    String? userName,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      themeMode: themeMode ?? this.themeMode,
      userName: userName ?? this.userName,
    );
  }

  @override
  List<Object?> get props => [isDarkMode, themeMode, userName];
}

