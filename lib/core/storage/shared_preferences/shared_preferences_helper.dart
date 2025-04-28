import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_keys.dart';

class SharedPreferencesHelper {
  final SharedPreferences _sharedPreferences;
  const SharedPreferencesHelper(this._sharedPreferences);

  Future<T> get<T>(String key) async {
    return _sharedPreferences.get(key) as T;
  }

  Future<void> set(String key, dynamic value) async {
    switch (value) {
      case int():
        await _sharedPreferences.setInt(key, value);
      case double():
        await _sharedPreferences.setDouble(key, value);
      case bool():
        await _sharedPreferences.setBool(key, value);
      case String():
        await _sharedPreferences.setString(key, value);
      default:
        throw Exception('Type not supported');
    }
  }

  Future<bool> delete(String key) async {
    return await _sharedPreferences.remove(key);
  }

  Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }
}
