// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    DifficultyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DifficultyScreen(),
      );
    },
    LevelRoute.name: (routeData) {
      final args = routeData.argsAs<LevelRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LevelScreen(
          key: args.key,
          difficulty: args.difficulty,
        ),
      );
    },
    MainMenuRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainMenuScreen(),
      );
    },
    PauseRoute.name: (routeData) {
      final args = routeData.argsAs<PauseRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PauseScreen(
          key: args.key,
          timerBloc: args.timerBloc,
          gameBloc: args.gameBloc,
        ),
      );
    },
    PrivacyPolicyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PrivacyPolicyScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
    TermsOfUseRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TermsOfUseScreen(),
      );
    },
  };
}

/// generated route for
/// [DifficultyScreen]
class DifficultyRoute extends PageRouteInfo<void> {
  const DifficultyRoute({List<PageRouteInfo>? children})
      : super(
          DifficultyRoute.name,
          initialChildren: children,
        );

  static const String name = 'DifficultyRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LevelScreen]
class LevelRoute extends PageRouteInfo<LevelRouteArgs> {
  LevelRoute({
    Key? key,
    required Difficulty difficulty,
    List<PageRouteInfo>? children,
  }) : super(
          LevelRoute.name,
          args: LevelRouteArgs(
            key: key,
            difficulty: difficulty,
          ),
          initialChildren: children,
        );

  static const String name = 'LevelRoute';

  static const PageInfo<LevelRouteArgs> page = PageInfo<LevelRouteArgs>(name);
}

class LevelRouteArgs {
  const LevelRouteArgs({
    this.key,
    required this.difficulty,
  });

  final Key? key;

  final Difficulty difficulty;

  @override
  String toString() {
    return 'LevelRouteArgs{key: $key, difficulty: $difficulty}';
  }
}

/// generated route for
/// [MainMenuScreen]
class MainMenuRoute extends PageRouteInfo<void> {
  const MainMenuRoute({List<PageRouteInfo>? children})
      : super(
          MainMenuRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainMenuRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PauseScreen]
class PauseRoute extends PageRouteInfo<PauseRouteArgs> {
  PauseRoute({
    Key? key,
    required TimerBloc timerBloc,
    required GameBloc gameBloc,
    List<PageRouteInfo>? children,
  }) : super(
          PauseRoute.name,
          args: PauseRouteArgs(
            key: key,
            timerBloc: timerBloc,
            gameBloc: gameBloc,
          ),
          initialChildren: children,
        );

  static const String name = 'PauseRoute';

  static const PageInfo<PauseRouteArgs> page = PageInfo<PauseRouteArgs>(name);
}

class PauseRouteArgs {
  const PauseRouteArgs({
    this.key,
    required this.timerBloc,
    required this.gameBloc,
  });

  final Key? key;

  final TimerBloc timerBloc;

  final GameBloc gameBloc;

  @override
  String toString() {
    return 'PauseRouteArgs{key: $key, timerBloc: $timerBloc, gameBloc: $gameBloc}';
  }
}

/// generated route for
/// [PrivacyPolicyScreen]
class PrivacyPolicyRoute extends PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<PageRouteInfo>? children})
      : super(
          PrivacyPolicyRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrivacyPolicyRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TermsOfUseScreen]
class TermsOfUseRoute extends PageRouteInfo<void> {
  const TermsOfUseRoute({List<PageRouteInfo>? children})
      : super(
          TermsOfUseRoute.name,
          initialChildren: children,
        );

  static const String name = 'TermsOfUseRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
