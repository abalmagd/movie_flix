import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../config/theme/palette.dart';

class Utils {
  static void logPrint({
    required String message,
    Level level = Level.info,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      final logger = Logger();
      logger.log(level, message, error, stackTrace);
    }
  }

  static void toast({
    required String message,
    ToastSeverity severity = ToastSeverity.neutral,
    Toast length = Toast.LENGTH_SHORT,
  }) {
    late final Color color;

    switch (severity) {
      case ToastSeverity.danger:
        color = Palette.danger;
        break;
      case ToastSeverity.ok:
        color = Palette.ok;
        break;
      case ToastSeverity.neutral:
        color = Palette.neutral;
        break;
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: Palette.white,
      fontSize: 16.0,
    );
  }
}

enum ToastSeverity { danger, ok, neutral }
