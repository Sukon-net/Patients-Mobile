import 'package:bloc/bloc.dart';
import 'package:clients/core/theme/app_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../storage/shared_preferences/shared_preferences_helper.dart';
import '../../storage/shared_preferences/shared_preferences_keys.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferencesHelper _sharedPreferencesHelper;

  ThemeCubit(this._sharedPreferencesHelper)
      : super(const ThemeState(AppTheme(isDarkTheme: false)));

  bool get isPhoneDark =>
      PlatformDispatcher.instance.platformBrightness == Brightness.dark;

  Future<void> loadTheme() async {
    final isDarkTheme = await _sharedPreferencesHelper
        .get<bool?>(SharedPreferencesKeys.isDarkTheme);
    if (isDarkTheme == null) {
      _registerThemeListener();
    }
    emit(
      state.copyWith(
        appTheme: AppTheme(isDarkTheme: isDarkTheme ?? isPhoneDark),
      ),
    );
  }

  void toggleTheme() async {
    final isDarkTheme = !state.appTheme.isDarkTheme;
    await _sharedPreferencesHelper.set(
      SharedPreferencesKeys.isDarkTheme,
      isDarkTheme,
    );
    _unregisterThemeListener();
    emit(
      state.copyWith(
        appTheme: AppTheme(isDarkTheme: isDarkTheme),
      ),
    );
  }

  void resetTheme() {
    _sharedPreferencesHelper.delete(SharedPreferencesKeys.isDarkTheme);
    _registerThemeListener();
    emit(
      state.copyWith(
        appTheme: AppTheme(
          isDarkTheme: isPhoneDark,
        ),
      ),
    );
  }

  void _registerThemeListener() {
    PlatformDispatcher.instance.onPlatformBrightnessChanged = () {
      emit(
        state.copyWith(
          appTheme: AppTheme(isDarkTheme: isPhoneDark),
        ),
      );
    };
  }

  void _unregisterThemeListener() {
    PlatformDispatcher.instance.onPlatformBrightnessChanged = null;
  }
}
