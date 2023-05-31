import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/core/extensions.dart';
import 'package:movie_flix/core/failure.dart';
import 'package:movie_flix/remote/api/auth/auth_repository.dart';

import '../../../app/models/auth/session.dart';

/// Responsible for modifying the data received from the repository
/// and checking for request errors (Ex: bad token).
///
/// Data is returned after proper modification.
///
/// For example: When a guest session json is returned from the repository,
/// the field [guest_session_id] is renamed to [session_id]
abstract class BaseAuthService {
  Future<Either<Failure, Session>> loginAsGuest();

  Future<Either<Failure, bool>> logout({required String sessionId});

  Future<Either<Failure, Map<String, String>>> createRequestToken();

  Future<Either<Failure, Session>> login({required String requestToken});
}

final baseAuthServiceProvider = Provider<BaseAuthService>((ref) {
  return AuthService(ref.watch(baseAuthRepositoryProvider));
});

class AuthService implements BaseAuthService {
  AuthService(this._baseAuthRepository);

  final BaseAuthRepository _baseAuthRepository;

  @override
  Future<Either<Failure, Session>> loginAsGuest() async {
    try {
      final json = await _baseAuthRepository.loginAsGuest();

      final bool success = json['success'];

      if (!success) {
        throw Failure(
          message: json['status_message'],
          code: json['status_code'],
        );
      }

      json.changeKeyName('guest_session_id', 'session_id');
      json.addAll({'is_guest': true});

      final session = Session.fromJson(json);
      return Right(session);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Map<String, String>>> createRequestToken() async {
    try {
      final json = await _baseAuthRepository.createRequestToken();

      final bool success = json['success'];

      if (!success) {
        throw Failure(
          message: json['status_message'],
          code: json['status_code'],
        );
      }

      final String requestToken = json['request_token'];
      final String expiresAt = json['expires_at'];

      final data = {
        'request_token': requestToken,
        'expires_at': expiresAt,
      };

      return Right(data);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Session>> login({required String requestToken}) async {
    try {
      final Map<String, dynamic> json = {};

      final tokenJson = await _baseAuthRepository.login(requestToken);

      json.addEntries(tokenJson.entries);

      final profileJson =
          await _baseAuthRepository.getProfile(tokenJson['session_id']);

      json.addAll({'profile': profileJson});

      final success = tokenJson['success'] && (profileJson['success'] ?? true);

      if (!success) {
        throw Failure(
          message: json['status_message'],
          code: json['status_code'],
        );
      }

      final session = Session.fromJson(json);
      return Right(session);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, bool>> logout({required String sessionId}) async {
    try {
      final json = await _baseAuthRepository.logout(sessionId);

      final bool success = json['success'];

      if (!success) {
        throw Failure(
          message: json['status_message'],
          code: json['status_code'],
        );
      }

      return Right(success);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
