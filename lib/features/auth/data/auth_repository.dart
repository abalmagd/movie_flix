import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/shared/domain/failure.dart';
import 'package:movie_flix/shared/data/environment_variables.dart';

import '../../../shared/data/dio.dart';

/// Responsible for fetching data from remote api and checking for
/// network errors (Ex: connection timeout).
///
/// Data is returned as received without any modification.
abstract class BaseAuthRepository {
  Future<Map<String, dynamic>> loginAsGuest();

  Future<Map<String, dynamic>> createRequestToken();

  Future<Map<String, dynamic>> login(String requestToken);

  Future<Map<String, dynamic>> getProfile(String sessionId);

  Future<Map<String, dynamic>> logout(String sessionId);
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
      final response = await _dio.post(RemoteEnvironment.newGuestSession);

      final Map<String, dynamic> json = response.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> createRequestToken() async {
    try {
      final response = await _dio.get(RemoteEnvironment.createRequestToken);

      final Map<String, dynamic> json = response.data;

      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> login(String requestToken) async {
    try {
      final response = await _dio.post(
        RemoteEnvironment.newSession,
        data: {'request_token': requestToken},
      );

      final Map<String, dynamic> json = response.data;

      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getProfile(String sessionId) async {
    try {
      final response = await _dio.get(
        RemoteEnvironment.account,
        queryParameters: {'session_id': sessionId},
      );

      final Map<String, dynamic> json = response.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> logout(String sessionId) async {
    try {
      final response = await _dio.delete(
        RemoteEnvironment.session,
        data: {'session_id': sessionId},
      );

      final Map<String, dynamic> json = response.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }
}
