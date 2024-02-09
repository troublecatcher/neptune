import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neptune/main.dart';
import 'package:neptune/widgets/custom_text_button.dart';
import 'package:neptune/widgets/difficulty_item.dart';
import 'package:neptune/widgets/svg_title.dart';
import 'package:neptune/widgets/widget_padding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/audio.dart';
import '../router/router.dart';
import '../widgets/icon_button.dart';

enum Difficulty {
  easy(Duration(minutes: 5), 'Easy', 'assets/difficulty/1.png',
      'assets/bg/easy.png'),
  normal(Duration(minutes: 2), 'Normal', 'assets/difficulty/2.png',
      'assets/bg/normal.png'),
  hard(Duration(minutes: 1, seconds: 30), 'Hard', 'assets/difficulty/3.png',
      'assets/bg/hard.png');

  final Duration gameTime;
  final String name;
  final String imagePath;
  final String pauseImagePath;

  const Difficulty(
      this.gameTime, this.name, this.imagePath, this.pauseImagePath);
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
                image: AssetImage('assets/bg/lod.png'), fit: BoxFit.fill)),
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
                  CustomIconButton(
                    path: 'assets/icons/back.svg',
                    callback: context.router.pop,
                  ),
                  const SvgTitle(path: 'assets/titles/lod.svg'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DifficultyItem(
                        imagePath: 'assets/difficulty/1.png',
                        svg: SvgPicture.asset('assets/difficulty/easy.svg'),
                        callback: (_) {
                          if (locator<SharedPreferences>().getBool('diff1')!) {
                            context.router.replaceAll(
                                [LevelRoute(difficulty: Difficulty.easy)]);
                          }
                        },
                        isUnlocked:
                            locator<SharedPreferences>().getBool('diff1')!,
                      ),
                      const SizedBox(width: 20),
                      DifficultyItem(
                        imagePath: 'assets/difficulty/2.png',
                        svg: SvgPicture.asset('assets/difficulty/normal.svg'),
                        callback: (_) {
                          if (locator<SharedPreferences>().getBool('diff2')!) {
                            context.router.replaceAll(
                                [LevelRoute(difficulty: Difficulty.normal)]);
                          }
                        },
                        isUnlocked:
                            locator<SharedPreferences>().getBool('diff2')!,
                      ),
                      const SizedBox(width: 20),
                      DifficultyItem(
                        imagePath: 'assets/difficulty/3.png',
                        svg: SvgPicture.asset('assets/difficulty/hard.svg'),
                        callback: (_) {
                          if (locator<SharedPreferences>().getBool('diff3')!) {
                            context.router.replaceAll(
                                [LevelRoute(difficulty: Difficulty.hard)]);
                          }
                        },
                        isUnlocked:
                            locator<SharedPreferences>().getBool('diff3')!,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
