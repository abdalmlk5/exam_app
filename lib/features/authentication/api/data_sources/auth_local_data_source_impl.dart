import 'package:exam_app/core/utils/app_keys.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/cache/cache_helper.dart';
import '../../../../config/di/di.dart';
import '../../data/data_sources/auth_local_data_source.dart';

@Injectable(as: AuthLocalDataSourceContract)
class AuthLocalDataSourceImpl implements AuthLocalDataSourceContract {
  final cache = getIt<CacheHelper>();

  @override
  Future<void> saveToken(String token) async {
    await cache.writeData(key: AppKeys.tokenKey, value: token);
  }

  @override
  Future<String?> getToken() async {
    return await cache.readData(key: AppKeys.tokenKey);
  }

  @override
  Future<void> deleteToken() async {
    await cache.deleteData(key: AppKeys.tokenKey);
  }

  @override
  Future<void> saveRememberMe(bool value) async {
    await cache.writeData(key: AppKeys.rememberMeKey, value: value.toString());
  }

  @override
  Future<bool> getRememberMe() async {
    final value = await cache.readData(key: AppKeys.rememberMeKey);
    return value == 'true';
  }

  @override
  Future<void> deleteRememberMe() async {
    await cache.deleteData(key: AppKeys.rememberMeKey);
  }
}
