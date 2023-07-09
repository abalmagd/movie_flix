import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/features/home/data/home_service.dart';
import 'package:movie_flix/utils/utils.dart';

import '../../../../shared/data/local_storage.dart';
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
        movieGenres: AsyncData([]));
  }

  Future<void> getNowPlayingMovies({int page = 1}) async {
    state = state.copyWith(nowPlayingMovies: const AsyncLoading());

    final result = await _homeService.getNowPlayingMovies();

    result.fold(
      (failure) {
        state = state.copyWith(
          nowPlayingMovies: AsyncError(failure, StackTrace.current),
        );
      },
      (list) {
        state = state.copyWith(nowPlayingMovies: AsyncData(list));
      },
    );
  }

  Future<void> getPopularMovies({int page = 1}) async {
    state = state.copyWith(popularMovies: const AsyncLoading());

    final result = await _homeService.getPopularMovies();

    result.fold(
      (failure) {
        state = state.copyWith(
          popularMovies: AsyncError(failure, StackTrace.current),
        );
      },
      (list) {
        state = state.copyWith(popularMovies: AsyncData(list));
      },
    );
  }

  Future<void> getTopRatedMovies({int page = 1}) async {
    state = state.copyWith(topRatedMovies: const AsyncLoading());

    final result = await _homeService.getTopRatedMovies();

    result.fold(
      (failure) {
        state = state.copyWith(
          topRatedMovies: AsyncError(failure, StackTrace.current),
        );
      },
      (list) {
        state = state.copyWith(topRatedMovies: AsyncData(list));
      },
    );
  }

  Future<void> getTrendingMovies({int page = 1}) async {
    state = state.copyWith(trendingMovies: const AsyncLoading());

    final result = await _homeService.getTrendingMovies();

    result.fold(
      (failure) {
        state = state.copyWith(
          trendingMovies: AsyncError(failure, StackTrace.current),
        );
      },
      (list) {
        state = state.copyWith(trendingMovies: AsyncData(list));
      },
    );
  }

  Future<void> getUpcomingMovies({int page = 1}) async {
    state = state.copyWith(upcomingMovies: const AsyncLoading());

    final result = await _homeService.getUpcomingMovies();

    result.fold(
      (failure) {
        state = state.copyWith(
          upcomingMovies: AsyncError(failure, StackTrace.current),
        );
      },
      (list) {
        state = state.copyWith(upcomingMovies: AsyncData(list));
      },
    );
  }

  Future<void> getMovieGenres() async {
    state = state.copyWith(movieGenres: const AsyncLoading());

    final result = await _homeService.getMovieGenres();

    result.fold(
      (failure) {
        state = state.copyWith(
          movieGenres: AsyncError(failure, StackTrace.current),
        );
      },
      (genres) {
        state = state.copyWith(movieGenres: AsyncData(genres));
      },
    );
  }
}
