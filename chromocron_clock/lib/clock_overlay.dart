import 'package:flutter/material.dart';
import 'package:angles/angles.dart';
import 'dart:math' as Math;

import 'color_globals.dart';

/// Draws the overlay that is used to show the time.
class ClockOverlay extends StatefulWidget {
  /// States whether the clock is currently in light or dark mode.
  final bool lightMode;

  /// The current time, used to determine the rotation of the overlay.
  final DateTime time;

  const ClockOverlay({Key key, this.lightMode, this.time}) : super(key: key);

  @override
  _ClockOverlay createState() => _ClockOverlay();
}

class _ClockOverlay extends State<ClockOverlay> {
  static int hour;
  static int minute;
  static int seconds;

  @override
  Widget build(BuildContext context) {
    hour = widget.time.hour;
    minute = widget.time.minute;
    seconds = widget.time.second;

    return Transform.rotate(
      angle: Angle.fromDegrees(timeToRotation()).radians,
      child: CustomPaint(painter: OverlayPainter(widget.lightMode)),
    );
  }

  /// Calculates the current rotation based on segments with 30 degree.
  double timeToRotation() {
    return 30 * ((hour % 12) + (minute / 60) + (seconds / 3600));
  }
}

/// Draws the 'pacman' overlay.
class OverlayPainter extends CustomPainter {
  bool lightMode;

  OverlayPainter(bool mode) {
    this.lightMode = mode;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius =
        (Math.min(size.width, size.height) / 2) * Globals.sizeReductionOverlay;
    final center = Offset(size.width / 2, size.height / 2);

    Paint paint = Paint();

    /// Use white in Light mode and black in Dark mode.
    lightMode
        ? paint.color =
            Color.fromRGBO(255, 255, 255, Globals.transparencyOverlayLightMode)
        : paint.color =
            Color.fromRGBO(0, 0, 0, Globals.transparencyOverlayDarkMode);

    Path path = Path();

    /// Draws the first arc from the right side of
    /// the top segment to the bottom of the circle.
    Angle startDegree = Angle.fromDegrees(285);
    Angle endDegree = Angle.fromDegrees(105);

    path = Path();
    path.moveTo(center.dx, center.dy);
    path.lineTo((center.dx + (radius * startDegree.cos)),
        (center.dy + (radius * startDegree.sin)));

    path.arcToPoint(
        Offset((center.dx + (radius * endDegree.cos)),
            (center.dy + (radius * endDegree.sin))),
        radius: Radius.circular(radius));

    /// Draws the second arc to the left side of
    /// the top segment.
    endDegree = Angle.fromDegrees(255);

    path.arcToPoint(
        Offset((center.dx + (radius * endDegree.cos)),
            (center.dy + (radius * endDegree.sin))),
        radius: Radius.circular(radius));

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
