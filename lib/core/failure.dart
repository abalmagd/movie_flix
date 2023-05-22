import 'package:dio/dio.dart';

import 'utils.dart';

/// Default class for handling errors & exceptions
class Failure implements Exception {
  final String? message;
  final int? code;
  final Exception? exception;

  Failure({
    required this.message,
    required this.code,
    this.exception,
  });

  static Failure handleExceptions(DioError e) {
    try {
      throw e;
    } on DioError catch (e) {
      Utils.logPrint(
        message: e.message ?? 'Message is null',
        error: e,
        stackTrace: e.stackTrace,
        name: 'Failure model class',
      );
      throw Failure(
        message: e.message ?? 'Something went wrong!',
        code: e.response?.statusCode,
        exception: e,
      );
    }
  }

  void toast() => Utils.toast(
        message: message ?? 'Something went wrong!',
        severity: ToastSeverity.danger,
      );

  @override
  String toString() =>
      'Failure(message: $message, code: $code, exception: $exception)';
}
