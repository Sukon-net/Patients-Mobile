import 'dart:convert';

import 'package:clients/core/storage/secure_storage/secure_storage_helper.dart';
import 'package:clients/core/storage/shared_preferences/shared_preferences_helper.dart';
import 'package:clients/features/auth/data/datasource/auth_service.dart';
import 'package:clients/features/auth/model/authed_user/authed_user.dart';
import 'package:clients/features/model/user.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class AuthRepository {
  Future<void> storeUser(AuthedUser authedUser);
  Future<void> updateUser(User user);
  Future<User?> getUser();
  Future<bool> isAuthenticated();
  Future<void> logout();
  Future<void> fetchAndCacheUser();
}

class AuthRepositoryImpl extends AuthRepository {
  final SharedPreferencesHelper _sharedPreferencesHelper;
  final AuthServices _authServices;

  AuthRepositoryImpl(this._sharedPreferencesHelper, this._authServices);

  @override
  Future<AuthedUser> storeUser(AuthedUser authedUser) async {
    await SecureStorageHelper.storeToken(accessToken: authedUser.token);
    await _sharedPreferencesHelper.set(
      SharedPreferencesKeys.authedUser,
      jsonEncode(authedUser.user.toJson()),
    );
    return authedUser;
  }

  @override
  Future<void> updateUser(User user) async {
    await _sharedPreferencesHelper.set(
      SharedPreferencesKeys.authedUser,
      jsonEncode(user.toJson()),
    );
  }

  @override
  Future<User?> getUser() async {
    final user = await _authServices.getUser();
    return user.fold(
      (backendUser) async {
        await storeUser(backendUser);
        return backendUser.user;
      },
      (_) async {
        final cachedUser = await _sharedPreferencesHelper
            .get(SharedPreferencesKeys.authedUser);
        if (cachedUser != null) {
          return User.fromJson(jsonDecode(cachedUser));
        }
        return null;
      },
    );
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await SecureStorageHelper.getAccessToken();
    if (token == null) {
      return false;
    }
    return true;
  }

  @override
  Future<void> logout() async {
    await _sharedPreferencesHelper.delete(SharedPreferencesKeys.authedUser);
    await SecureStorageHelper.deleteAccessToken();
  }

  @override
  Future<void> fetchAndCacheUser() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      final response = await _authServices.getUser();
      return response.fold(
        (user) => storeUser(user),
        (error) => error,
      );
    }
  }
}
