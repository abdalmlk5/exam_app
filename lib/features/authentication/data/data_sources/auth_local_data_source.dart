abstract interface class AuthLocalDataSourceContract {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();

  Future<void> saveRememberMe(bool value);
  Future<bool> getRememberMe();
  Future<void> deleteRememberMe();
}
