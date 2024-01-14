import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/audio.dart';
import '../router/router.dart';
import '../widgets/icon_button.dart';

enum Difficulty {
  easy(Duration(minutes: 5), 'Easy'),
  normal(Duration(minutes: 2), 'Normal'),
  hard(Duration(minutes: 1, seconds: 30), 'Hard');

  final Duration gameTime;
  final String name;

  const Difficulty(this.gameTime, this.name);
}

@RoutePage()
class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final audioBloc = BlocProvider.of<AudioBloc>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg/levels_of_difficulty.jpeg'),
                fit: BoxFit.fill)),
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height / 15),
                child: CustomIconButton(
                  path: 'assets/icons/back.svg',
                  callback: context.router.pop,
                  radius: 8,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 15),
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
                            left: 5 * MediaQuery.of(context).devicePixelRatio),
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
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 3),
                  child: Column(
                    children: [
                      Text(
                        'Levels of difficulty',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                4 * MediaQuery.of(context).devicePixelRatio),
                        child: ElevatedButton(
                            onPressed: () {
                              context.router.replaceAll(
                                  [LevelRoute(difficulty: Difficulty.easy)]);
                            },
                            child: Text('Easy',
                                style:
                                    Theme.of(context).textTheme.displaySmall)),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            context.router.replaceAll(
                                [LevelRoute(difficulty: Difficulty.normal)]);
                          },
                          child: Text('Normal',
                              style: Theme.of(context).textTheme.displaySmall)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                4 * MediaQuery.of(context).devicePixelRatio),
                        child: ElevatedButton(
                            onPressed: () {
                              context.router.replaceAll(
                                  [LevelRoute(difficulty: Difficulty.hard)]);
                            },
                            child: Text('Hard',
                                style:
                                    Theme.of(context).textTheme.displaySmall)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
