import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/data/dio.dart';
import '../../../../shared/data/environment_variables.dart';
import '../../../../shared/domain/failure.dart';

abstract class BaseSeriesRepository {
  Future<Map<String, dynamic>> getPopular();

  Future<Map<String, dynamic>> getTopRated();

  Future<Map<String, dynamic>> getTrending();

  Future<Map<String, dynamic>> getGenres();
}

final baseSeriesRepositoryProvider = Provider<BaseSeriesRepository>((ref) {
  return SeriesRepository(ref.watch(dioProvider));
});

class SeriesRepository implements BaseSeriesRepository {
  SeriesRepository(this._dio);

  final Dio _dio;

  @override
  Future<Map<String, dynamic>> getGenres() async {
    try {
      final result = await _dio.get(RemoteEnvironment.seriesGenres);

      final Map<String, dynamic> json = result.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getPopular() async {
    try {
      final result = await _dio.get(
        RemoteEnvironment.discoverSeries,
        queryParameters: {'with_original_language': 'en'},
      );

      final Map<String, dynamic> json = result.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getTopRated() async {
    try {
      final result = await _dio.get(RemoteEnvironment.topRatedSeries);

      final Map<String, dynamic> json = result.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getTrending() async {
    try {
      final result = await _dio.get(RemoteEnvironment.trendingSeries);

      final Map<String, dynamic> json = result.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }
}
