import 'package:clients/core/storage/secure_storage/secure_storage_helper.dart';
import 'package:clients/core/storage/shared_preferences/shared_preferences_helper.dart';
import 'package:clients/features/auth/model/authed_user/authed_user.dart';

abstract class AuthRepository {
  Future<AuthedUser> storeUser(AuthedUser authedUser);
  Future<AuthedUser> getUser();
  Future<void> logout();
}

class AuthRepositoryImpl extends AuthRepository {
  final SharedPreferencesHelper _sharedPreferencesHelper;

  AuthRepositoryImpl(this._sharedPreferencesHelper);

  @override
  Future<AuthedUser> storeUser(AuthedUser authedUser) async {
    await SecureStorageHelper.storeToken(accessToken: authedUser.token);
    await _sharedPreferencesHelper.set(
      SharedPreferencesKeys.authedUser,
      authedUser.user.toJson(),
    );
    return authedUser;
  }

  // TODO: May add a function to get the user data from the backend and store 
  // it in the shared preferences use connectivity_plus to decide if the app should update the user data

  @override
  Future<AuthedUser> getUser() async {
    // TODO: Get the user data from the backend
    final user = await _sharedPreferencesHelper.get<Map<String, dynamic>>(
      SharedPreferencesKeys.authedUser,
    );
    return AuthedUser.fromJson(user);
  }

  @override
  Future<void> logout() async {
    await _sharedPreferencesHelper.delete(SharedPreferencesKeys.authedUser);
    await SecureStorageHelper.deleteAccessToken();
  }
}
