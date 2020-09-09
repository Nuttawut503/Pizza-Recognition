part of 'pizza_bloc.dart';

abstract class PizzaState extends Equatable {
  const PizzaState();

  @override
  List<Object> get props => [];
}

@immutable
class Uninitialized extends PizzaState {
  final bool isLoading;

  Uninitialized({
    @required this.isLoading,
  });

  factory Uninitialized.loading() {
    return Uninitialized(
      isLoading: true,
    );
  }

  factory Uninitialized.failure() {
    return Uninitialized(
      isLoading: false,
    );
  }

  @override
  List<Object> get props => [isLoading];

  @override
  String toString() {
    return '''Uninitialized {
      'isLoading': $isLoading,
    }''';
  }
}

class ModelLoadFailure extends PizzaState {}

@immutable
class Initialized extends PizzaState {
  final String imagePath;
  final bool isPredicting;
  final double confidentRate;

  Initialized({
    @required this.imagePath,
    @required this.isPredicting,
    @required this.confidentRate,
  });

  factory Initialized.defaultState() {
    return Initialized(
      imagePath: null,
      isPredicting: false,
      confidentRate: null,
    );
  }

  Initialized updateImagePath({@required String newImagePath}) {
    return _copyWith(
      imagePath: newImagePath,
    );
  }

  Initialized predictStarts() {
    return _copyWith(
      isPredicting: true,
    );
  }

  Initialized updatePredictResult({@required double confidentRate}) {
    return _copyWith(
      isPredicting: false,
      confidentRate: num.parse(confidentRate.toStringAsFixed(4)) * 100,
    );
  }

  Initialized _copyWith({
    String imagePath,
    bool isPredicting,
    double confidentRate,
  }) {
    return Initialized(
      imagePath: imagePath ?? this.imagePath,
      isPredicting: isPredicting ?? this.isPredicting,
      confidentRate: confidentRate ?? this.confidentRate,
    );
  }

  @override
  List<Object> get props => [imagePath, isPredicting, confidentRate];

  @override
  String toString() {
    return '''Initialized {
      'imagePath': $imagePath,
      'isPredicting': $isPredicting,
      'confidentRate': $confidentRate
    }''';
  }
}
