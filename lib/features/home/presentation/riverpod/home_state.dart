import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/domain/movie.dart';
import '../../domain/genre.dart';

@immutable
class HomeState extends Equatable {
  const HomeState({
    required this.popularMovies,
    required this.topRatedMovies,
    required this.trendingMovies,
    required this.nowPlayingMovies,
    required this.upcomingMovies,
    required this.movieGenres,
  });

  final AsyncValue<List<Movie>> popularMovies;
  final AsyncValue<List<Movie>> topRatedMovies;
  final AsyncValue<List<Movie>> trendingMovies;
  final AsyncValue<List<Movie>> nowPlayingMovies;
  final AsyncValue<List<Movie>> upcomingMovies;
  final AsyncValue<List<Genre>> movieGenres;

  HomeState copyWith({
    AsyncValue<List<Movie>>? popularMovies,
    AsyncValue<List<Movie>>? topRatedMovies,
    AsyncValue<List<Movie>>? trendingMovies,
    AsyncValue<List<Movie>>? nowPlayingMovies,
    AsyncValue<List<Movie>>? upcomingMovies,
    AsyncValue<List<Genre>>? movieGenres,
  }) {
    return HomeState(
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      trendingMovies: trendingMovies ?? this.trendingMovies,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      movieGenres: movieGenres ?? this.movieGenres,
    );
  }

  @override
  List<Object?> get props =>
      [
        popularMovies,
        topRatedMovies,
        trendingMovies,
        nowPlayingMovies,
        upcomingMovies,
        movieGenres,
      ];
}
