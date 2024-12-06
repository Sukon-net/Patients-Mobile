import 'package:clients/app.dart';
import 'package:clients/core/di/dependency_container.dart';
import 'package:clients/core/theme/cubit/theme_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();
  await EasyLocalization.ensureInitialized();

  final ThemeCubit themeCubit = ThemeCubit(sl());
  await themeCubit.loadTheme();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: AppContainer(
        themeCubit: themeCubit,
      ),
    ),
  );
}

class AppContainer extends StatelessWidget {
  final ThemeCubit themeCubit;
  const AppContainer({super.key, required this.themeCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: themeCubit,
      child: const MyApp(),
    );
  }
}
