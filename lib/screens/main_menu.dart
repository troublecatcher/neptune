import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:neptune/router/router.dart';
import 'package:neptune/widgets/custom_text_button.dart';
import 'package:neptune/widgets/icon_button.dart';
import 'package:neptune/widgets/sound_and_settings.dart';
import 'package:neptune/widgets/svg_title.dart';
import 'package:neptune/widgets/widget_padding.dart';

import '../bloc/audio.dart';
import '../main.dart';
import '../widgets/custom_texticon_button.dart';

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
            image: AssetImage('assets/bg/main.png'),
            fit: BoxFit.cover,
          ),
        ),
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
                  const SvgTitle(path: 'assets/titles/main.svg'),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomTextIconButton(
                        callback: (_) {
                          context.router.push(const DifficultyRoute());
                        },
                        children: [
                          SvgPicture.asset('assets/icons/play.svg'),
                          SizedBox(width: 5.sp),
                          Text(
                            'Play',
                            style: Theme.of(context).textTheme.displayLarge,
                          )
                        ]),
                  ),
                  SoundAndSettings(audioBloc: audioBloc),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CustomTextIconButton(
                        callback: (_) {
                          FlutterExitApp.exitApp(iosForceExit: true);
                        },
                        children: [
                          SvgPicture.asset('assets/icons/exit.svg'),
                          SizedBox(width: 5.sp),
                          Text('Exit',
                              style: Theme.of(context).textTheme.displayLarge),
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
