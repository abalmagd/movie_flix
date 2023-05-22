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
  Future<Map<String, dynamic>> getRequestToken();

  Future<Map<String, dynamic>> login({required String requestToken});

  Future<Map<String, dynamic>> getSessionId({required String accessToken});

  Future<Map<String, dynamic>> getAccountDetails({required String sessionId});

  Future<Map<String, dynamic>> logout({required String accessToken});
}

final baseAuthRepositoryProvider = Provider<BaseAuthRepository>((ref) {
  return AuthRepository(ref.watch(dioProvider));
});

class AuthRepository implements BaseAuthRepository {
  AuthRepository(this._dio);

  final Dio _dio;

  @override
  Future<Map<String, dynamic>> getRequestToken() async {
    try {
      final response = await _dio.post(RemoteEnvironment.requestToken);

      final Map<String, dynamic> json = response.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> login({required String requestToken}) async {
    try {
      final response = await _dio.post(
        RemoteEnvironment.accessToken,
        data: {'request_token': requestToken},
      );

      final Map<String, dynamic> json = response.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getSessionId(
      {required String accessToken}) async {
    try {
      final response = await _dio.post(
        RemoteEnvironment.createSession,
        data: {'access_token': accessToken},
      );

      final Map<String, dynamic> json = response.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getAccountDetails(
      {required String sessionId}) async {
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
  Future<Map<String, dynamic>> logout({required String accessToken}) async {
    try {
      final response = await _dio.delete(
        RemoteEnvironment.accessToken,
        data: {'access_token': accessToken},
      );

      final Map<String, dynamic> json = response.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }
}
