import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_flix/features/auth/domain/session.dart';

@immutable
class AuthState extends Equatable {
  const AuthState({
    required this.session,
    this.requestToken = '',
    this.expiresAt = '',
  });

  final Session session;
  final String requestToken;
  final String expiresAt;

  AuthState copyWith({
    Session? session,
    String? requestToken,
    String? expiresAt,
  }) {
    return AuthState(
      session: session ?? this.session,
      requestToken: requestToken ?? this.requestToken,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  @override
  List<Object?> get props => [session, requestToken, expiresAt];
}
