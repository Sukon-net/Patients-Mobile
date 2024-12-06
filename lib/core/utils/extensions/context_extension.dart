import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  void switchLanguage() {
    if (locale == const Locale('ar')) {
      setLocale(const Locale('en'));
      return;
    }
    setLocale(const Locale('ar'));
  }

  void showSnackBar({
    required String message,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 2),
    clearBeforeShow = false,
  }) {
    if (clearBeforeShow) {
      ScaffoldMessenger.of(this).clearSnackBars();
    }
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        action: action,
        duration: duration,
      ),
    );
  }

  double getScreenWidthPercentage(double factor) {
    return MediaQuery.of(this).size.width * factor;
  }

  double getScreenHeightPercentage(double factor) {
    return MediaQuery.of(this).size.height * factor;
  }

  double getScreenWidth() {
    return MediaQuery.of(this).size.width;
  }

  double getScreenHeight() {
    return MediaQuery.of(this).size.height;
  }

  double getStatusBarHeight() => MediaQuery.of(this).padding.top;

  double getBottomBarHeight() => MediaQuery.of(this).padding.bottom;

  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  void showKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }
}
