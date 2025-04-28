import 'package:clients/core/networking/dio_factory.dart';
import 'package:clients/core/utils/shared_preferences/shared_preferences_helper.dart';
import 'package:clients/features/auth/OTP/data/datasource/otp_service.dart';
import 'package:clients/features/auth/OTP/data/repository/otp_repository.dart';
import 'package:clients/features/auth/logic/auth_cubit.dart';
import 'package:clients/features/auth/login/data/datasource/login_service.dart';
import 'package:clients/features/auth/login/data/repository/login_repository.dart';
import 'package:clients/features/home/data/datasource/doctors_service.dart';
import 'package:clients/features/home/data/datasource/specializations_service.dart';
import 'package:clients/features/home/data/repository/doctors_repository.dart';
import 'package:clients/features/home/data/repository/specializations_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/doctor_info/data/datasource/doctor_info_service.dart';
import '../../features/doctor_info/data/repository/doctor_info_repository.dart';

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
  sl.registerLazySingleton(() => AuthCubit());

  //Login
  sl.registerLazySingleton(() => LoginService(dio: sl()));
  sl.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(loginService: sl()));

  //Otp
  sl.registerLazySingleton(() => OtpService(dio: sl()));
  sl.registerLazySingleton<OtpRepository>(
      () => OtpRepositoryImpl(otpService: sl()));

  //Home -> Doctors
  sl.registerLazySingleton(() => DoctorsService(dio: sl()));
  sl.registerLazySingleton<DoctorsRepository>(
      () => DoctorsRepositoryImpl(doctorsService: sl()));

  //Home -> Specializations
  sl.registerLazySingleton(() => SpecializationsService(dio: sl()));
  sl.registerLazySingleton<SpecializationsRepository>(
      () => SpecializationsRepositoryImpl(specializationsService: sl()));

  //DoctorInfo
  sl.registerLazySingleton(() => DoctorInfoService(dio: sl()));
  sl.registerLazySingleton<DoctorInfoRepository>(
      () => DoctorInfoRepositoryImpl(doctorInfoService: sl()));
}
