part of 'pizza_bloc.dart';

abstract class PizzaState extends Equatable {
  const PizzaState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends PizzaState {}

class ModelLoadFailure extends PizzaState {}

@immutable
class ModelLoadSuccess extends PizzaState {
  final String imagePath;
  final bool inPredict;
  final bool hasError;
  final double confidentRate;

  const ModelLoadSuccess({
    @required this.imagePath,
    @required this.inPredict,
    @required this.hasError,
    @required this.confidentRate,
  });

  factory ModelLoadSuccess.empty() {
    return ModelLoadSuccess(
      imagePath: null,
      inPredict: false,
      hasError: null,
      confidentRate: null,
    );
  }

  ModelLoadSuccess updateImagePath({@required String newImagePath}) {
    return _copyWith(
      imagePath: newImagePath,
    );
  }

  ModelLoadSuccess predictStarts() {
    return _copyWith(
      inPredict: true,
    );
  }

  ModelLoadSuccess predictSuccess({@required double confidentRate}) {
    return _copyWith(
      inPredict: false,
      hasError: false,
      confidentRate: confidentRate,
    );
  }

  ModelLoadSuccess predictFailure() {
    return _copyWith(
      inPredict: false,
      hasError: true,
    );
  }

  ModelLoadSuccess _copyWith({
    String imagePath,
    bool inPredict,
    bool hasError,
    double confidentRate,
  }) {
    return ModelLoadSuccess(
      imagePath: imagePath ?? this.imagePath,
      inPredict: inPredict ?? this.inPredict,
      hasError: hasError ?? this.hasError,
      confidentRate: confidentRate ?? this.confidentRate,
    );
  }

  @override
  List<Object> get props => [imagePath, inPredict, hasError, confidentRate];

  @override
  String toString() {
    return '''ModelLoadSuccess {
      'imagePath': $imagePath,
      'inPredict': $inPredict,
      'hasError': $hasError,
      'confidentRate': $confidentRate
    }''';
  }
}
