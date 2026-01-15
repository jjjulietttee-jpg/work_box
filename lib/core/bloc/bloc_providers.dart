import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navigation/presentation/cubit/navigation_cubit.dart';
import '../navigation/presentation/widgets/app_router.dart';
import '../navigation/data/constants/navigation_constants.dart';
import '../services/storage_service.dart';
import '../../features/notes/domain/repositories/notes_repository.dart';
import '../../features/notes/data/repositories/notes_repository_impl.dart';
import '../../features/notes/data/datasources/notes_local_datasource.dart';
import '../../features/notes/presentation/cubit/notes_cubit.dart';
import '../../features/notes/domain/usecases/get_notes.dart';
import '../../features/notes/domain/usecases/save_note.dart';
import '../../features/notes/domain/usecases/delete_note.dart';
import '../../features/notes/domain/usecases/search_notes.dart';
import '../../features/calculator/presentation/cubit/calculator_cubit.dart';
import '../../features/converter/presentation/cubit/converter_cubit.dart';
import '../../features/settings/presentation/cubit/settings_cubit.dart';
import '../../features/activity_history/domain/repositories/activity_repository.dart';
import '../../features/activity_history/data/repositories/activity_repository_impl.dart';
import '../../features/activity_history/data/datasources/activity_local_datasource.dart';
import '../../features/activity_history/presentation/cubit/activity_history_cubit.dart';
import '../../features/activity_history/domain/usecases/get_activity_history.dart';
import '../../features/activity_history/domain/usecases/add_activity.dart';
import '../../features/activity_history/domain/usecases/clear_activity_history.dart';

final GetIt getIt = GetIt.instance;

class BlocProviders {
  BlocProviders._();

  static Future<void> setup() async {
    _registerTalker();
    await _registerSharedPreferences();
    _registerNavigationCubit();
    _registerStorageService();
    _registerNotesRepositories();
    _registerNotesCubit();
    _registerCalculatorCubit();
    _registerConverterCubit();
    _registerSettingsCubit();
    _registerActivityHistoryRepositories();
    _registerActivityHistoryCubit();
  }

  static void _registerTalker() {
    getIt.registerLazySingleton<Talker>(
      () => TalkerFlutter.init(settings: TalkerSettings(enabled: true)),
    );
  }

  static void _registerNavigationCubit() {
    getIt.registerFactoryParam<NavigationCubit, String, bool>(
      (currentLocation, isDark) =>
          NavigationCubit(currentLocation: currentLocation, isDark: isDark),
    );
  }

  static Future<void> _registerSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    getIt.registerLazySingleton<SharedPreferences>(() => prefs);
  }

  static void _registerStorageService() {
    getIt.registerLazySingleton<StorageService>(
      () => StorageService(),
    );
  }

  static void _registerNotesRepositories() {
    getIt.registerLazySingleton<NotesLocalDataSource>(
      () => NotesLocalDataSourceImpl(getIt<SharedPreferences>()),
    );
    
    getIt.registerLazySingleton<NotesRepository>(
      () => NotesRepositoryImpl(getIt<NotesLocalDataSource>()),
    );
  }

  static void _registerNotesCubit() {
    getIt.registerFactory<NotesCubit>(
      () => NotesCubit(
        getNotes: GetNotes(getIt<NotesRepository>()),
        saveNote: SaveNote(getIt<NotesRepository>()),
        deleteNote: DeleteNote(getIt<NotesRepository>()),
        searchNotes: SearchNotes(getIt<NotesRepository>()),
      ),
    );
  }

  static void _registerCalculatorCubit() {
    getIt.registerFactory<CalculatorCubit>(() => CalculatorCubit());
  }

  static void _registerConverterCubit() {
    getIt.registerFactory<ConverterCubit>(() => ConverterCubit());
  }

  static void _registerSettingsCubit() {
    getIt.registerLazySingleton<SettingsCubit>(() => SettingsCubit());
  }

  static void _registerActivityHistoryRepositories() {
    getIt.registerLazySingleton<ActivityLocalDataSource>(
      () => ActivityLocalDataSourceImpl(getIt<SharedPreferences>()),
    );
    
    getIt.registerLazySingleton<ActivityRepository>(
      () => ActivityRepositoryImpl(getIt<ActivityLocalDataSource>()),
    );
  }

  static void _registerActivityHistoryCubit() {
    getIt.registerFactory<ActivityHistoryCubit>(
      () => ActivityHistoryCubit(
        getActivityHistory: GetActivityHistory(getIt<ActivityRepository>()),
        addActivity: AddActivity(getIt<ActivityRepository>()),
        clearActivityHistory: ClearActivityHistory(getIt<ActivityRepository>()),
      ),
    );
  }

  static Widget wrapWithProviders({
    required BuildContext context,
    required Widget child,
  }) {
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDark = brightness == Brightness.dark;

    String currentLocation;
    try {
      currentLocation =
          AppRouter.router.routerDelegate.currentConfiguration.uri.path;
      if (currentLocation.isEmpty) {
        currentLocation = NavigationConstants.home;
      }
    } catch (_) {
      currentLocation = NavigationConstants.home;
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(
          create: (_) =>
              getIt<NavigationCubit>(param1: currentLocation, param2: isDark),
        ),
        BlocProvider<NotesCubit>(
          create: (_) => getIt<NotesCubit>(),
        ),
        BlocProvider<CalculatorCubit>(
          create: (_) => getIt<CalculatorCubit>(),
        ),
        BlocProvider<ConverterCubit>(
          create: (_) => getIt<ConverterCubit>(),
        ),
        BlocProvider<SettingsCubit>.value(
          value: getIt<SettingsCubit>(),
        ),
        BlocProvider<ActivityHistoryCubit>(
          create: (_) => getIt<ActivityHistoryCubit>(),
        ),
      ],
      child: child,
    );
  }
}
