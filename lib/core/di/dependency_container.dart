import 'package:clients/core/networking/dio_factory.dart';
import 'package:clients/features/auth/OTP/data/datasource/otp_service.dart';
import 'package:clients/features/auth/OTP/data/repository/otp_repository.dart';
import 'package:clients/features/auth/complete%20profile/data/repository/complete_profile_repository.dart';
import 'package:clients/features/auth/complete%20profile/data/service/complete_profile_service.dart';
import 'package:clients/features/auth/login/data/datasource/login_service.dart';
import 'package:clients/features/auth/login/data/repository/login_repository.dart';
import 'package:clients/features/auth/model/authed_user/data/repository/auth_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/model/authed_user/logic/auth_cubit.dart';
import '../storage/shared_preferences/shared_preferences_helper.dart';

final GetIt sl = GetIt.instance;

Future<void> initDI() async {
  // Shared Preferences
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferencesHelper>(
      () => SharedPreferencesHelper(sharedPreferences));
  // Dio
  sl.registerLazySingleton(() => DioFactory.getDio());

  // Auth
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton(() => AuthCubit(sl()));

  //Login
  sl.registerLazySingleton(() => LoginService(dio: sl()));
  sl.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(loginService: sl()));

  //Otp
  sl.registerLazySingleton(() => OtpService(dio: sl()));
  sl.registerLazySingleton<OtpRepository>(
      () => OtpRepositoryImpl(otpService: sl()));

  //Complete Profile
  sl.registerLazySingleton(() => CompleteProfileService(sl()));
  sl.registerLazySingleton<CompleteProfileRepository>(
      () => CompleteProfileRepositoryImpl(completeProfileService: sl()));
}
