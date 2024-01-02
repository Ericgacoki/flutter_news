import 'package:flutter/material.dart';

// Function to create a MaterialColor from a single color
MaterialColor createMaterialColor(Color color) {
  List<int> strengths = <int>[50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  Map<int, Color> swatch = <int, Color>{};
  final int red = color.red, green = color.green, blue = color.blue;

  for (int strength in strengths) {
    swatch[strength] = Color.fromRGBO(red, green, blue, 1.0);
  }

  return MaterialColor(color.value, swatch);
}
