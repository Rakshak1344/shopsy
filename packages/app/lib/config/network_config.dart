import 'package:app/config/env.dart';
import 'package:app/config/pretty_logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_config.g.dart';

@riverpod
Dio dio(Ref ref) {
  var appUrl = Env.baseUrl;

  var dio = Dio(
    BaseOptions(baseUrl: appUrl, headers: {"Accept": "application/json"}),
  );

  dio.interceptors.addAll([
    // ref.read(authInterceptorProvider),
    if (!kReleaseMode) ...debugInterceptors(ref),
  ]);

  return dio;
}

List<Interceptor> debugInterceptors(Ref ref) {
  return [ref.read(prettyDioLoggerProvider)];
}
