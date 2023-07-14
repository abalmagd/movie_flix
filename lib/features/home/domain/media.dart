// To parse this JSON data, do
//
//     final movie = movieFromJson(jsonString);

import 'dart:convert';

class Media {
  final bool adult;
  final String? backdropPath;
  final int id;
  final String title;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final String? posterPath;
  final String? mediaType;
  final List<int> genreIds;
  final double popularity;
  final DateTime releaseDate;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Media({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Media.fromRawJson(String str) => Media.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        adult: json['adult'] ?? false,
        backdropPath: json['backdrop_path'],
        id: json['id'],
        title: json['title'] ?? json['name'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'] ?? json['original_name'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        mediaType: json['media_type'],
        genreIds: json['genre_ids'] == null
            ? List<int>.from(json['genres'].map((x) => x))
            : List<int>.from(json['genre_ids'].map((x) => x)),
        popularity: json['popularity']?.toDouble() ?? 0.0,
        releaseDate:
            DateTime.parse(json['release_date'] ?? json['first_air_date']),
        video: json['video'] ?? false,
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
        'genre_ids': List<dynamic>.from(genreIds.map((x) => x)),
        'popularity': popularity,
        'release_date':
            '${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}',
        'video': video,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };
}
