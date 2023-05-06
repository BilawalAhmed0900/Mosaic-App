import 'package:flutter/material.dart';
import 'package:mosaic_app/Scaffolds/splash_screen_scaffold.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.light,
      fontFamily: "Inter",
    ),
    home: const SplashScreenPageScaffold(),
  ));
}
