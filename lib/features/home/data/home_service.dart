import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/domain/movie.dart';
import '../../../shared/domain/failure.dart';
import 'home_repository.dart';

abstract class BaseHomeService {
  Future<Either<Failure, List<Movie>>> getPopularMovies();

  Future<Either<Failure, List<Movie>>> getTopRatedMovies();

  Future<Either<Failure, List<Movie>>> getTrendingMovies();

  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();

  Future<Either<Failure, List<Movie>>> getUpcomingMovies();
}

final baseHomeServiceProvider = Provider<BaseHomeService>((ref) {
  return HomeService(ref.watch(baseHomeRepositoryProvider));
});

class HomeService implements BaseHomeService {
  HomeService(this._baseHomeRepository);

  final BaseHomeRepository _baseHomeRepository;

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
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() {
    // TODO: implement getTopRatedMovies
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movie>>> getTrendingMovies() {
    // TODO: implement getTrendingMovies
    throw UnimplementedError();
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
  Future<Either<Failure, List<Movie>>> getUpcomingMovies() {
    // TODO: implement getUpcomingMovies
    throw UnimplementedError();
  }
}
