import 'dart:developer';

import 'package:flutter/foundation.dart';

class Utils {
  static logPrint({
    required String message,
    required String name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      log(message, name: name, error: error, stackTrace: stackTrace);
    }
  }
}
