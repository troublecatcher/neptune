import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neptune/screens/difficulty.dart';
import 'package:neptune/theme/default.dart';
import 'package:neptune/widgets/custom_text_button.dart';
import 'package:neptune/widgets/front.dart';

import '../bloc/game.dart';
import '../bloc/matching.dart';
import '../router/router.dart';

lossDialog(BuildContext context, Difficulty difficulty) {
  YYDialog().build(context)
    ..width = MediaQuery.of(context).size.width * 0.6
    ..height = MediaQuery.of(context).size.height * 0.8
    ..borderRadius = 16
    ..backgroundColor = textBeigeColor
    ..barrierDismissible = false
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
        child: child,
      );
    }
    ..widget(
      Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
            border: Border.all(width: 4, color: textBrownColor),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset('assets/titles/lose.svg'),
                    Container(
                        width: MediaQuery.of(context).size.width / 10,
                        height: MediaQuery.of(context).size.width / 10,
                        child: FrontImage()),
                    Text(
                      'You’ve ran out of time.',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextButton(
                            callback: (_) {
                              context.router.pushAndPopUntil(
                                const MainMenuRoute(),
                                predicate: (_) => false,
                              );
                            },
                            children: [
                              Text(
                                'Back to menu',
                                style: Theme.of(context).textTheme.titleLarge,
                              )
                            ]),
                        SizedBox(height: 10.h),
                        CustomTextButton(
                          children: [
                            Text(
                              'Try again',
                              style: Theme.of(context).textTheme.titleLarge,
                            )
                          ],
                          callback: (_) {
                            BlocProvider.of<GameBloc>(context)
                                .add(GameRestartEvent());
                            BlocProvider.of<MatchingBloc>(context)
                                .add(InitialMatchingEvent());
                          },
                        ),
                      ],
                    ),
                  ]),
            )),
      ),
    )
    ..show();
}
