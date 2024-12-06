import 'package:clients/core/theme/app_colors.dart';
import 'package:clients/core/theme/app_theme.dart';
import 'package:clients/core/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ContextThemeExtensions on BuildContext {
  AppTheme get theme => watch<ThemeCubit>().state.appTheme;

  AppColors get colors => theme.appColors;

  bool get isDarkTheme => theme.isDarkTheme;

  void toggleTheme() => read<ThemeCubit>().toggleTheme();

  void resetTheme() => read<ThemeCubit>().resetTheme();
}