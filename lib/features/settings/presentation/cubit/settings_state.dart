part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool isDarkMode;

  const SettingsState({this.isDarkMode = true});

  SettingsState copyWith({bool? isDarkMode}) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  @override
  List<Object> get props => [isDarkMode];
}

