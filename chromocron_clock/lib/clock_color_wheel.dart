import 'package:flutter/material.dart';
import 'package:angles/angles.dart';
import 'package:tinycolor/tinycolor.dart';
import 'dart:math' as Math;

import 'color_globals.dart';

/// Draws the color wheel that is used as the clock background.
class ColorClockWheel extends StatefulWidget {
  /// The current time, used to determine the color
  /// of the ring outside the color wheel.
  final DateTime time;

  const ColorClockWheel({Key key, this.time}) : super(key: key);

  @override
  _ColorClockWheel createState() => _ColorClockWheel();
}

class _ColorClockWheel extends State<ColorClockWheel> {
  static ColorWheel colorWheel;

  /// Initiate the color wheel once.
  @override
  void initState() {
    super.initState();
    colorWheel = ColorWheel();
  }

  @override
  Widget build(BuildContext context) {
    int hour = widget.time.hour % 12;
    int minute = widget.time.minute;
    int seconds = widget.time.second;

    Color currentHourColor = Globals.colorList[hour];
    Color nextHourColor = Globals.colorList[(hour + 1) % 12];

    /// Calculate the transition value.
    double transition = (minute / 60) + (seconds / 3600);

    /// Highlight every quarter hour by brightening the ring.
    switch (minute) {
      case 0:
        {
          transition = 0.0;
        }
        break;
      case 15:
        {
          transition = 0.25;
        }
        break;
      case 30:
        {
          transition = 0.5;
        }
        break;
      case 45:
        {
          transition = 0.75;
        }
        break;
      default:
        {
          currentHourColor = TinyColor(currentHourColor)
              .darken(Globals.percentageBlackStroke)
              .color;
          nextHourColor = TinyColor(nextHourColor)
              .darken(Globals.percentageBlackStroke)
              .color;
        }
        break;
    }

    /// Calculate the current color using HSVColor for better results.
    Color strokeColor = HSVColor.lerp(HSVColor.fromColor(currentHourColor),
            HSVColor.fromColor(nextHourColor), transition)
        .toColor();

    return Stack(
      children: [
        Positioned.fill(child: CustomPaint(painter: ColorPainter(strokeColor))),
        Positioned.fill(child: CustomPaint(painter: colorWheel)),
      ],
    );
  }
}

/// Draws the ring outside the color wheel.
class ColorPainter extends CustomPainter {
  static Color animationColor;

  ColorPainter(Color color) {
    animationColor = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = (Math.min(size.width, size.height) / 2) *
        Globals.sizeReductionColorWheel;
    final center = Offset(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..color = animationColor
      ..strokeWidth = 20.0
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// Draws the color wheel based on 12 segments with 30 degree each.
class ColorWheel extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final radius = (Math.min(size.width, size.height) / 2) *
        Globals.sizeReductionColorWheel;
    final center = Offset(size.width / 2, size.height / 2);

    Paint paint = Paint();
    Path path = Path();

    /// Draw each segment using the color list.
    for (var i = 0; i < Globals.colorList.length; i++) {
      /// Place the first color of the list at the top segment.
      paint.color = Globals.colorList[(i + 4) % 12];

      Angle degreestart = Angle.fromDegrees((i).toDouble() * 30 + 15);
      Angle degreeend = degreestart + Angle.fromDegrees(30);

      path = Path();
      path.moveTo(center.dx, center.dy);
      path.lineTo((center.dx + (radius * degreestart.cos)),
          (center.dy + (radius * degreestart.sin)));
      path.arcToPoint(
        Offset((center.dx + (radius * degreeend.cos)),
            (center.dy + (radius * degreeend.sin))),
        radius: Radius.circular(radius),
      );
      path.close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
