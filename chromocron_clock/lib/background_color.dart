import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

import 'color_globals.dart';

/// Draws the background color animation.
class BackgroundColor extends StatefulWidget {
  /// States whether the clock is currently in light or dark mode.
  final bool lightMode;

  /// The current time, used to determine the colors and the
  /// transition value.
  final DateTime time;

  const BackgroundColor({Key key, this.lightMode, this.time}) : super(key: key);

  @override
  _BackgroundColor createState() => _BackgroundColor();
}

class _BackgroundColor extends State<BackgroundColor> {
  @override
  Widget build(BuildContext context) {
    int hour = widget.time.hour % 12;
    int minute = widget.time.minute;
    int seconds = widget.time.second;

    /// Calculate the value of our transition based on the current time.
    double transition = (minute / 60) + (seconds / 3600);

    Color currentHourColor = Globals.colorList[hour];
    Color nextHourColor = Globals.colorList[hour + 1 % 12];

    /// Light mode: brighten color,
    /// Dark mode: darken color
    if (widget.lightMode) {
      currentHourColor = TinyColor(currentHourColor)
          .brighten(Globals.percentageBackgroundLightMode)
          .color;
      nextHourColor = TinyColor(nextHourColor)
          .brighten(Globals.percentageBackgroundLightMode)
          .color;
    } else {
      currentHourColor = TinyColor(currentHourColor)
          .darken(Globals.percentageBackgroundDarkMode)
          .color;
      nextHourColor = TinyColor(nextHourColor)
          .darken(Globals.percentageBackgroundDarkMode)
          .color;
    }

    Color backgroundColor = HSVColor.lerp(HSVColor.fromColor(currentHourColor),
            HSVColor.fromColor(nextHourColor), transition)
        .toColor();

    return Scaffold(
      body: Container(
        color: backgroundColor,
      ),
    );
  }
}
