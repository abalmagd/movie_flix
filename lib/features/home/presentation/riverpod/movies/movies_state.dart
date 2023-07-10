import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../shared/domain/movie.dart';
import '../../../domain/genre.dart';

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

  final AsyncValue<List<Movie>> popular;
  final AsyncValue<List<Movie>> topRated;
  final AsyncValue<List<Movie>> trending;
  final AsyncValue<List<Movie>> nowPlaying;
  final AsyncValue<List<Movie>> upcoming;
  final AsyncValue<List<Genre>> genres;

  MoviesState copyWith({
    AsyncValue<List<Movie>>? popular,
    AsyncValue<List<Movie>>? topRated,
    AsyncValue<List<Movie>>? trending,
    AsyncValue<List<Movie>>? nowPlaying,
    AsyncValue<List<Movie>>? upcoming,
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
