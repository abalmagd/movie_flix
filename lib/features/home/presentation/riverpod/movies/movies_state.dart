import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/genre.dart';
import '../../../domain/media.dart';

@immutable
class MoviesState extends Equatable {
  const MoviesState({
    required this.popular,
    required this.topRated,
    required this.trending,
    required this.nowPlaying,
    required this.upcoming,
    required this.genres,
  });

  final AsyncValue<List<Media>> popular;
  final AsyncValue<List<Media>> topRated;
  final AsyncValue<List<Media>> trending;
  final AsyncValue<List<Media>> nowPlaying;
  final AsyncValue<List<Media>> upcoming;
  final AsyncValue<List<Genre>> genres;

  MoviesState copyWith({
    AsyncValue<List<Media>>? popular,
    AsyncValue<List<Media>>? topRated,
    AsyncValue<List<Media>>? trending,
    AsyncValue<List<Media>>? nowPlaying,
    AsyncValue<List<Media>>? upcoming,
    AsyncValue<List<Genre>>? genres,
  }) {
    return MoviesState(
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
