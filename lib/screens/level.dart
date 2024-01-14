import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neptune/bloc/matching.dart';
import 'package:neptune/const/color.dart';
import 'package:neptune/router/router.dart';
import 'package:neptune/widgets/icon_button.dart';

import '../bloc/game.dart';
import '../timer/ticker.dart';
import '../timer/timer_bloc.dart';
import 'difficulty.dart';

var disclosureStatus;
late List<String> pictures;
var selectedPictures;
var selectedIndexes;

@RoutePage()
class LevelScreen extends StatelessWidget {
  final Difficulty difficulty;

  const LevelScreen({Key? key, required this.difficulty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameBloc>(
          create: (context) => GameBloc(difficulty: difficulty, level: 1),
        ),
        BlocProvider<MatchingBloc>(
          create: (context) => MatchingBloc(),
        ),
        BlocProvider<TimerBloc>(
          create: (context) => TimerBloc(ticker: const Ticker()),
        ),
      ],
      child: _LevelScreenBody(difficulty: difficulty),
    );
  }
}

class _LevelScreenBody extends StatelessWidget {
  final Difficulty difficulty;

  const _LevelScreenBody({Key? key, required this.difficulty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    initialize(context);
    BlocProvider.of<GameBloc>(context).stream.listen((state) async {
      // if (state is GameRunningState) {
      //   initialize(context);
      // }
      if (state is GamePausedState) {
        BlocProvider.of<TimerBloc>(context).add(const TimerPaused());
      }
      if (state is GameWonState) {
        BlocProvider.of<GameBloc>(context).add(GamePauseEvent());
        YYDialog().build(context)
          ..width = MediaQuery.of(context).size.width * 0.5
          ..borderRadius = 16
          ..backgroundColor = color1
          ..barrierDismissible = false
          ..animatedFunc = (child, animation) {
            return ScaleTransition(
              child: child,
              scale: Tween(begin: 0.0, end: 1.0).animate(animation),
            );
          }
          ..widget(
            Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Level complete',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          'You’ve passed the ${difficulty.name} difficulty level.',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      difficulty == Difficulty.hard
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            color3)),
                                child: const Text('The Next Difficulty'),
                                onPressed: () {
                                  // BlocProvider.of<GameBloc>(context)
                                  //     .add(GameRestartEvent());
                                  BlocProvider.of<MatchingBloc>(context)
                                      .add(InitialMatchingEvent());
                                  context.router.pushAndPopUntil(
                                    LevelRoute(
                                        difficulty:
                                            difficulty == Difficulty.easy
                                                ? Difficulty.normal
                                                : Difficulty.hard),
                                    predicate: (_) => false,
                                  );
                                  context.router.pop();
                                },
                              ),
                            ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(color2)),
                          onPressed: () {
                            context.router.pushAndPopUntil(
                              const MainMenuRoute(),
                              predicate: (_) => false,
                            );
                          },
                          child: const Text('Back to menu')),
                    ])),
          )
          ..show();
      }
      if (state is GameRestartedState) {
        BlocProvider.of<MatchingBloc>(context).add(InitialMatchingEvent());
        await context.router.pushAndPopUntil(
          LevelRoute(difficulty: difficulty),
          predicate: (_) => false,
        );
      }
      if (state is GameResetState) {
        BlocProvider.of<MatchingBloc>(context).add(InitialMatchingEvent());
        initialize(context);
      }
    });
    BlocProvider.of<MatchingBloc>(context).stream.listen((state) async {
      if (state is ImageMatchState &&
          disclosureStatus.where((status) => !status).length == 3) {
        BlocProvider.of<MatchingBloc>(context).add(InitialMatchingEvent());
        BlocProvider.of<GameBloc>(context).add(GameNextLevelEvent());
      }
      if (state is ImageMismatchState) {
        disclosureStatus[state.image1] = true;
        disclosureStatus[state.image2] = true;
        await Future.delayed(const Duration(milliseconds: 500));
        disclosureStatus[state.image1] = false;
        disclosureStatus[state.image2] = false;
        BlocProvider.of<MatchingBloc>(context).add(InitialMatchingEvent());
      }
    });

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TimerBloc, TimerState>(
          builder: (context, state) {
            if (state is TimerRunInProgress &&
                BlocProvider.of<GameBloc>(context).state
                    is GameCountdownState) {
              return Center(
                child: Text(
                  state.duration.toString(),
                  style: TextStyle(
                      fontSize: 100 * MediaQuery.of(context).devicePixelRatio,
                      fontFamily: 'Roboto',
                      color: Colors.white),
                ),
              );
            } else {
              return Stack(
                children: [
                  BlocBuilder<TimerBloc, TimerState>(
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        color: color1,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8))),
                                    child: Text(
                                      'Level',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(color: color2),
                                    child: Text(
                                        '${BlocProvider.of<GameBloc>(context).level} / 5',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        color: color3,
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            bottomRight: Radius.circular(8))),
                                    child: Text(difficulty.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        color: color1,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8))),
                                    child: Text('Time',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        color: color2,
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            bottomRight: Radius.circular(8))),
                                    child: Text(
                                        '${(state.duration / 60).floor()}:${state.duration.remainder(60).toString().padLeft(2, '0')}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomIconButton(
                                      path: 'assets/icons/menu.svg',
                                      callback: (_) {
                                        BlocProvider.of<TimerBloc>(context)
                                            .add(const TimerPaused());
                                        context.router.navigate(PauseRoute(
                                            timerBloc:
                                                context.read<TimerBloc>(),
                                            gameBloc:
                                                context.read<GameBloc>()));
                                      },
                                      radius: 8),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  BlocBuilder<MatchingBloc, MatchingState>(
                    builder: (context, state) {
                      if (state is ImageMatchState) {
                        disclosureStatus[state.image1] = true;
                        disclosureStatus[state.image2] = true;
                      }

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 9,
                            ),
                            itemCount: pictures.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if (!disclosureStatus[index] &&
                                      context.read<MatchingBloc>().state
                                          is! ImageMismatchState) {
                                    BlocProvider.of<MatchingBloc>(context).add(
                                        ImageSelected(pictures[index], index));
                                  }
                                },
                                child: BlocBuilder<MatchingBloc, MatchingState>(
                                  builder: (context, state) {
                                    if (state is ImageMatchState) {
                                      disclosureStatus[state.image1] = true;
                                      disclosureStatus[state.image2] = true;
                                    }
                                    if (state is ImageSelectedState &&
                                        state.index == index) {
                                      return Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.white, width: 5),
                                        ),
                                        child: Image.asset(
                                          pictures[index],
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        padding: const EdgeInsets.all(4),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8)),
                                          child: disclosureStatus[index]
                                              ? Image.asset(
                                                  pictures[index],
                                                  fit: BoxFit.cover,
                                                )
                                              : SvgPicture.asset(
                                                  'assets/cards/card.svg',
                                                  fit: BoxFit.cover,
                                                ),
                                          // ? SvgPicture.asset(
                                          //     'assets/cards/card.svg',
                                          //     fit: BoxFit.cover,
                                          //   )
                                          // : Image.asset(
                                          //     pictures[index],
                                          //     fit: BoxFit.cover,
                                          //   ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void initialize(BuildContext context) {
    if (BlocProvider.of<GameBloc>(context).state is GameResetState) {
      BlocProvider.of<GameBloc>(context).add(GameCountdownEvent());
    }
    pictures = [];
    disclosureStatus = [];
    disclosureStatus = List.filled(27, false);
    BlocProvider.of<TimerBloc>(context).add(TimerReset());
    BlocProvider.of<TimerBloc>(context).add(const TimerStarted(3));
    var allPictures =
        List.generate(40, (index) => 'assets/cards/image${index + 1}.jpg');
    selectedIndexes = [];
    selectedPictures = [];
    while (selectedPictures.length < 14) {
      var randomIndex = Random().nextInt(allPictures.length);
      if (!selectedIndexes.contains(randomIndex)) {
        selectedPictures.add(allPictures[randomIndex]);
        selectedIndexes.add(randomIndex);
      }
    }
    for (var i = 0; i < 13; i++) {
      pictures.add(selectedPictures[i]);
      pictures.add(selectedPictures[i]);
    }
    pictures.add(selectedPictures.last);
    pictures.shuffle();

    BlocProvider.of<TimerBloc>(context).stream.listen((state) {
      if (state is TimerRunComplete) {
        if (BlocProvider.of<GameBloc>(context).state is GameCountdownState) {
          BlocProvider.of<GameBloc>(context).add(GameRunEvent());
          BlocProvider.of<TimerBloc>(context)
              .add(TimerStarted(difficulty.gameTime.inSeconds));
        }
        if (BlocProvider.of<GameBloc>(context).state is GameRunningState) {
          YYDialog().build(context)
            ..width = MediaQuery.of(context).size.width * 0.5
            ..borderRadius = 16
            ..backgroundColor = color1
            ..barrierDismissible = false
            ..animatedFunc = (child, animation) {
              return ScaleTransition(
                scale: Tween(begin: 0.0, end: 1.0).animate(animation),
                child: child,
              );
            }
            ..widget(
              Padding(
                  padding: const EdgeInsets.all(30),
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Level lost',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              'You’ve ran out of time.',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(color3)),
                              child: const Text('Try again'),
                              onPressed: () {
                                BlocProvider.of<GameBloc>(context)
                                    .add(GameRestartEvent());
                                BlocProvider.of<MatchingBloc>(context)
                                    .add(InitialMatchingEvent());
                              },
                            ),
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(color2)),
                              onPressed: () {
                                context.router.pushAndPopUntil(
                                  const MainMenuRoute(),
                                  predicate: (_) => false,
                                );
                              },
                              child: const Text('Back to menu')),
                        ]),
                  )),
            )
            ..show();
        }
      }
    });
  }
}
