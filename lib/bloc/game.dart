import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/difficulty.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final Difficulty? difficulty;
  var level = 1;

  GameBloc({required this.difficulty, required this.level})
      : super(GameCountdownState()) {
    on<GameRunEvent>(_onStartGame);
    on<GamePauseEvent>(_onPaused);
    on<GameNextLevelEvent>(_nextLevel);
    on<GameRestartEvent>(_onRestart);
    on<GameResetEvent>(_onReset);
    on<GameCountdownEvent>(_onCountdown);
  }

  void _onRestart(GameRestartEvent event, Emitter<GameState> emit) {
    level = 1;
    emit(GameRestartedState());
  }

  void _onReset(GameResetEvent event, Emitter<GameState> emit) {
    emit(GameRunningState());
  }

  void _onCountdown(GameCountdownEvent event, Emitter<GameState> emit) {
    emit(GameCountdownState());
  }

  void _onStartGame(GameRunEvent event, Emitter<GameState> emit) {
    emit(GameRunningState());
  }

  void _onPaused(GamePauseEvent event, Emitter<GameState> emit) {
    emit(GamePausedState());
  }

  void _nextLevel(GameNextLevelEvent event, Emitter<GameState> emit) {
    if (level < 5) {
      level++;
      emit(GameResetState());
    } else {
      emit(GameWonState());
    }
  }
}

abstract class GameEvent {}

class GameCountdownEvent extends GameEvent {
  GameCountdownEvent();
}

class GameRunEvent extends GameEvent {
  GameRunEvent();
}

class GameResetEvent extends GameEvent {
  GameResetEvent();
}

class GamePauseEvent extends GameEvent {
  GamePauseEvent();
}

class GameNextLevelEvent extends GameEvent {
  GameNextLevelEvent();
}

class GameRestartEvent extends GameEvent {
  GameRestartEvent();
}

abstract class GameState {}

class GameCountdownState extends GameState {
  GameCountdownState();
}

class GameRunningState extends GameState {
  GameRunningState();
}

class GamePausedState extends GameState {
  GamePausedState();
}

class GameLostState extends GameState {
  GameLostState();
}

class GameWonState extends GameState {
  GameWonState();
}

class GameRestartedState extends GameState {
  GameRestartedState();
}

class GameResetState extends GameState {
  GameResetState();
}
