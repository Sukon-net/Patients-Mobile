import 'package:clients/core/networking/dio_factory.dart';
import 'package:clients/core/utils/shared_preferences/shared_preferences_helper.dart';
import 'package:clients/features/auth/OTP/data/datasource/otp_service.dart';
import 'package:clients/features/auth/OTP/data/repository/otp_repository.dart';
import 'package:clients/features/auth/login/data/datasource/login_service.dart';
import 'package:clients/features/auth/login/data/repository/login_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> initDI() async {
  // Shared Preferences
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferencesHelper>(
      () => SharedPreferencesHelper(sharedPreferences));
  // Dio
  sl.registerLazySingleton(() => DioFactory.getDio());

  //Login
  sl.registerLazySingleton(() => LoginService(dio: sl()));
  sl.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(loginService: sl()));

  //Otp
  sl.registerLazySingleton(() => OtpService(dio: sl()));
  sl.registerLazySingleton<OtpRepository>(
      () => OtpRepositoryImpl(otpService: sl()));
}

