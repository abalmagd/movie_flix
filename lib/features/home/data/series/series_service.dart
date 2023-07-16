import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/domain/failure.dart';
import '../../domain/genre.dart';
import '../../domain/media.dart';
import 'series_repository.dart';

abstract class BaseSeriesService {
  Future<Either<Failure, List<Media>>> getPopular();

  Future<Either<Failure, List<Media>>> getTopRated();

  Future<Either<Failure, List<Media>>> getTrending();

  Future<Either<Failure, List<Genre>>> getGenres();
}

final baseSeriesServiceProvider = Provider<BaseSeriesService>((ref) {
  return SeriesService(ref.watch(baseSeriesRepositoryProvider));
});

class SeriesService implements BaseSeriesService {
  SeriesService(this._baseSeriesRepository);

  final BaseSeriesRepository _baseSeriesRepository;

  @override
  Future<Either<Failure, List<Genre>>> getGenres() async {
    try {
      final json = await _baseSeriesRepository.getGenres();

      final results = json['genres'] as List;

      final genres = results.map((e) => Genre.fromJson(e)).toList();

      return Right(genres);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<Media>>> getPopular() async {
    try {
      final json = await _baseSeriesRepository.getPopular();

      final results = List<Map<String, dynamic>>.from(json['results']);

      final movies = results.map((e) => Media.fromJson(e)).toList();

      return Right(movies);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<Media>>> getTopRated() async {
    try {
      final json = await _baseSeriesRepository.getTopRated();

      final results = List<Map<String, dynamic>>.from(json['results']);

      final movies = results.map((e) => Media.fromJson(e)).toList();

      return Right(movies);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<Media>>> getTrending() async {
    try {
      final json = await _baseSeriesRepository.getTrending();

      final results = List<Map<String, dynamic>>.from(json['results']);

      final movies = results.map((e) => Media.fromJson(e)).toList();

      return Right(movies);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
