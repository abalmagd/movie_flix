import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:movie_flix/app/models/auth/profile.dart';

class Session extends Equatable {
  final String sessionId;
  final Profile profile;
  final String expiresAt;
  final bool isGuest;

  const Session({
    required this.sessionId,
    required this.profile,
    required this.expiresAt,
    required this.isGuest,
  });

  static const Session empty = Session(
    sessionId: '',
    profile: Profile.empty,
    expiresAt: '',
    isGuest: false,
  );

  factory Session.fromRawJson(String str) => Session.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Session.fromJson(Map<String, dynamic> json) => Session(
    sessionId: json['session_id'] ?? '',
        profile: json['profile'] != null
            ? Profile.fromJson(json['profile'])
            : (json['is_guest'] ? Profile.guest : Profile.unknown),
        expiresAt: json['expires_at'] ?? '',
        isGuest: json['is_guest'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'session_id': sessionId,
        'profile': profile.toJson(),
        'expires_at': expiresAt,
        'is_guest': isGuest,
      };

  @override
  String toString() => 'Session('
      'sessionId: $sessionId, '
      'profile: ${profile.toString()}, '
      'isGuest: $isGuest, '
      'expiresAt: $expiresAt'
      ')';

  @override
  List<Object?> get props => [
        sessionId,
        profile,
        isGuest,
        expiresAt,
      ];
}
