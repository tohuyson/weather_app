// ignore_for_file: prefer_interpolation_to_compose_strings, constant_identifier_names

import 'dart:developer';

import 'package:flutter/foundation.dart';

enum LogType {
  ///use Log.d. Print Debug Logs
  DEBUG,

  ///use Log.i. Print Info Logs
  INFO,

  ///use Log.w. Print warning logs
  WARN,

  ///use Log.e. Print error logs
  ERROR,
}

class AppLog {
  static _log(LogType type, String tag, String message) {
    if (kIsWeb) {
      debugPrint("${_getPriorityText(type)}$tag: $message");
    } else {
      log("${_getPriorityText(type)}$tag: $message");
    }
  }

  static String _getPriorityText(LogType type) {
    switch (type) {
      case LogType.INFO:
        return "INFO | ";
      case LogType.DEBUG:
        return "DEBUG | ";
      case LogType.ERROR:
        return "ERROR | ";
      case LogType.WARN:
        return "WARN | ";
    }
  }

  ///Print info logs
  static i(String tag, String message) {
    _log(LogType.INFO, tag, message);
  }

  ///Print debug logs
  static d(String tag, String message) {
    _log(LogType.DEBUG, tag, message);
  }

  ///Print warning logs
  static w(String tag, String message) {
    _log(LogType.WARN, tag, message);
  }

  ///Print error logs
  static e(String tag, String message) {
    _log(LogType.ERROR, tag, message);
  }
}
