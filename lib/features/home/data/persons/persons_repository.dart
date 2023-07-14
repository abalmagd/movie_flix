import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/data/dio.dart';
import '../../../../shared/data/environment_variables.dart';
import '../../../../shared/domain/failure.dart';

abstract class BasePersonsRepository {
  Future<Map<String, dynamic>> getPopular();

  Future<Map<String, dynamic>> getTrending();

  Future<Map<String, dynamic>> getPersonDetails({required int personId});
}

final basePersonsRepositoryProvider = Provider<BasePersonsRepository>((ref) {
  return PersonsRepository(ref.watch(dioProvider));
});

class PersonsRepository implements BasePersonsRepository {
  PersonsRepository(this._dio);

  final Dio _dio;

  @override
  Future<Map<String, dynamic>> getPopular() async {
    try {
      final result = await _dio.get(RemoteEnvironment.popularPersons);

      final Map<String, dynamic> json = result.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getPersonDetails({required int personId}) async {
    try {
      final result = await _dio.get(
        '${RemoteEnvironment.person}/$personId',
        queryParameters: {
          'append_to_response': 'images',
        },
      );

      final Map<String, dynamic> json = result.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getTrending() async {
    try {
      final result = await _dio.get('${RemoteEnvironment.trendingPersons}/day');

      final Map<String, dynamic> json = result.data;
      return json;
    } on DioError catch (e) {
      throw Failure.handleExceptions(e);
    }
  }
}
