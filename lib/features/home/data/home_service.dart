import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/domain/failure.dart';
import '../../../shared/domain/movie.dart';
import '../domain/genre.dart';
import 'home_repository.dart';

abstract class BaseHomeService {
  Future<Either<Failure, List<Movie>>> getPopularMovies();

  Future<Either<Failure, List<Movie>>> getTopRatedMovies();

  Future<Either<Failure, List<Movie>>> getTrendingMovies();

  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();

  Future<Either<Failure, List<Movie>>> getUpcomingMovies();

  Future<Either<Failure, List<Genre>>> getMovieGenres();
}

final baseHomeServiceProvider = Provider<BaseHomeService>((ref) {
  return HomeService(ref.watch(baseHomeRepositoryProvider));
});

class HomeService implements BaseHomeService {
  HomeService(this._baseHomeRepository);

  final BaseHomeRepository _baseHomeRepository;

  @override
  Future<Either<Failure, List<Genre>>> getMovieGenres() async {
    try {
      final json = await _baseHomeRepository.getMovieGenres();

      final results = json['genres'] as List;

      final genres = results.map((e) => Genre.fromJson(e)).toList();

      return Right(genres);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    try {
      final json = await _baseHomeRepository.getPopularMovies();

      final results = List<Map<String, dynamic>>.from(json['results']);

      final movies = results.map((e) => Movie.fromJson(e)).toList();

      return Right(movies);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    try {
      final json = await _baseHomeRepository.getTopRatedMovies();

      final results = List<Map<String, dynamic>>.from(json['results']);

      final movies = results.map((e) => Movie.fromJson(e)).toList();

      return Right(movies);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTrendingMovies() async {
    try {
      final json = await _baseHomeRepository.getTrendingMovies();

      final results = List<Map<String, dynamic>>.from(json['results']);

      final movies = results.map((e) => Movie.fromJson(e)).toList();

      return Right(movies);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    try {
      final json = await _baseHomeRepository.getNowPlayingMovies();

      final results = List<Map<String, dynamic>>.from(json['results']);

      final movies = results.map((e) => Movie.fromJson(e)).toList();

      return Right(movies);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getUpcomingMovies() async {
    try {
      final json = await _baseHomeRepository.getUpcomingMovies();

      final results = List<Map<String, dynamic>>.from(json['results']);

      final movies = results.map((e) => Movie.fromJson(e)).toList();

      return Right(movies);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
