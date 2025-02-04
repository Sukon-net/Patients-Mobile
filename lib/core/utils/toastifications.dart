import 'package:clients/core/utils/extensions/num_duration_extensions.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Toastifications {
  const Toastifications._();

  static void show({
    required BuildContext context,
    required String message,
    required Color textColor,
    required Color borderColor,
    required Color backgroundColor,
    ToastificationType type = ToastificationType.error,
  }) {
    toastification.show(
      context: context,
      title: Text(
        message,
        style: TextStyle(
          color: textColor,
        ),
      ),
      style: ToastificationStyle.flatColored,
      type: type,
      closeOnClick: true,
      dragToClose: true,
      autoCloseDuration: 3.seconds,
      borderSide: BorderSide(color: borderColor),
      backgroundColor: backgroundColor,
      closeButtonShowType: CloseButtonShowType.none,
    );
  }
}
