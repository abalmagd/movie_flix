import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/features/details/data/media_details_repository.dart';

abstract class BaseMediaDetailsService {}

final baseMediaDetailsServiceProvider = Provider<BaseMediaDetailsService>(
  (ref) {
    return MoviesService(ref.watch(baseMediaDetailsRepositoryProvider));
  },
);

class MoviesService implements BaseMediaDetailsService {
  MoviesService(this._baseMoviesRepository);

  final BaseMediaDetailsRepository _baseMoviesRepository;
}
