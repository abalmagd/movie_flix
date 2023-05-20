import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dio.dart';

abstract class BaseHomeRepository {}

final baseHomeRepositoryProvider = Provider<BaseHomeRepository>((ref) {
  return HomeRepository(ref.watch(dioProvider));
});

class HomeRepository implements BaseHomeRepository {
  HomeRepository(this._dio);

  final Dio _dio;
}
