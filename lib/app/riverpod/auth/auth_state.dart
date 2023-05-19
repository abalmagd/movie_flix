import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/app/models/session.dart';

@immutable
class AuthState extends Equatable {
  const AuthState({
    required this.session,
  });

  final AsyncValue<Session> session;

  AuthState copyWith({
    AsyncValue<Session>? session,
  }) {
    return AuthState(
      session: session ?? this.session,
    );
  }

  @override
  List<Object?> get props => [session];
}
