import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    if (currentState.imagePath == null) {
      return 'Hello World !!';
    } else if (currentState.isPredicting == true) {
      return 'Please wait, the program is working...';
    } else if (currentState.confidentRate == null) {
      return 'Your image has been uploaded';
    } else if (currentState.confidentRate > 80) {
      return 'You uploaded a picture of pizza\n(confidence: ${currentState.confidentRate} %)';
    }
    return 'You didn\'t upload a picture of pizza\n(confidence: ${currentState.confidentRate} %)';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PizzaBloc, PizzaState>(
      builder: (context, state) {
        if (state is Initialized) {
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 16.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(9.0)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(getDescriptionTextByState(state), style: GoogleFonts.openSans(fontSize: 14.0), textAlign: TextAlign.center),
                  if (state.confidentRate != null)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 12.0),
                        ClipOval(
                          child: Material(
                            color: Colors.greenAccent,
                            child: InkWell(
                              splashColor: Colors.green,
                              child: SizedBox(width: 36, height: 36, child: Icon(FontAwesomeIcons.redo, size: 15.0,)),
                              onTap: () => BlocProvider.of<PizzaBloc>(context).add(ResetButtonPressed()),
                            ),
                          ),
                        ),
                      ],
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
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height > 0.5625
          ? MediaQuery.of(context).size.height * 0.1
          : MediaQuery.of(context).size.height / 2.0 - (MediaQuery.of(context).size.width / 9.0 * 16 * 0.4)
        ),
        width: (MediaQuery.of(context).size.width / MediaQuery.of(context).size.height > 0.5625)? MediaQuery.of(context).size.height * 0.2: MediaQuery.of(context).size.width * 0.2,
        height: (MediaQuery.of(context).size.width / MediaQuery.of(context).size.height > 0.5625)? MediaQuery.of(context).size.height * 0.2: MediaQuery.of(context).size.width * 0.2,
        decoration: BoxDecoration(
          color: Colors.black,
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
