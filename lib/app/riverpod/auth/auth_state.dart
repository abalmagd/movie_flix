import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_flix/app/models/auth/session.dart';

@immutable
class AuthState extends Equatable {
  const AuthState({
    required this.session,
    this.requestToken = '',
    this.isLoading = false,
  });

  final Session session;
  final String requestToken;
  final bool isLoading;

  AuthState copyWith({
    Session? session,
    String? requestToken,
    bool? isLoading,
  }) {
    return AuthState(
      session: session ?? this.session,
      requestToken: requestToken ?? this.requestToken,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [session, requestToken, isLoading];
}
