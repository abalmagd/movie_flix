import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/core/failure.dart';
import 'package:movie_flix/remote/api/auth/auth_repository.dart';

import '../../../app/models/session.dart';
import '../../../core/utils.dart';

/// Responsible for modifying the data received from the repository
/// and checking for request errors (Ex: bad token).
///
/// Data is returned after proper modification.
///
/// For example: When a guest session json is returned from the repository,
/// the field [guest_session_id] is renamed to [session_id]
abstract class BaseAuthService {
  Future<Either<Failure, String>> getRequestToken();

  Future<Either<Failure, Session>> login({required String requestToken});

  Future<Either<Failure, bool>> logout({required String accessToken});
}

final baseAuthServiceProvider = Provider<BaseAuthService>((ref) {
  return AuthService(ref.watch(baseAuthRepositoryProvider));
});

class AuthService implements BaseAuthService {
  AuthService(this._baseAuthRepository);

  final BaseAuthRepository _baseAuthRepository;

  @override
  Future<Either<Failure, String>> getRequestToken() async {
    try {
      final json = await _baseAuthRepository.getRequestToken();

      final bool success = json['success'];

      Utils.logPrint(
        message: success.toString(),
        name: 'Request Token',
      );

      if (!success) {
        throw Failure(
          message: json['status_message'],
          code: json['status_code'],
        );
      }

      final requestToken = json['request_token'];

      return Right(requestToken);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Session>> login({required String requestToken}) async {
    try {
      final json = await _baseAuthRepository.login(requestToken: requestToken);

      final bool success = json['success'];

      Utils.logPrint(
        message: success.toString(),
        name: 'Request Token',
      );

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
  Future<Either<Failure, bool>> logout({required String accessToken}) async {
    try {
      final json = await _baseAuthRepository.logout(accessToken: accessToken);

      final bool success = json['success'];

      Utils.logPrint(
        message: success.toString(),
        name: 'Logout',
      );

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
