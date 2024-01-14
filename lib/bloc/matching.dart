import 'package:flutter_bloc/flutter_bloc.dart';

class MatchingBloc extends Bloc<MatchingEvent, MatchingState> {
  MatchingBloc() : super(InitialState()) {
    on<InitialMatchingEvent>(_initialize);
    on<ImageSelected>(_imageSelected);
  }
  void _initialize(MatchingEvent event, Emitter<MatchingState> emit) {
    emit(InitialState());
  }

  void _imageSelected(ImageSelected event, Emitter<MatchingState> emit) {
    if (state is ImageSelectedState) {
      final currentState = state as ImageSelectedState;
      if (currentState.image == event.image &&
          currentState.index != event.index) {
        emit(ImageMatchState(currentState.index, event.index));
      } else {
        emit(ImageMismatchState(currentState.index, event.index));
      }
    } else {
      emit(ImageSelectedState(event.image, event.index));
    }
  }
}

abstract class MatchingEvent {}

class InitialMatchingEvent extends MatchingEvent {}

class ImageSelected extends MatchingEvent {
  final String image;
  final int index;

  ImageSelected(this.image, this.index);
}

class ImageMatch extends MatchingEvent {}

abstract class MatchingState {}

class InitialState extends MatchingState {}

class ImageSelectedState extends MatchingState {
  final String image;
  final int index;

  ImageSelectedState(this.image, this.index);
}

class ImageMatchState extends MatchingState {
  final int image1;
  final int image2;

  ImageMatchState(this.image1, this.image2);
}

class ImageMismatchState extends MatchingState {
  final int image1;
  final int image2;

  ImageMismatchState(this.image1, this.image2);
}
