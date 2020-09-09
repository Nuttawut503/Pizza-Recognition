import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Pizza_Recognition/pizza_controller/pizza_bloc.dart';

class HomeScreen extends StatelessWidget {
  String getBackgroundImagePathByState(Initialized currentState) {
    if (currentState.imagePath == null) {
      return 'default.png';
    } else if (currentState.isPredicting == true) {
      return 'predict_running.png';
    } else if (currentState.confidentRate == null) {
      return 'predict_prepare.png';
    } else if (currentState.confidentRate > 80) {
      return 'got_pizza.png';
    }
    return 'got_not_pizza.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 235, 193),
      body: SafeArea(
        child: BlocBuilder<PizzaBloc, PizzaState>(
          builder: (context, state) {
            if (state is Initialized) {
              return Stack(
                children: [
                  Container(),
                  Align(
                    child: Image.asset(
                      'assets/images/${getBackgroundImagePathByState(state)}',
                      fit: BoxFit.contain,
                    ),
                  ),
                  FloatingText(),
                  if (state.imagePath == null)
                    FloatingButton(),
                  if (state.confidentRate != null)
                    FloatingImage(imagePath: state.imagePath),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class FloatingText extends StatelessWidget {
  String getDescriptionTextByState(Initialized currentState) {
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PizzaBloc, PizzaState>(
      builder: (context, state) {
        if (state is Initialized) {
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 12.0),
              decoration: BoxDecoration(

              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(getDescriptionTextByState(state), style: GoogleFonts.openSans()),
                  if (state.confidentRate != null)
                    RaisedButton(
                      onPressed: () => BlocProvider.of<PizzaBloc>(context).add(ResetButtonPressed())
                    ),
                ],
              )
            ),
          );
        }
        return Container();
      }
    );
  }
}

class FloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.0),
        child: RaisedButton(
          color: Colors.greenAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.black, width: 1.9)
          ),
          onPressed: () => BlocProvider.of<PizzaBloc>(context).add(UploadImageButtonPressed()),
          child: Text('Upload a picture of pizza', style: GoogleFonts.openSans()),
        ),
      ),
    );
  }
}

class FloatingImage extends StatelessWidget {
  final String _imagePath;

  FloatingImage({Key key, @required String imagePath})
    : _imagePath = imagePath,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 0.0),
        width: 0.0,
        height: 0.0,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(6.0)
        ),
        child: Image.file(
          File(_imagePath),
        ),
      ),
    );
  }
}
