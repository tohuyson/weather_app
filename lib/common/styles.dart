import 'package:flutter/material.dart' as system;
import 'package:flutter/rendering.dart';

import 'colors.dart';

class UITextStyle {
  UITextStyle._();

  static system.TextStyle thin = _style.copyWith(
    color: UIColors.defaultText,
    fontSize: 14,
    fontWeight: FontWeight.w100,
    height: 1.5,
  );

  static system.TextStyle light = _style.copyWith(
    color: UIColors.defaultText,
    fontSize: 14,
    fontWeight: FontWeight.w300,
    height: 1.5,
  );

  static system.TextStyle regular = _style.copyWith(
    color: UIColors.defaultText,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static system.TextStyle medium = _style.copyWith(
    color: UIColors.defaultText,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  static system.TextStyle semiBold = _style.copyWith(
    color: UIColors.defaultText,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  static system.TextStyle bold = _style.copyWith(
    color: UIColors.defaultText,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.5,
  );

  static system.TextStyle extraBold = _style.copyWith(
    color: UIColors.defaultText,
    fontSize: 14,
    fontWeight: FontWeight.w800,
    height: 1.5,
  );

  static system.TextStyle black = _style.copyWith(
    color: UIColors.defaultText,
    fontSize: 14,
    fontWeight: FontWeight.w900,
    height: 1.5,
  );
}

const _style = system.TextStyle(fontFamily: 'Roboto');
