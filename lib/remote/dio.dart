import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/core/utils.dart';

import 'environment_variables.dart';

final dioProvider = Provider<Dio>(
  (ref) {
    final dio = Dio(
      BaseOptions(
        baseUrl: RemoteEnvironment.baseUrl,
        queryParameters: {'language': 'en-US'},
        headers: {
          'Authorization': 'Bearer ${RemoteEnvironment.apiKeyV4}',
          'accept': 'application/json',
        },
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          Utils.logPrint(
            message: '===>\n'
                'Path: ${options.method} ${options.baseUrl}${options.path}\n'
                'Full URI: ${options.uri}\n'
                'Data: ${options.data}\n'
                'Extra: ${options.extra}\n'
                'Query Params: ${options.queryParameters}\n'
                'Headers: ${options.headers.keys}\n'
                'Response Type: ${options.responseType}',
            name: 'onRequest Interceptor',
          );
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          Utils.logPrint(
            message: '===>\n'
                'URI: ${response.realUri}\n'
                'Status: ${response.statusCode} ${response.statusMessage}\n'
                'Data: ${response.data}\n',
            name: 'onResponse Interceptor',
          );
          return handler.next(response);
        },
        onError: (DioError e, ErrorInterceptorHandler handler) {
          Utils.logPrint(
            message: '===>\n'
                'Type: ${e.type}\n'
                'Message: ${e.message}\n'
                'Data: ${e.error}\n'
                'Response: ${e.response}',
            name: 'onError Interceptor',
          );
          return handler.next(e);
        },
      ),
    );

    return dio;
  },
);
