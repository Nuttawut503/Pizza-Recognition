import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'pizza_event.dart';
part 'pizza_state.dart';

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  PizzaBloc(): super(Uninitialized());

  Stream<PizzaState> mapEventToState(PizzaEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is NewImageButtonPressed) {
      yield* _mapNewImageButtonPressedToState();
    } else if (event is PredictImageRequested) {
      yield* _mapPredictImageRequestedToState();
    } else if (event is ImageCleared) {
      yield* _mapImageClearedToState();
    }
  }

  Stream<PizzaState> _mapAppStartedToState() async* {
    try {
      // Prepare the model here
      yield ModelLoadSuccess.empty();
    } catch (_) {
      yield ModelLoadFailure();
    }
  }

  Stream<PizzaState> _mapNewImageButtonPressedToState() async* {
    // Use image picker for gallery here and update the image path
    yield (state as ModelLoadSuccess).updateImagePath(newImagePath: 'new path');
    add(PredictImageRequested());
  }

  Stream<PizzaState> _mapPredictImageRequestedToState() async* {
    try {
      yield (state as ModelLoadSuccess).predictStarts();
      // Do predict here
      yield (state as ModelLoadSuccess).predictSuccess(confidentRate: 1.0);
    } catch (_) {
      yield (state as ModelLoadSuccess).predictFailure();
    }
  }

  Stream<PizzaState> _mapImageClearedToState() async* {
    yield ModelLoadSuccess.empty();
  }
}
