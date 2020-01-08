// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import "background_color.dart";
import "clock_color_wheel.dart";
import "clock_overlay.dart";

class Chromocron extends StatefulWidget {
  const Chromocron(this.model);

  final ClockModel model;

  @override
  _Chromocron createState() => _Chromocron();
}

class _Chromocron extends State<Chromocron> {
  var _now = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // Update once per second. Make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final time = DateTime.now();

    /// since the usual estimate of a chromocron is about 5 minutes,
    /// we'll use it for the semantic properties
    final timeDescription = time.hour.toString() +
        ":" +
        ((time.minute / 10).round() * 10).toString();

    final mode =
        Theme.of(context).brightness == Brightness.light ? true : false;

    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Chronocron color clock, time is about $timeDescription',
        value: timeDescription,
      ),
      child: Stack(
        children: [
          Positioned.fill(child: BackgroundColor(lightMode: mode, time: time)),
          Positioned.fill(child: ColorClockWheel(time: time)),
          Positioned.fill(child: ClockOverlay(lightMode: mode, time: time))
        ],
      ),
    );
  }
}
