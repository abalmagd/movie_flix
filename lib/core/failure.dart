import 'package:dio/dio.dart';

import 'utils.dart';

class Failure implements Exception {
  final String? message;
  final int? code;
  final Exception? exception;

  Failure({
    required this.message,
    required this.code,
    required this.exception,
  });

  static Failure handleExceptions(e) {
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

  @override
  String toString() =>
      'Failure(message: $message, code: $code, exception: $exception)';
}
