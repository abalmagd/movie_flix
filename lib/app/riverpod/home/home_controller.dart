import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/core/utils.dart';
import 'package:movie_flix/remote/api/home/home_service.dart';

import '../../../core/local_storage.dart';
import '../../models/media/movie.dart';
import 'home_state.dart';

final homeControllerProvider =
    NotifierProvider<HomeController, HomeState>(HomeController.new);

class HomeController extends Notifier<HomeState> {
  late final SharedPrefs _sharedPrefs;
  late final BaseHomeService _homeService;

  @override
  HomeState build() {
    Utils.logPrint(message: 'Building $runtimeType');

    _sharedPrefs = ref.read(sharedPrefsProvider);
    _homeService = ref.read(baseHomeServiceProvider);

    return const HomeState(
      popularMovies: AsyncData([]),
      topRatedMovies: AsyncData([]),
      trendingMovies: AsyncData([]),
      nowPlayingMovies: AsyncData([]),
      upcomingMovies: AsyncData([]),
    );
  }

  Future<List<Movie>> getMovieListByType({
    required MovieListType type,
    int page = 1,
    bool init = false,
  }) async {
    List<Movie>? movies;
    switch (type) {
      case MovieListType.popular:
        if (!init) state = state.copyWith(popularMovies: const AsyncLoading());

        final result = await _homeService.getPopularMovies();
        result.fold(
          (failure) {
            if (!init) {
              state = state.copyWith(
                  popularMovies: AsyncError(failure, StackTrace.current));
            }
          },
          (list) {
            if (!init) state = state.copyWith(popularMovies: AsyncData(list));

            movies = list;
          },
        );
        break;
      case MovieListType.topRated:
        if (!init) state = state.copyWith(topRatedMovies: const AsyncLoading());

        final result = await _homeService.getTopRatedMovies();
        result.fold(
          (failure) {
            if (!init) {
              state = state.copyWith(
                topRatedMovies: AsyncError(failure, StackTrace.current),
              );
            }
          },
          (list) {
            if (!init) state = state.copyWith(topRatedMovies: AsyncData(list));

            movies = list;
          },
        );
        break;
      case MovieListType.trending:
        if (!init) state = state.copyWith(trendingMovies: const AsyncLoading());

        final result = await _homeService.getTrendingMovies();
        result.fold(
          (failure) {
            if (!init) {
              state = state.copyWith(
                trendingMovies: AsyncError(failure, StackTrace.current),
              );
            }
          },
          (list) {
            if (!init) state = state.copyWith(trendingMovies: AsyncData(list));

            movies = list;
          },
        );
        break;
      case MovieListType.nowPlaying:
        if (!init) {
          state = state.copyWith(nowPlayingMovies: const AsyncLoading());
        }

        final result = await _homeService.getNowPlayingMovies();
        result.fold(
          (failure) {
            if (!init) {
              state = state.copyWith(
                nowPlayingMovies: AsyncError(failure, StackTrace.current),
              );
            }
          },
          (list) {
            if (!init) {
              state = state.copyWith(nowPlayingMovies: AsyncData(list));
            }

            movies = list;
          },
        );
        break;
      case MovieListType.upcoming:
        if (!init) state = state.copyWith(upcomingMovies: const AsyncLoading());
        final result = await _homeService.getUpcomingMovies();
        result.fold(
          (failure) {
            if (!init) {
              state = state.copyWith(
                upcomingMovies: AsyncError(failure, StackTrace.current),
              );
            }
          },
          (list) {
            if (!init) state = state.copyWith(upcomingMovies: AsyncData(list));
            movies = list;
          },
        );
        break;
    }

    return movies ?? [];
  }
}
