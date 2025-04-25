import 'package:flutter/material.dart';

class AppSize {
  AppSize._();

  static final AppSize instance = AppSize._();

  double width = 0;
  double height = 0;
  double safeTop = 0;
  double safeBottom = 0;

  void init(BuildContext context) {
    final media = MediaQuery.of(context);
    width = media.size.width;
    height = media.size.height;
    safeTop = media.viewPadding.top;
    safeBottom = media.viewPadding.bottom;
  }

  bool get isMobile => width < 500;
}
