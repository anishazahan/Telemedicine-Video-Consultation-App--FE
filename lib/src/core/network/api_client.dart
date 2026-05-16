import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/app_config.dart';
import '../storage/token_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final storage = ref.watch(tokenStorageProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Accept': 'application/json'},
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await storage.readAccessToken();
        if (token != null) options.headers['Authorization'] = 'Bearer $token';
        handler.next(options);
      },
      onError: (error, handler) async {
        final isRefreshCall = error.requestOptions.path.contains('/auth/refresh-token');
        if (error.response?.statusCode != 401 || isRefreshCall) return handler.next(error);

        final refreshToken = await storage.readRefreshToken();
        if (refreshToken == null) return handler.next(error);

        try {
          final refreshResponse = await Dio(BaseOptions(baseUrl: AppConfig.apiBaseUrl)).post(
            '/auth/refresh-token',
            data: {'refreshToken': refreshToken},
          );
          final data = refreshResponse.data is Map ? refreshResponse.data['data'] : null;
          final tokens = data is Map ? data['tokens'] : null;
          final access = tokens is Map ? tokens['accessToken']?.toString() : null;
          final refresh = tokens is Map ? tokens['refreshToken']?.toString() : null;
          if (access == null || refresh == null) return handler.next(error);

          await storage.save(accessToken: access, refreshToken: refresh);
          final retryOptions = error.requestOptions;
          retryOptions.headers['Authorization'] = 'Bearer $access';
          final retryResponse = await dio.fetch(retryOptions);
          return handler.resolve(retryResponse);
        } catch (_) {
          await storage.clear();
          return handler.next(error);
        }
      },
    ),
  );

  return dio;
});
