import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neptune/screens/screens.dart';
import 'package:neptune/widgets/sound_and_settings.dart';
import 'package:neptune/widgets/svg_title.dart';
import 'package:neptune/widgets/widget_padding.dart';

import '../bloc/audio.dart';
import '../bloc/game.dart';
import '../router/router.dart';
import '../timer/timer_bloc.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/custom_texticon_button.dart';
import '../widgets/icon_button.dart';

@RoutePage()
class PauseScreen extends StatelessWidget {
  final TimerBloc timerBloc;
  final GameBloc gameBloc;
  final Difficulty difficulty;

  const PauseScreen(
      {Key? key,
      required this.timerBloc,
      required this.gameBloc,
      required this.difficulty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioBloc = BlocProvider.of<AudioBloc>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(difficulty.pauseImagePath),
                fit: BoxFit.cover)),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Color.fromRGBO(0, 0, 0, 0.5),
              ],
            ),
            backgroundBlendMode: BlendMode.darken,
          ),
          child: SafeArea(
            child: WidgetPadding(
              child: Stack(
                children: [
                  SoundAndSettings(audioBloc: audioBloc),
                  const SvgTitle(path: 'assets/titles/pause.svg'),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomTextButton(
                            callback: (_) {
                              timerBloc.add(const TimerResumed(1));
                              context.router.pop();
                            },
                            children: [
                              Text('Continue',
                                  style:
                                      Theme.of(context).textTheme.displaySmall)
                            ]),
                        const SizedBox(height: 10),
                        CustomTextButton(
                            callback: (_) {
                              gameBloc.add(GameRestartEvent());
                            },
                            children: [
                              Text('Restart',
                                  style:
                                      Theme.of(context).textTheme.displaySmall)
                            ]),
                        const SizedBox(height: 10),
                        CustomTextButton(
                            callback: (_) {
                              context.router.pushAndPopUntil(
                                MainMenuRoute(),
                                predicate: (_) => false,
                              );
                            },
                            children: [
                              Text('To main',
                                  style:
                                      Theme.of(context).textTheme.displaySmall)
                            ]),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CustomTextIconButton(
                        callback: (_) {
                          FlutterExitApp.exitApp(iosForceExit: true);
                        },
                        children: [
                          SvgPicture.asset('assets/icons/exit.svg'),
                          const SizedBox(width: 10),
                          Text('Exit',
                              style: Theme.of(context).textTheme.displaySmall),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
