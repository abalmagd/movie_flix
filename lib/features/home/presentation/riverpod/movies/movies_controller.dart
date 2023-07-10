import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/features/home/data/movies/movies_service.dart';
import 'package:movie_flix/utils/utils.dart';

import '../../../../../shared/data/local_storage.dart';
import 'movies_state.dart';

final moviesControllerProvider =
    NotifierProvider<MoviesController, MoviesState>(MoviesController.new);

class MoviesController extends Notifier<MoviesState> {
  late final SharedPrefs _sharedPrefs;
  late final BaseMoviesService _moviesService;

  @override
  MoviesState build() {
    Utils.logPrint(message: 'Building $runtimeType');

    _sharedPrefs = ref.read(sharedPrefsProvider);
    _moviesService = ref.read(baseMoviesServiceProvider);

    return const MoviesState(
      popular: AsyncData([]),
      topRated: AsyncData([]),
      trending: AsyncData([]),
      nowPlaying: AsyncData([]),
      upcoming: AsyncData([]),
      genres: AsyncData([]),
    );
  }

  Future<void> getNowPlaying({int page = 1}) async {
    state = state.copyWith(nowPlaying: const AsyncLoading());

    final result = await _moviesService.getNowPlaying();

    result.fold(
      (failure) {
        state = state.copyWith(
          nowPlaying: AsyncError(failure, StackTrace.current),
        );
      },
      (list) {
        state = state.copyWith(nowPlaying: AsyncData(list));
      },
    );
  }

  Future<void> getPopular({int page = 1}) async {
    state = state.copyWith(popular: const AsyncLoading());

    final result = await _moviesService.getPopular();

    result.fold(
      (failure) {
        state = state.copyWith(
          popular: AsyncError(failure, StackTrace.current),
        );
      },
      (list) {
        state = state.copyWith(popular: AsyncData(list));
      },
    );
  }

  Future<void> getTopRated({int page = 1}) async {
    state = state.copyWith(topRated: const AsyncLoading());

    final result = await _moviesService.getTopRated();

    result.fold(
      (failure) {
        state = state.copyWith(
          topRated: AsyncError(failure, StackTrace.current),
        );
      },
      (list) {
        state = state.copyWith(topRated: AsyncData(list));
      },
    );
  }

  Future<void> getTrending({int page = 1}) async {
    state = state.copyWith(trending: const AsyncLoading());

    final result = await _moviesService.getTrending();

    result.fold(
      (failure) {
        state = state.copyWith(
          trending: AsyncError(failure, StackTrace.current),
        );
      },
      (list) {
        state = state.copyWith(trending: AsyncData(list));
      },
    );
  }

  Future<void> getUpcoming({int page = 1}) async {
    state = state.copyWith(upcoming: const AsyncLoading());

    final result = await _moviesService.getUpcoming();

    result.fold(
      (failure) {
        state = state.copyWith(
          upcoming: AsyncError(failure, StackTrace.current),
        );
      },
      (list) {
        state = state.copyWith(upcoming: AsyncData(list));
      },
    );
  }

  Future<void> getGenres() async {
    state = state.copyWith(genres: const AsyncLoading());

    final result = await _moviesService.getGenres();

    result.fold(
      (failure) {
        state = state.copyWith(
          genres: AsyncError(failure, StackTrace.current),
        );
      },
      (genres) {
        state = state.copyWith(genres: AsyncData(genres));
      },
    );
  }
}
