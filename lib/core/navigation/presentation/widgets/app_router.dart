import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:talker_flutter/talker_flutter.dart';
import '../../../bloc/bloc_providers.dart';
import '../../data/constants/navigation_constants.dart';
import '../../data/utils/page_transitions.dart';
import '../cubit/navigation_cubit.dart';
import 'bottom_navigation.dart';
import '../../../../features/home/presentation/screens/home_screen.dart';
import '../../../../features/notes/presentation/screens/notes_screen.dart';
import '../../../../features/calculator/presentation/screens/calculator_screen.dart';
import '../../../../features/converter/presentation/screens/converter_screen.dart';
import '../../../../features/settings/presentation/screens/settings_screen.dart';
import '../../../../features/settings/presentation/screens/webview_screen.dart';
import '../../../../features/activity_history/presentation/screens/activity_history_screen.dart';
import '../../../../features/how_it_works/presentation/screens/how_it_works_screen.dart';
import '../../../../core/constants/app_constants.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: NavigationConstants.home,
    observers: [TalkerRouteObserver(getIt<Talker>())],
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainShell(child: child);
        },
        routes: [
          GoRoute(
            path: NavigationConstants.home,
            pageBuilder: (context, state) => PageTransitions.fadeTransition(
              child: const HomeScreen(),
              state: state,
            ),
          ),
          GoRoute(
            path: NavigationConstants.settings,
            pageBuilder: (context, state) => PageTransitions.fadeTransition(
              child: BlocProviders.wrapWithProviders(
                context: context,
                child: const SettingsScreen(),
              ),
              state: state,
            ),
            routes: [
              GoRoute(
                path: 'privacy-policy',
                pageBuilder: (context, state) => PageTransitions.slideTransition(
                  child: const WebViewScreen(
                    url: AppConstants.privacyPolicyUrl,
                    title: 'Privacy Policy & Terms of Use',
                  ),
                  state: state,
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: NavigationConstants.notes,
        pageBuilder: (context, state) => PageTransitions.slideTransition(
          child: BlocProviders.wrapWithProviders(
            context: context,
            child: const NotesScreen(),
          ),
          state: state,
        ),
      ),
      GoRoute(
        path: NavigationConstants.calculator,
        pageBuilder: (context, state) => PageTransitions.slideTransition(
          child: BlocProviders.wrapWithProviders(
            context: context,
            child: const CalculatorScreen(),
          ),
          state: state,
        ),
      ),
      GoRoute(
        path: NavigationConstants.converter,
        pageBuilder: (context, state) => PageTransitions.slideTransition(
          child: BlocProviders.wrapWithProviders(
            context: context,
            child: const ConverterScreen(),
          ),
          state: state,
        ),
      ),
      GoRoute(
        path: NavigationConstants.activityHistory,
        pageBuilder: (context, state) => PageTransitions.slideTransition(
          child: BlocProviders.wrapWithProviders(
            context: context,
            child: const ActivityHistoryScreen(),
          ),
          state: state,
        ),
      ),
      GoRoute(
        path: NavigationConstants.howItWorks,
        pageBuilder: (context, state) => PageTransitions.slideTransition(
          child: BlocProviders.wrapWithProviders(
            context: context,
            child: const HowItWorksScreen(),
          ),
          state: state,
        ),
      ),
    ],
  );
}

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProviders.wrapWithProviders(
      context: context,
      child: _NavigationStateUpdater(child: child),
    );
  }
}

class _NavigationStateUpdater extends StatefulWidget {
  final Widget child;

  const _NavigationStateUpdater({required this.child});

  @override
  State<_NavigationStateUpdater> createState() =>
      _NavigationStateUpdaterState();
}

class _NavigationStateUpdaterState extends State<_NavigationStateUpdater> {
  String? _lastLocation;
  Brightness? _lastBrightness;

  void _updateNavigationState() {
    if (!mounted) return;

    final cubit = context.read<NavigationCubit>();
    final newLocation = GoRouterState.of(context).uri.path;
    final newBrightness = MediaQuery.platformBrightnessOf(context);
    final newIsDark = newBrightness == Brightness.dark;

    if (_lastLocation != newLocation) {
      cubit.updateCurrentRoute(newLocation);
      _lastLocation = newLocation;
    }
    if (_lastBrightness != newBrightness) {
      cubit.updateTheme(newIsDark);
      _lastBrightness = newBrightness;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateNavigationState();
    });

    AppRouter.router.routerDelegate.addListener(_onRouterChanged);
  }

  @override
  void dispose() {
    AppRouter.router.routerDelegate.removeListener(_onRouterChanged);
    super.dispose();
  }

  void _onRouterChanged() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _updateNavigationState();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newBrightness = MediaQuery.platformBrightnessOf(context);

    if (_lastBrightness != newBrightness) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateNavigationState();
      });
    }
  }

  bool _shouldShowBottomNavigation(String location) {
    return location == NavigationConstants.home ||
        location == NavigationConstants.settings;
  }

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.path;
    final showBottomNav = _shouldShowBottomNavigation(currentLocation);

    return Scaffold(
      body: Stack(
        children: [
          widget.child,
          if (showBottomNav)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: CustomBottomNavigation(),
            ),
          ),
        ],
      ),
    );
  }
}
