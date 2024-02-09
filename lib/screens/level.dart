import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neptune/bloc/matching.dart';
import 'package:neptune/main.dart';
import 'package:neptune/router/router.dart';
import 'package:neptune/screens/card.dart';
import 'package:neptune/widgets/front.dart';
import 'package:neptune/widgets/icon_button.dart';
import 'package:neptune/widgets/widget_padding.dart';
import 'package:pro_animated_blur/pro_animated_blur.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../bloc/game.dart';
import '../theme/default.dart';
import '../timer/ticker.dart';
import '../timer/timer_bloc.dart';
import 'difficulty.dart';
import 'loss_dialog.dart';
import 'victory_dialog.dart';

List<bool> disclosureStatus = [];
late List<String> pictures;
var selectedPictures;
var selectedIndexes;
bool shimmering = false;

@RoutePage()
class LevelScreen extends StatelessWidget {
  final Difficulty difficulty;

  const LevelScreen({Key? key, required this.difficulty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameBloc>(
          create: (context) => GameBloc(difficulty: difficulty, level: 5),
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
        victoryDialog(context, difficulty);
        if (difficulty == Difficulty.easy) {
          locator<SharedPreferences>().setBool('diff2', true);
        }
        if (difficulty == Difficulty.normal) {
          locator<SharedPreferences>().setBool('diff3', true);
        }
      }
      if (state is GameRestartedState) {
        BlocProvider.of<MatchingBloc>(context).add(InitialMatchingEvent());
        await context.router.pushAndPopUntil(
          LevelRoute(difficulty: difficulty),
          predicate: (_) => false,
        );
      }
      if (state is GameResetState) {
        shimmering = true;
        Future.delayed(const Duration(seconds: 2), () {
          shimmering = false;
          BlocProvider.of<MatchingBloc>(context).add(InitialMatchingEvent());
          initialize(context);
        });
      }
    });
    BlocProvider.of<MatchingBloc>(context).stream.listen((state) async {
      if (state is ImageMatchState &&
          disclosureStatus.where((status) => !status).length == 1) {
        disclosureStatus[disclosureStatus.indexOf(false)] = true;
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
            child:
                BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
              return Stack(
                children: [
                  BlocBuilder<TimerBloc, TimerState>(
                    builder: (context, state) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 10, right: 10, left: 10),
                        child: WidgetPadding(
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: textBeigeColor,
                                          border: Border.all(
                                              width: 2, color: textBrownColor),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: const BoxDecoration(
                                                color: textBrownColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14))),
                                            child: Text(
                                              'Level',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
                                                      color: textBeigeColor),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                              '${BlocProvider.of<GameBloc>(context).level} / 5',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium),
                                          const SizedBox(width: 10),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: textBeigeColor,
                                          border: Border.all(
                                              width: 2, color: textBrownColor),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16))),
                                      child: Text(difficulty.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: textBeigeColor,
                                    border: Border.all(
                                        width: 2, color: textBrownColor),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                          color: textBrownColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(14))),
                                      child: SvgPicture.asset(
                                          'assets/icons/timer.svg'),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                        '${(state.duration / 60).floor()}:${state.duration.remainder(60).toString().padLeft(2, '0')}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium),
                                    const SizedBox(width: 10),
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
                                        if (BlocProvider.of<GameBloc>(context)
                                            .state is! GameCountdownState) {
                                          BlocProvider.of<TimerBloc>(context)
                                              .add(const TimerPaused());
                                          context.router.navigate(PauseRoute(
                                              timerBloc:
                                                  context.read<TimerBloc>(),
                                              gameBloc:
                                                  context.read<GameBloc>(),
                                              difficulty: difficulty));
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                          Shimmer(
                            duration: const Duration(seconds: 2),
                            interval: const Duration(days: 10),
                            color: Colors.white,
                            enabled: shimmering,
                            direction: const ShimmerDirection.fromLTRB(),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 4),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 8,
                                        mainAxisSpacing: 4,
                                        crossAxisSpacing: 4),
                                itemCount: pictures.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (BlocProvider.of<GameBloc>(context)
                                              .state is! GameCountdownState &&
                                          !disclosureStatus[index] &&
                                          context.read<MatchingBloc>().state
                                              is! ImageMismatchState) {
                                        BlocProvider.of<MatchingBloc>(context)
                                            .add(ImageSelected(
                                                pictures[index], index));
                                      }
                                    },
                                    child: BlocBuilder<MatchingBloc,
                                        MatchingState>(
                                      builder: (context, state) {
                                        if (state is ImageMatchState) {
                                          disclosureStatus[state.image1] = true;
                                          disclosureStatus[state.image2] = true;
                                        }
                                        if (state is ImageSelectedState &&
                                            state.index == index) {
                                          disclosureStatus[index] = true;
                                        }
                                        return CardWidget(
                                            frontImage: const FrontImage(),
                                            backImage: Container(
                                              margin: const EdgeInsets.all(4),
                                              decoration: const BoxDecoration(
                                                  color: textBeigeColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(16))),
                                              child: Image.asset(
                                                pictures[index],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            isClosed: !disclosureStatus[index]);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  ProAnimatedBlur(
                    blur: BlocProvider.of<GameBloc>(context).state
                            is GameCountdownState
                        ? 20
                        : 0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear,
                    child: Center(
                      child: Text(
                        BlocProvider.of<GameBloc>(context).state
                                is GameCountdownState
                            ? state.duration.toString()
                            : "",
                        style: TextStyle(
                            fontSize:
                                100 * MediaQuery.of(context).devicePixelRatio,
                            fontFamily: 'Roboto',
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
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
    disclosureStatus = List.filled(24, false);
    BlocProvider.of<TimerBloc>(context).add(TimerReset());
    BlocProvider.of<TimerBloc>(context).add(const TimerStarted(3));
    var allPictures =
        List.generate(12, (index) => 'assets/cards/image${index + 1}.png');

    for (var i = 0; i < 12; i++) {
      pictures.add(allPictures[i]);
      pictures.add(allPictures[i]);
    }
    pictures.shuffle();

    BlocProvider.of<TimerBloc>(context).stream.listen((state) {
      if (state is TimerRunComplete) {
        if (BlocProvider.of<GameBloc>(context).state is GameCountdownState) {
          BlocProvider.of<GameBloc>(context).add(GameRunEvent());
          BlocProvider.of<TimerBloc>(context)
              .add(TimerStarted(difficulty.gameTime.inSeconds));
        }
        if (BlocProvider.of<GameBloc>(context).state is GameRunningState) {
          lossDialog(context, difficulty);
        }
      }
    });
  }
}
