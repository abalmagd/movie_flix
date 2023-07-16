import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/domain/failure.dart';
import '../../domain/genre.dart';
import '../../domain/media.dart';
import 'movies_repository.dart';

abstract class BaseMoviesService {
  Future<Either<Failure, List<Media>>> getPopular();

  Future<Either<Failure, List<Media>>> getTopRated();

  Future<Either<Failure, List<Media>>> getTrending();

  Future<Either<Failure, List<Media>>> getNowPlaying();

  Future<Either<Failure, List<Media>>> getUpcoming();

  Future<Either<Failure, List<Genre>>> getGenres();
}

final baseMoviesServiceProvider = Provider<BaseMoviesService>((ref) {
  return MoviesService(ref.watch(baseMoviesRepositoryProvider));
});

class MoviesService implements BaseMoviesService {
  MoviesService(this._baseMoviesRepository);

  final BaseMoviesRepository _baseMoviesRepository;

  @override
  Future<Either<Failure, List<Genre>>> getGenres() async {
    try {
      final json = await _baseMoviesRepository.getGenres();

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
      final json = await _baseMoviesRepository.getPopular();

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
      final json = await _baseMoviesRepository.getTopRated();

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
      final json = await _baseMoviesRepository.getTrending();

      final results = List<Map<String, dynamic>>.from(json['results']);

      final movies = results.map((e) => Media.fromJson(e)).toList();

      return Right(movies);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<Media>>> getNowPlaying() async {
    try {
      final json = await _baseMoviesRepository.getNowPlaying();

      final results = List<Map<String, dynamic>>.from(json['results']);

      final movies = results.map((e) => Media.fromJson(e)).toList();

      return Right(movies);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<Media>>> getUpcoming() async {
    try {
      final json = await _baseMoviesRepository.getUpcoming();

      final results = List<Map<String, dynamic>>.from(json['results']);

      final movies = results.map((e) => Media.fromJson(e)).toList();

      return Right(movies);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
