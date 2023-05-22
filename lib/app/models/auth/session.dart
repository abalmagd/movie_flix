import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:movie_flix/app/models/auth/profile.dart';

class Session extends Equatable {
  final String accessToken;
  final String accountId;
  final String sessionId;
  final Profile profile;
  final String expiresAt;
  final bool isGuest;

  const Session({
    required this.accessToken,
    required this.accountId,
    required this.sessionId,
    required this.profile,
    required this.expiresAt,
    required this.isGuest,
  });

  static const Session empty = Session(
    accessToken: '',
    accountId: '',
    sessionId: '',
    profile: Profile.empty,
    expiresAt: '',
    isGuest: false,
  );

  static Session guest({required String uid}) => Session(
        accessToken: '',
        accountId: '',
        sessionId: uid,
        profile: Profile.guest,
        expiresAt: DateTime.now().add(const Duration(days: 1)).toString(),
        isGuest: true,
      );

  factory Session.fromRawJson(String str) => Session.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        accessToken: json['access_token'] ?? '',
        accountId: json['account_id'] ?? '',
        sessionId: json['session_id'] ?? '',
        profile: Profile.fromJson(json['profile'] ?? Profile.unknown.toJson()),
        expiresAt: json['expires_at'] ?? '',
        isGuest: json['is_guest'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'account_id': accountId,
        'session_id': sessionId,
        'profile': profile,
        'expires_at': expiresAt,
        'is_guest': isGuest,
      };

  @override
  String toString() => 'Session('
      'access_token: $accessToken, '
      'accountId: $accountId, '
      'sessionId: $sessionId, '
      'profile: ${profile.toString()}, '
      'isGuest: $isGuest, '
      'expiresAt: $expiresAt'
      ')';

  @override
  List<Object?> get props => [
        accessToken,
        accountId,
        sessionId,
        profile,
        isGuest,
        expiresAt,
      ];
}
