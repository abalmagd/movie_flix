import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/genre.dart';
import '../../domain/media.dart';

@immutable
class MediaState extends Equatable {
  const MediaState({
    this.popular = const AsyncData([]),
    this.topRated = const AsyncData([]),
    this.trending = const AsyncData([]),
    this.nowPlaying = const AsyncData([]),
    this.upcoming = const AsyncData([]),
    this.genres = const AsyncData([]),
  });

  final AsyncValue<List<Media>> popular;
  final AsyncValue<List<Media>> topRated;
  final AsyncValue<List<Media>> trending;
  final AsyncValue<List<Media>> nowPlaying;
  final AsyncValue<List<Media>> upcoming;
  final AsyncValue<List<Genre>> genres;

  MediaState copyWith({
    AsyncValue<List<Media>>? popular,
    AsyncValue<List<Media>>? topRated,
    AsyncValue<List<Media>>? trending,
    AsyncValue<List<Media>>? nowPlaying,
    AsyncValue<List<Media>>? upcoming,
    AsyncValue<List<Genre>>? genres,
  }) {
    return MediaState(
      popular: popular ?? this.popular,
      topRated: topRated ?? this.topRated,
      trending: trending ?? this.trending,
      nowPlaying: nowPlaying ?? this.nowPlaying,
      upcoming: upcoming ?? this.upcoming,
      genres: genres ?? this.genres,
    );
  }

  @override
  List<Object?> get props => [
        popular,
        topRated,
        trending,
        nowPlaying,
        upcoming,
        genres,
      ];
}
