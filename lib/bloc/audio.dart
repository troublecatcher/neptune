import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

enum AudioEvent { play, pause }

class AudioState {
  final bool isPlaying;
  final String iconAsset;

  AudioState({required this.isPlaying, required this.iconAsset});
}

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioPlayer player;

  AudioBloc({required this.player})
      : super(AudioState(
            isPlaying: true, iconAsset: 'assets/icons/sound-on.svg')) {
    on<AudioEvent>((event, emit) {
      if (event == AudioEvent.play) {
        if (!player.playing) {
          player.play();
        }
        emit(AudioState(
            isPlaying: true, iconAsset: 'assets/icons/sound-on.svg'));
      } else if (event == AudioEvent.pause) {
        if (player.playing) {
          player.pause();
        }
        emit(AudioState(
            isPlaying: false, iconAsset: 'assets/icons/sound-off.svg'));
      }
    });
  }
}
