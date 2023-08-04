import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/data/dio.dart';

abstract class BaseMediaDetailsRepository {}

final baseMediaDetailsRepositoryProvider =
    Provider<BaseMediaDetailsRepository>((ref) {
  return MoviesRepository(ref.watch(dioProvider));
});

class MoviesRepository implements BaseMediaDetailsRepository {
  MoviesRepository(this._dio);

  final Dio _dio;
}
