import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:neptune/const/color.dart';
import 'package:neptune/router/router.dart';
import 'package:neptune/widgets/icon_button.dart';

import '../bloc/audio.dart';
import '../main.dart';

@RoutePage()
class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioBloc = BlocProvider.of<AudioBloc>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg/main_menu.png"),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Stack(
            children: [
              // SvgPicture.asset(
              //   'assets/bg/main_menu.svg',
              //   alignment: Alignment.center,
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height,
              // ),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height / 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Neptune ',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Text(
                      'games',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height / 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          BlocBuilder<AudioBloc, AudioState>(
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
                          Padding(
                            padding: EdgeInsets.only(
                                left: 5 *
                                    MediaQuery.of(context).devicePixelRatio),
                            child: CustomIconButton(
                              path: 'assets/icons/settings.svg',
                              callback: (_) {
                                context.router.push(const SettingsRoute());
                              },
                              radius: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Main menu',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  4 * MediaQuery.of(context).devicePixelRatio),
                          child: ElevatedButton(
                              onPressed: () {
                                context.router.push(const DifficultyRoute());
                              },
                              child: Text(
                                'Start game',
                                style: Theme.of(context).textTheme.displaySmall,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 6),
                          child: ElevatedButton(
                              onPressed: () {
                                FlutterExitApp.exitApp(iosForceExit: true);
                              },
                              child: Text('Exit',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall)),
                        ),
                      ],
                    )),
                    Expanded(child: Container()),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
