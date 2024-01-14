import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neptune/const/color.dart';

import '../bloc/audio.dart';
import '../bloc/game.dart';
import '../router/router.dart';
import '../timer/timer_bloc.dart';
import '../widgets/icon_button.dart';

@RoutePage()
class PauseScreen extends StatelessWidget {
  final TimerBloc timerBloc;
  final GameBloc gameBloc;

  const PauseScreen({Key? key, required this.timerBloc, required this.gameBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioBloc = BlocProvider.of<AudioBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 20),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: 5 * MediaQuery.of(context).devicePixelRatio),
                      child: BlocBuilder<AudioBloc, AudioState>(
                        builder: (context, state) {
                          return CustomIconButton(
                            path: state.iconAsset,
                            callback: (_) {
                              if (state.isPlaying) {
                                audioBloc.add(AudioEvent.pause);
                              } else {
                                audioBloc.add(AudioEvent.play);
                              }
                            },
                            radius: 16,
                          );
                        },
                      ),
                    ),
                    CustomIconButton(
                      path: 'assets/icons/settings.svg',
                      callback: (_) {
                        context.router.push(const SettingsRoute());
                      },
                      radius: 16,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Pause',
                      style: Theme.of(context).textTheme.displayLarge),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 4 * MediaQuery.of(context).devicePixelRatio),
                    child: ElevatedButton(
                        onPressed: () {
                          timerBloc.add(const TimerResumed(1));
                          context.router.pop();
                        },
                        child: Text('Continue',
                            style: Theme.of(context).textTheme.displaySmall)),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        gameBloc.add(GameRestartEvent());
                      },
                      child: Text('Restart',
                          style: Theme.of(context).textTheme.displaySmall)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 4 * MediaQuery.of(context).devicePixelRatio),
                    child: ElevatedButton(
                        onPressed: () {
                          context.router.pushAndPopUntil(
                            MainMenuRoute(),
                            predicate: (_) => false,
                          );
                        },
                        child: Text('To main',
                            style: Theme.of(context).textTheme.displaySmall)),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        FlutterExitApp.exitApp(iosForceExit: true);
                      },
                      child: Text('Exit',
                          style: Theme.of(context).textTheme.displaySmall)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
