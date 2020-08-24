part of 'pizza_bloc.dart';

abstract class PizzaEvent extends Equatable {
  const PizzaEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends PizzaEvent {}

class NewImageButtonPressed extends PizzaEvent {}

class PredictImageRequested extends PizzaEvent {}

class ImageCleared extends PizzaEvent {}
