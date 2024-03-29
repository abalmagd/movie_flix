import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/features/home/data/movies/movies_service.dart';
import 'package:movie_flix/utils/utils.dart';

import '../media_state.dart';

final moviesControllerProvider =
    StateNotifierProvider<MoviesController, MediaState>(
  (ref) {
    return MoviesController(
      const MediaState(),
      ref.read(baseMoviesServiceProvider),
    );
  },
);

class MoviesController extends StateNotifier<MediaState> {
  late final BaseMoviesService _moviesService;

  MoviesController(MediaState state, this._moviesService) : super(state) {
    Utils.logPrint(message: 'Building $runtimeType');
    getGenres();
    getNowPlaying();
    getPopular();
    getTrending();
    getTopRated();
    getUpcoming();
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
