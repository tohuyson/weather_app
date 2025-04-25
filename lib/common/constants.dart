import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  static const ScrollPhysics physics = AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics());

  static const Duration animationDuration = Duration(milliseconds: 500);
  static const Curve animationCurve = Curves.easeInOut;
}
