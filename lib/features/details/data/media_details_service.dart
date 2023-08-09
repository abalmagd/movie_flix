import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/features/details/data/media_details_repository.dart';
import 'package:movie_flix/features/details/domain/media_details.dart';

import '../../../shared/domain/failure.dart';

abstract class BaseMediaDetailsService {
  Future<Either<Failure, MediaDetails>> getMovieDetails({required int movieId});
}

final baseMediaDetailsServiceProvider = Provider<BaseMediaDetailsService>(
  (ref) {
    return MoviesService(ref.watch(baseMediaDetailsRepositoryProvider));
  },
);

class MoviesService implements BaseMediaDetailsService {
  MoviesService(this._baseMediaDetailsRepository);

  final BaseMediaDetailsRepository _baseMediaDetailsRepository;

  @override
  Future<Either<Failure, MediaDetails>> getMovieDetails(
      {required int movieId}) async {
    try {
      final json = await _baseMediaDetailsRepository.getMovieDetails(movieId);

      final results = json;

      results.addEntries([
        const MapEntry('cast', []),
      ]);

      final details = MediaDetails.fromJson(results);

      return Right(details);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
