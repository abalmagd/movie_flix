import 'media.dart';

class Person {
  final bool adult;
  final int gender;
  final int id;
  final List<Media> knownFor;
  final String knownForDepartment;
  final String name;
  final double popularity;
  final String profilePath;

  Person({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownFor,
    required this.knownForDepartment,
    required this.name,
    required this.popularity,
    required this.profilePath,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        adult: json['adult'],
        gender: json['gender'],
        id: json['id'],
        knownFor: List<Media>.from(
          json['known_for'].map((media) => Media.fromJson(media)),
        ),
        knownForDepartment: json['known_for_department'],
        name: json['name'],
        popularity: json['popularity']?.toDouble(),
        profilePath: json['profile_path'] ??
            'https://reactjsexample.com/content/images/2022/07/shorty-screenshot.png',
      );

  Map<String, dynamic> toJson() => {
        'adult': adult,
        'gender': gender,
        'id': id,
        'known_for': List<Media>.from(knownFor.map((x) => x.toJson())),
        'known_for_department': knownForDepartment,
        'name': name,
        'popularity': popularity,
        'profile_path': profilePath,
      };

  @override
  String toString() {
    return 'Person('
        'adult: $adult, '
        'gender: $gender, '
        'id: $id, '
        'known_for: $knownFor, '
        'known_for_department: $knownForDepartment,'
        'name: $name, '
        'popularity: $popularity, '
        'profile_path: $profilePath\n';
  }
}

class PersonDetails {
  final String biography;
  final String imdbId;
  final String homepage;
  final String deathDay;
  final String birthDay;
  final List<dynamic> imagePaths;

  PersonDetails({
    required this.biography,
    required this.imdbId,
    required this.homepage,
    required this.deathDay,
    required this.birthDay,
    required this.imagePaths,
  });

  factory PersonDetails.fromJson(Map<String, dynamic> json) => PersonDetails(
        biography: json['biography'] ?? '-',
        imdbId: json['imdb_id'] ?? '-',
        homepage: json['homepage'] ?? '-',
        deathDay: json['deathday'] ?? '-',
        birthDay: json['birthday'] ?? '-',
        imagePaths:
            json['images'].map((e) => e['file_path'] as String).toList(),
      );

  Map<String, dynamic> toJson() => {
        'biography': biography,
        'imdb_id': imdbId,
        'homepage': homepage,
        'deathday': deathDay,
        'birthday': birthDay,
        'imagePaths': imagePaths,
      };

  @override
  String toString() {
    return 'PersonDetails('
        'biography: $biography, '
        'imdb_id: $imdbId, '
        'homepage: $homepage, '
        'deathday: $deathDay, '
        'birthday: $birthDay, '
        'imagePaths: $imagePaths\n';
  }
}
