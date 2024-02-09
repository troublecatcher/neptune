import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../bloc/game.dart';
import '../screens/screens.dart';
import '../timer/timer_bloc.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MainMenuRoute.page, initial: true),
        CustomRoute(
            page: LevelRoute.page,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        AutoRoute(page: DifficultyRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: PrivacyPolicyRoute.page),
        AutoRoute(page: TermsOfUseRoute.page),
        CustomRoute(
            page: PauseRoute.page,
            transitionsBuilder: TransitionsBuilders.fadeIn),
      ];
}
