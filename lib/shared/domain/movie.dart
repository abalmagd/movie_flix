// To parse this JSON data, do
//
//     final movie = movieFromJson(jsonString);

import 'dart:convert';

class Movie {
  final bool adult;
  final String backdropPath;
  final int id;
  final String title;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String? mediaType;
  final List<int> genresIds;
  final double popularity;
  final DateTime releaseDate;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.genresIds,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  static Movie empty = Movie(
    adult: false,
    backdropPath: '',
    id: 0,
    title: '',
    originalLanguage: '',
    originalTitle: '',
    overview: '',
    posterPath: '',
    mediaType: '',
    genresIds: [],
    popularity: 0,
    releaseDate: DateTime.now(),
    video: false,
    voteAverage: 0,
    voteCount: 0,
  );

  factory Movie.fromRawJson(String str) => Movie.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        id: json['id'],
        title: json['title'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        mediaType: json['media_type'],
        genresIds: json['genre_ids'] == null
            ? List<int>.from(json['genres'].map((x) => x))
            : List<int>.from(json['genre_ids'].map((x) => x)),
        popularity: json['popularity']?.toDouble(),
        releaseDate: DateTime.parse(json['release_date']),
        video: json['video'],
        voteAverage: json['vote_average']?.toDouble(),
        voteCount: json['vote_count'],
      );

  Map<String, dynamic> toJson() =>
      {
        'adult': adult,
        'backdrop_path': backdropPath,
        'id': id,
        'title': title,
        'original_language': originalLanguage,
        'original_title': originalTitle,
        'overview': overview,
        'poster_path': posterPath,
        'media_type': mediaType,
        'genre_ids': List<dynamic>.from(genresIds.map((x) => x)),
        'popularity': popularity,
        'release_date':
            '${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}',
        'video': video,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };
}
