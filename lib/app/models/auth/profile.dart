import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../remote/environment_variables.dart';

/// gravatar https://www.gravatar.com/avatar/c9e9fc152ee756a900db85757c29815d
class Profile extends Equatable {
  final String avatar;
  final int id;
  final String iso6391;
  final String iso31661;
  final String name;
  final bool includeAdult;
  final String username;

  const Profile({
    required this.avatar,
    required this.id,
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.includeAdult,
    required this.username,
  });

  static const Profile empty = Profile(
    avatar: '',
    id: 0,
    iso6391: '',
    iso31661: '',
    name: '',
    includeAdult: false,
    username: '',
  );

  static const Profile guest = Profile(
    avatar: '',
    id: 0,
    iso6391: '',
    iso31661: '',
    name: 'Guest',
    includeAdult: false,
    username: 'Limited Features',
  );

  static const Profile unknown = Profile(
    avatar: '',
    id: 0,
    iso6391: '',
    iso31661: '',
    name: 'Unknown',
    includeAdult: false,
    username: 'Couldn\'t get profile data',
  );

  Profile copyWith({
    String? avatar,
    int? id,
    String? iso6391,
    String? iso31661,
    String? name,
    bool? includeAdult,
    String? username,
  }) =>
      Profile(
        avatar: avatar ?? this.avatar,
        id: id ?? this.id,
        iso6391: iso6391 ?? this.iso6391,
        iso31661: iso31661 ?? this.iso31661,
        name: name ?? this.name,
        includeAdult: includeAdult ?? this.includeAdult,
        username: username ?? this.username,
      );

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        avatar:
            '${RemoteEnvironment.gravatar}${json["avatar"]['gravatar']['hash']}',
        id: json["id"],
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        name: json["name"],
        includeAdult: json["include_adult"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "id": id,
        "iso_639_1": iso6391,
        "iso_3166_1": iso31661,
        "name": name,
        "include_adult": includeAdult,
        "username": username,
      };

  @override
  String toString() => 'Profile('
      'avatar: $avatar, '
      'id: $id, '
      'iso6391: $iso6391, '
      'iso31661: $iso31661, '
      'name: $name, '
      'includeAdult: $includeAdult, '
      'username: $username'
      ')';

  @override
  List<Object?> get props => [
        avatar,
        id,
        iso6391,
        iso31661,
        name,
        includeAdult,
        username,
      ];
}
