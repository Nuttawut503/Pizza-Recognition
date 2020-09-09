import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audio_cache.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

part 'pizza_event.dart';
part 'pizza_state.dart';

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  final AudioCache player;

  PizzaBloc(): 
    player = AudioCache(prefix: 'assets/sounds/'),
    super(Uninitialized.loading());

  Stream<PizzaState> mapEventToState(PizzaEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is UploadImageButtonPressed) {
      yield* _mapUploadImageButtonPressedToState();
    } else if (event is PredictImageRequested) {
      yield* _mapPredictImageRequestedToState();
    } else if (event is ResetButtonPressed) {
      yield* _mapResetButtonPressedToState();
    }
  }

  Stream<PizzaState> _mapAppStartedToState() async* {
    try {
      final startTime = DateTime.now().millisecondsSinceEpoch;
      await Tflite.loadModel(
        model: 'assets/tflite/model_unquant.tflite',
        labels: 'assets/tflite/labels.txt'
      );
      await player.load('ding.mp3');
      await Future.delayed(Duration(milliseconds: max(0, 1000 - DateTime.now().millisecondsSinceEpoch + startTime)));
      yield Initialized.defaultState();
    } catch (_) {
      yield Uninitialized.failure();
    }
  }

  Stream<PizzaState> _mapUploadImageButtonPressedToState() async* {
    PickedFile imageFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (imageFile != null) {
      yield (state as Initialized).updateImagePath(newImagePath: imageFile.path);
      player.play('ding.mp3');
      await Future.delayed(Duration(milliseconds: 2000));
      add(PredictImageRequested());
    }
  }

  Stream<PizzaState> _mapPredictImageRequestedToState() async* {
    yield (state as Initialized).predictStarts();
    final startTime = DateTime.now().millisecondsSinceEpoch;
    final output = await Tflite.runModelOnImage(
      path: (state as Initialized).imagePath,
    );
    await Future.delayed(Duration(milliseconds: max(0, 2500 - DateTime.now().millisecondsSinceEpoch + startTime)));
    print(output);
    yield (state as Initialized).updatePredictResult(confidentRate: output[0]['confidence'] as double);
  }

  Stream<PizzaState> _mapResetButtonPressedToState() async* {
    yield Initialized.defaultState();
  }

  @override
  Future<void> close() async {
    player.clearCache();
    await Tflite.close();
    super.close();
  }
}
