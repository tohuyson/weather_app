import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  static const ScrollPhysics physics = AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics());
}
