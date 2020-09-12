import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UninitializedScreen extends StatefulWidget {
  final bool _isLoading;

  UninitializedScreen({Key key, @required bool isLoading})
    : _isLoading = isLoading,
      super(key: key);

  @override
  _UninitializedScreenState createState() => _UninitializedScreenState();
}

class _UninitializedScreenState extends State<UninitializedScreen> with SingleTickerProviderStateMixin {
  bool get _isLoading => widget._isLoading;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1500))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 235, 193),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _isLoading
                ? 'Loading an AI model...'
                : 'Something went wrong...\nやべぇ',
                style: GoogleFonts.openSans(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 36.0),
              AnimatedBuilder(
                animation: _controller,
                builder: (_, child) {
                  return Transform.rotate(
                    angle: _isLoading? _controller.value * 2 * pi: 0,
                    child: child,
                  );
                },
                child: Container(
                  width: 280.0,
                  height: 280.0,
                  child: Image.asset(
                    _isLoading
                    ? 'assets/images/model_load_process.png'
                    : 'assets/images/model_load_failure.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
