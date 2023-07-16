import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/data/dio.dart';
import '../../../../shared/data/environment_variables.dart';
import '../../../../shared/domain/failure.dart';

abstract class BaseMoviesRepository {
  Future<Map<String, dynamic>> getPopular();

  Future<Map<String, dynamic>> getTopRated();

  Future<Map<String, dynamic>> getTrending();

  Future<Map<String, dynamic>> getNowPlaying();

  Future<Map<String, dynamic>> getUpcoming();

  Future<Map<String, dynamic>> getGenres();
}

final baseMoviesRepositoryProvider = Provider<BaseMoviesRepository>((ref) {
  return MoviesRepository(ref.watch(dioProvider));
});

class MoviesRepository implements BaseMoviesRepository {
  MoviesRepository(this._dio);

  final Dio _dio;

  @override
  Future<Map<String, dynamic>> getGenres() async {
    try {
      final result = await _dio.get(RemoteEnvironment.movieGenres);

      final Map<String, dynamic> json = result.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getPopular() async {
    try {
      final result = await _dio.get(RemoteEnvironment.popularMovies);

      final Map<String, dynamic> json = result.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getTopRated() async {
    try {
      final result = await _dio.get(RemoteEnvironment.topRatedMovies);

      final Map<String, dynamic> json = result.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getTrending() async {
    try {
      final result = await _dio.get(RemoteEnvironment.trendingMovies);

      final Map<String, dynamic> json = result.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getUpcoming() async {
    try {
      final result = await _dio.get(RemoteEnvironment.upcomingMovies);

      final Map<String, dynamic> json = result.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getNowPlaying() async {
    try {
      final result = await _dio.get(RemoteEnvironment.nowPlayingMovies);

      final Map<String, dynamic> json = result.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }
}
