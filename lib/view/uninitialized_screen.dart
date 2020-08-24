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
      body: SafeArea(
        child: _isLoading? OnLoad(): OnFailure(),
      ),
    );
  }
}

class OnLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Loading', style: GoogleFonts.openSans()),
    );
  }
}

class OnFailure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Failed', style: GoogleFonts.openSans()),
    );
  }
}
