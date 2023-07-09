import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/data/dio.dart';
import '../../../shared/data/environment_variables.dart';
import '../../../shared/domain/failure.dart';

abstract class BaseHomeRepository {
  Future<Map<String, dynamic>> getPopularMovies();

  Future<Map<String, dynamic>> getTopRatedMovies();

  Future<Map<String, dynamic>> getTrendingMovies();

  Future<Map<String, dynamic>> getNowPlayingMovies();

  Future<Map<String, dynamic>> getUpcomingMovies();

  Future<Map<String, dynamic>> getMovieGenres();
}

final baseHomeRepositoryProvider = Provider<BaseHomeRepository>((ref) {
  return HomeRepository(ref.watch(dioProvider));
});

class HomeRepository implements BaseHomeRepository {
  HomeRepository(this._dio);

  final Dio _dio;

  @override
  Future<Map<String, dynamic>> getMovieGenres() async {
    try {
      final result = await _dio.get(RemoteEnvironment.movieGenres);

      final Map<String, dynamic> json = result.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getPopularMovies() async {
    try {
      final result = await _dio.get(RemoteEnvironment.popularMovies);

      final Map<String, dynamic> json = result.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getTopRatedMovies() async {
    try {
      final result = await _dio.get(RemoteEnvironment.topRatedMovies);

      final Map<String, dynamic> json = result.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getTrendingMovies() async {
    try {
      final result = await _dio.get(RemoteEnvironment.trendingMovies);

      final Map<String, dynamic> json = result.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getUpcomingMovies() async {
    try {
      final result = await _dio.get(RemoteEnvironment.upcomingMovies);

      final Map<String, dynamic> json = result.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getNowPlayingMovies() async {
    try {
      final result = await _dio.get(RemoteEnvironment.nowPlayingMovies);

      final Map<String, dynamic> json = result.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }
}
