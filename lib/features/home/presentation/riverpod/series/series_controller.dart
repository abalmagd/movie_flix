import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/utils/utils.dart';

import '../../../data/series/series_service.dart';
import '../media_state.dart';

final seriesControllerProvider =
    StateNotifierProvider<SeriesController, MediaState>(
  (ref) {
    return SeriesController(
      const MediaState(),
      ref.read(baseSeriesServiceProvider),
    );
  },
);

class SeriesController extends StateNotifier<MediaState> {
  late final BaseSeriesService _seriesService;

  SeriesController(MediaState state, this._seriesService) : super(state) {
    Utils.logPrint(message: 'Building $runtimeType');

    getGenres();
    getPopular();
    getTrending();
    getTopRated();
  }

  Future<void> getPopular({int page = 1}) async {
    state = state.copyWith(popular: const AsyncLoading());

    final result = await _seriesService.getPopular();

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

    final result = await _seriesService.getTopRated();

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

    final result = await _seriesService.getTrending();

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

  Future<void> getGenres() async {
    state = state.copyWith(genres: const AsyncLoading());

    final result = await _seriesService.getGenres();

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
