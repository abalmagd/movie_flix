import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/core/failure.dart';
import 'package:movie_flix/remote/environment_variables.dart';

import '../../dio.dart';

/// Responsible for fetching data from remote api and checking for
/// network errors (Ex: connection timeout).
///
/// Data is returned as received without any modification.
abstract class BaseAuthRepository {
  Future<Map<String, dynamic>> loginAsGuest();

  Future<Map<String, dynamic>> logout({required String sessionId});
}

final baseAuthRepositoryProvider = Provider<BaseAuthRepository>((ref) {
  return AuthRepository(ref.watch(dioProvider));
});

class AuthRepository implements BaseAuthRepository {
  AuthRepository(this._dio);

  final Dio _dio;

  @override
  Future<Map<String, dynamic>> loginAsGuest() async {
    try {
      final response = await _dio.get(
        '${RemoteEnvironment.authentication}${RemoteEnvironment.newGuestSession}',
      );

      final Map<String, dynamic> json = response.data;

      if (!json['success']) {
        throw Failure(
          message: json['status_message'],
          code: json['status_code'],
        );
      }

      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> logout({required String sessionId}) async {
    try {
      final response = await _dio.delete(
        '${RemoteEnvironment.authentication}${RemoteEnvironment.session}',
        data: {"session_id": sessionId},
      );

      final Map<String, dynamic> json = response.data;

      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }
}
