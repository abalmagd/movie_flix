import 'dart:convert';

import 'package:equatable/equatable.dart';

class Session extends Equatable {
  final String sessionId;
  final String expiresAt;
  final bool isGuest;

  const Session({
    required this.sessionId,
    required this.expiresAt,
    required this.isGuest,
  });

  static const Session empty = Session(
    sessionId: '',
    expiresAt: '',
    isGuest: false,
  );

  factory Session.fromRawJson(String str) => Session.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        sessionId: json['session_id'] ?? '',
        expiresAt: json['expires_at'] ?? '',
        isGuest: json['is_guest'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'session_id': sessionId,
        'expires_at': expiresAt,
        'is_guest': isGuest,
      };

  @override
  String toString() =>
      'Session(sessionId: $sessionId, isGuest: $isGuest, expiresAt: $expiresAt)';

  @override
  List<Object?> get props => [sessionId, isGuest, expiresAt];
}
