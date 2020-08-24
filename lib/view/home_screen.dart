import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Pizza_Recognition/pizza_controller/pizza_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(),
            Positioned(
              bottom: 0,
              left: 0,
              child: FloatingButtons(),
            ),
            PictureAnalysis(),
          ],
        ),
      ),
    );
  }
}

class FloatingButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RaisedButton(
            onPressed: () => BlocProvider.of<PizzaBloc>(context).add(ImageCleared()),
            child: Text('RESET', style: GoogleFonts.openSans()),
          ),
          RaisedButton(
            onPressed: () => BlocProvider.of<PizzaBloc>(context).add(NewImageButtonPressed()),
            child: Text('UPLOAD', style: GoogleFonts.openSans()),
          ),
        ],
      ),
    );
  }
}

class PictureAnalysis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PizzaBloc, PizzaState>(
      builder: (context, state) {
        try {
          if (state is ModelLoadSuccess && state.imagePath != null) {
            return Image.file(File(state.imagePath));
          }
          throw null;
        } catch (_) {
          return Container();
        }
      },
    );
  }
}