import 'dart:ui';

import 'package:flutter/material.dart';

Widget frostedIconButton(Widget child) {
  return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle),
              child: child)));
}
