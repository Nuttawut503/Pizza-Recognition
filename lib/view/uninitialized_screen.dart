import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UninitializedScreen extends StatelessWidget {
  final bool _isLoading;

  UninitializedScreen({Key key, @required bool isLoading})
    : _isLoading = isLoading,
      super(key: key);

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
              SizedBox(height: 19.0),
              Container(
                width: 300.0,
                height: 300.0,
                child: Image.asset(
                  _isLoading
                  ? 'assets/images/model_load_process.png'
                  : 'assets/images/model_load_failure.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
