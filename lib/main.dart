import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Pizza_Recognition/bloc_debugger.dart';
import 'package:Pizza_Recognition/view/home_screen.dart';
import 'package:Pizza_Recognition/view/uninitialized_screen.dart';
import 'package:Pizza_Recognition/pizza_controller/pizza_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(
    BlocProvider<PizzaBloc>(
      create: (context) => PizzaBloc()..add(AppStarted()),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza-Recognition',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocBuilder<PizzaBloc, PizzaState>(
        buildWhen: (previousState, currentState) {
          return previousState.runtimeType != currentState.runtimeType;
        },
        builder: (context, state) {
          if (state is ModelLoadSuccess) {
            return HomeScreen();
          }
          return UninitializedScreen(isLoading: state is Uninitialized);
        },
      ),
    );
  }
}
