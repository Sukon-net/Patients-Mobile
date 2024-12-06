import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget opacity(double opacity) {
    return Opacity(
      opacity: opacity,
      child: this,
    );
  }
}
