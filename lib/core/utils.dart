import 'dart:developer';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../app/theme/palette.dart';

class Utils {
  static void logPrint({
    required String message,
    required String name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      log(message, name: name, error: error, stackTrace: stackTrace);
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
