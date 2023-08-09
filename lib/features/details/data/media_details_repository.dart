import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/data/dio.dart';
import '../../../shared/data/environment_variables.dart';
import '../../../shared/domain/failure.dart';

abstract class BaseMediaDetailsRepository {
  Future<Map<String, dynamic>> getMovieDetails(int movieId);

  Future<Map<String, dynamic>> getSeriesDetails(int seriesId);
}

final baseMediaDetailsRepositoryProvider =
    Provider<BaseMediaDetailsRepository>((ref) {
  return MoviesRepository(ref.watch(dioProvider));
});

class MoviesRepository implements BaseMediaDetailsRepository {
  MoviesRepository(this._dio);

  final Dio _dio;

  @override
  Future<Map<String, dynamic>> getMovieDetails(int movieId) async {
    try {
      final result = await _dio.get('${RemoteEnvironment.movie}/$movieId');

      final Map<String, dynamic> json = result.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getSeriesDetails(int seriesId) async {
    try {
      final result = await _dio.get('${RemoteEnvironment.series}/$seriesId');

      final Map<String, dynamic> json = result.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }
}
