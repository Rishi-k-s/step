import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff040812),
      child: Center(
        child: SpinKitFadingCircle(
          color: Colors.white70,
          size: 55.0,
        ),
      ),
    );
  }
}
