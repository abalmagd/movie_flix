import '../../home/domain/person.dart';

class MediaDetails {
  final int id;
  // Movies
  final BelongsToCollection? belongsToCollection;
  final int? runtime;
  final String status; // Media
  final String tagline; // Media
  // Series
  final List<int>? episodeRunTime;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<Season>? seasons;
  final String? type;
  final List<Person> cast;
  final List<String> backdrops;
  final List<String> posters;

  MediaDetails({
    required this.id,
    required this.belongsToCollection,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.episodeRunTime,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.seasons,
    required this.type,
    required this.cast,
    required this.backdrops,
    required this.posters,
  });

  factory MediaDetails.fromJson(Map<String, dynamic> json) {
    return MediaDetails(
      id: json['id'],
      belongsToCollection: json['belongs_to_collection'] == null
          ? null
          : BelongsToCollection.fromJson(json['belongs_to_collection']),
      runtime: json['runtime'],
      status: json['status'],
      tagline: json['tagline'],
      episodeRunTime: json['episode_run_time'] == null
          ? null
          : List<int>.from(json['episode_run_time']),
      numberOfEpisodes: json['number_of_episodes'],
      numberOfSeasons: json['number_of_seasons'],
      seasons: json['seasons'] == null
          ? null
          : List<Season>.from(json['seasons'].map((x) => Season.fromJson(x))),
      type: json['type'],
      cast: List<Person>.from(
          json['cast'].map((person) => Person.fromJson(person))),
      backdrops: List.from(json['images']['backdrops'])
          .map((backdrop) => backdrop['file_path'] as String)
          .toList(),
      posters: List.from(json['images']['posters'])
          .map((backdrop) => backdrop['file_path'] as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'belongs_to_collection': belongsToCollection?.toJson(),
        'runtime': runtime,
        'status': status,
        'tagline': tagline,
        'episode_run_time': List<int>.from(episodeRunTime ?? []),
        'number_of_episodes': numberOfEpisodes,
        'number_of_seasons': numberOfSeasons,
        'seasons': seasons == null
            ? null
            : List<Season>.from(seasons!.map((x) => x.toJson())),
        'type': type,
        'cast': cast,
      };
}

class BelongsToCollection {
  final int id;
  final String name;
  final String posterPath;
  final String backdropPath;

  BelongsToCollection({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
  });

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) {
    return BelongsToCollection(
      id: json['id'],
      name: json['name'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'poster_path': posterPath,
        'backdrop_path': backdropPath,
      };
}

class Season {
  final DateTime airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;
  final double voteAverage;

  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        airDate: DateTime.parse(json['air_date']),
        episodeCount: json['episode_count'],
        id: json['id'],
        name: json['name'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        seasonNumber: json['season_number'],
        voteAverage: json['vote_average']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'air_date':
            '${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}',
        'episode_count': episodeCount,
        'id': id,
        'name': name,
        'overview': overview,
        'poster_path': posterPath,
        'season_number': seasonNumber,
        'vote_average': voteAverage,
      };
}
