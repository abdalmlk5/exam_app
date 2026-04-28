import 'package:dio/dio.dart';
import 'package:exam_app/config/cache/cache_helper.dart';
import 'package:exam_app/core/utils/app_keys.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthInterceptor extends Interceptor {
  final CacheHelper cache;

  AuthInterceptor(this.cache);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await cache.readData(key: AppKeys.tokenKey);

    if (token != null) {
      options.headers['token'] = token;
    }

    handler.next(options);
  }
}
