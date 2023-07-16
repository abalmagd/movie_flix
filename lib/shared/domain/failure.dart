import 'dart:io';

import 'package:dio/dio.dart';

import '../../utils/utils.dart';

/// Default class for handling errors & exceptions
class Failure implements Exception {
  final String message;
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
      switch (e.type) {
        case DioErrorType.badResponse:
          throw Failure(
            message: 'Error bad response',
            code: e.response?.statusCode,
            exception: e,
          );
        case DioErrorType.connectionTimeout:
          throw Failure(
            message: 'Connection time out',
            code: e.response?.statusCode,
            exception: e,
          );
        case DioErrorType.sendTimeout:
          throw Failure(
            message: 'Post connection time out',
            code: e.response?.statusCode,
            exception: e,
          );
        case DioErrorType.receiveTimeout:
          throw Failure(
            message: 'Get connection time out',
            code: e.response?.statusCode,
            exception: e,
          );
        case DioErrorType.badCertificate:
          throw Failure(
            message: 'Connection failed due to a bad certificate',
            code: e.response?.statusCode,
            exception: e,
          );
        case DioErrorType.cancel:
          throw Failure(
            message: 'Request was canceled',
            code: e.response?.statusCode,
            exception: e,
          );
        case DioErrorType.connectionError:
          throw Failure(
            message: 'Failed to connect to server',
            code: e.response?.statusCode,
            exception: e,
          );
        case DioErrorType.unknown:
          throw Failure(
            message: e.message ?? 'Something went wrong',
            code: e.response?.statusCode,
            exception: e,
          );
      }
    }
  }

  void toast() => Utils.toast(
        message: message,
        severity: ToastSeverity.danger,
      );

  @override
  String toString() => 'Failure('
      'message: $message, '
      'code: $code, '
      'exception: $exception'
      ')';
}
