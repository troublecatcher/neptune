import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neptune/main.dart';
import 'package:neptune/router/router.dart';

import '../bloc/audio.dart';
import 'icon_button.dart';

class SoundAndSettings extends StatelessWidget {
  final AudioBloc audioBloc;

  const SoundAndSettings({super.key, required this.audioBloc});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Row(
        children: [
          if (musicIncluded)
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
            ),
          )
        ],
      ),
    );
  }
}
