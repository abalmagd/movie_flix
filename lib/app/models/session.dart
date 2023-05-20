import 'dart:convert';

import 'package:equatable/equatable.dart';

class Session extends Equatable {
  final String accessToken;
  final String accountId;
  final String expiresAt;
  final bool isGuest;

  const Session({
    required this.accessToken,
    required this.accountId,
    required this.expiresAt,
    required this.isGuest,
  });

  static const Session empty = Session(
    accessToken: '',
    accountId: '',
    expiresAt: '',
    isGuest: false,
  );

  static Session guest({required String uid}) => Session(
        accessToken: '',
        accountId: uid,
        expiresAt: DateTime.now().add(const Duration(days: 1)).toString(),
        isGuest: true,
      );

  factory Session.fromRawJson(String str) => Session.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        accessToken: json['access_token'] ?? '',
        accountId: json['account_id'] ?? '',
        expiresAt: json['expires_at'] ?? '',
        isGuest: json['is_guest'] ?? false,
      );

  Map<String, dynamic> toJson() =>
      {
        'access_token': accessToken,
        'account_id': accountId,
        'expires_at': expiresAt,
        'is_guest': isGuest,
      };

  @override
  String toString() => 'Session('
      'access_token: $accessToken, '
      'accountId: $accountId, '
      'isGuest: $isGuest, '
      'expiresAt: $expiresAt'
      ')';

  @override
  List<Object?> get props => [accessToken, accountId, isGuest, expiresAt];
}
