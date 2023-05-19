import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'environment_variables.dart';

final dioProvider = Provider<Dio>(
  (ref) {
    return Dio(
      BaseOptions(
        baseUrl: RemoteEnvironment.baseUrl,
        queryParameters: {
          'api_key': RemoteEnvironment.apiKeyV3,
          'language': 'en-US',
        },
        headers: {
          'Authorization': 'Bearer ${RemoteEnvironment.apiKeyV4}',
          'accept': 'application/json',
        },
      ),
    );
  },
);
