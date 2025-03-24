import 'package:clients/app.dart';
import 'package:clients/core/di/dependency_container.dart';
import 'package:clients/core/flavors/flavor_config.dart';
import 'package:clients/core/theme/cubit/theme_cubit.dart';
import 'package:clients/core/utils/my_bloc_observer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../features/auth/model/authed_user/logic/auth_cubit.dart';

void mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();
  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await dotenv.load(fileName: ".env");

  final ThemeCubit themeCubit = ThemeCubit(sl());
  await themeCubit.loadTheme();

  if (FlavorConfig.isDevelopment()) {
    Bloc.observer = MyBlocObserver();
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/strings',
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
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: sl<AuthCubit>()),
          BlocProvider.value(value: themeCubit),
        ],
        child: const MyApp(),
      ),
    );
  }
}
