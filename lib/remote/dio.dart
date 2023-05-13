import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'environment_variables.dart';

final dioProvider = Provider<Dio>(
  (ref) {
    return Dio(
      BaseOptions(
        baseUrl: RemoteEnvironment.baseUrl,
        headers: {'Authorization': 'Bearer ${RemoteEnvironment.v4AuthKey}'},
      ),
    );
  },
);
