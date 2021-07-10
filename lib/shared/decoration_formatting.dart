import 'package:flutter/material.dart';

final inputDisabaledWithEnabledBorderDecoration = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  borderSide: BorderSide(color: Colors.blue[800], width: 1),
);

final inputFocusedBorderDecoration = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  borderSide: BorderSide(color: Colors.blue[900], width: 1),
);

final inputErrorBorderDecoration = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  borderSide: BorderSide(color: Colors.redAccent, width: 2),
);
