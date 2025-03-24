import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'secure_storage_keys.dart';

class SecureStorageHelper {
  static const _storage = FlutterSecureStorage();

  static Future<void> storeToken({String? accessToken}) async {
    if (accessToken != null) {
      await _storage.write(
          key: SecureStorageKeys.accessTokenKey, value: accessToken);
    }
  }

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: SecureStorageKeys.accessTokenKey);
  }

  static Future<void> deleteAccessToken() async {
    await _storage.delete(key: SecureStorageKeys.accessTokenKey);
  }
}
