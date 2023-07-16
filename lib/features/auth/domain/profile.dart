import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:movie_flix/shared/data/environment_variables.dart';
import 'package:username_gen/username_gen.dart';

/// Gravatar https://www.gravatar.com/avatar/c9e9fc152ee756a900db85757c29815d
class Profile extends Equatable {
  final Avatar avatar;
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
    avatar: Avatar.empty,
    id: 0,
    iso6391: '',
    iso31661: '',
    name: '',
    includeAdult: false,
    username: '',
  );

  static Profile guest = Profile(
    avatar: Avatar.empty,
    id: 0,
    iso6391: '',
    iso31661: '',
    name: 'Guest Session',
    includeAdult: false,
    username: UsernameGen().generate(),
  );

  static const Profile unknown = Profile(
    avatar: Avatar.empty,
    id: 0,
    iso6391: '',
    iso31661: '',
    name: 'Error',
    includeAdult: false,
    username: 'with loading profile',
  );

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        avatar: Avatar.fromJson(json['avatar'] ?? Avatar.empty),
        id: json['id'],
        iso6391: json['iso_639_1'],
        iso31661: json['iso_3166_1'],
        name: json['name'],
        includeAdult: json['include_adult'],
        username: json['username'],
      );

  Map<String, dynamic> toJson() => {
        'avatar': avatar.toJson(),
        'id': id,
        'iso_639_1': iso6391,
        'iso_3166_1': iso31661,
        'name': name,
        'include_adult': includeAdult,
        'username': username,
      };

  @override
  String toString() => 'Profile('
      'avatar: ${avatar.toString()}, '
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

class Avatar extends Equatable {
  final String gravatar;
  final String tmdb;

  const Avatar({
    required this.gravatar,
    required this.tmdb,
  });

  static const Avatar empty = Avatar(
    gravatar: RemoteEnvironment.gravatar,
    tmdb: '',
  );

  factory Avatar.fromRawJson(String str) => Avatar.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      gravatar: '${RemoteEnvironment.gravatar}${json['gravatar']['hash']}',
      tmdb: json['tmdb']['avatar_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'gravatar': {'hash': gravatar},
        'tmdb': {'avatar_path': tmdb},
      };

  @override
  String toString() => 'Avatar(gravatar: $gravatar, tmdb: $tmdb)';

  @override
  List<Object?> get props => [gravatar, tmdb];
}
