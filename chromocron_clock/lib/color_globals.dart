import 'package:flutter/material.dart';

/// contains global color data

class Globals {
  /// Colors of the color wheel
  static Color violetBlue = Color(0xff3E08CE);
  static Color blue = Color(0xff0000ED);
  static Color blueGreen = Color(0xff006F6C);
  static Color green = Color(0xff00CB00);
  static Color greenYellow = Color(0xff68D505);
  static Color yellow = Color(0xffE5E00C);
  static Color yellowOrange = Color(0xffF1B714);
  static Color orange = Color(0xffFB951B);
  static Color orangeRed = Color(0xffED5B19);
  static Color red = Color(0xffDC1616);
  static Color redViolet = Color(0xffA2126C);
  static Color violet = Color(0xff720EB4);

  static List colorList = [
    violetBlue,
    blue,
    blueGreen,
    green,
    greenYellow,
    yellow,
    yellowOrange,
    orange,
    orangeRed,
    red,
    redViolet,
    violet
  ];

  /// brighten / darken background and overlay colors
  static int percentageBackgroundLightMode = 30;
  static int percentageBackgroundDarkMode = 15;

  static int percentageBlackStroke = 5;

  static double transparencyOverlayLightMode = 0.85;
  static double transparencyOverlayDarkMode = 1;

  /// relative size of circles
  static double sizeReductionColorWheel = 0.8;
  static double sizeReductionOverlay = 0.75;
}
