import 'package:clients/core/networking/dio_factory.dart';
import 'package:clients/features/auth/OTP/data/datasource/otp_service.dart';
import 'package:clients/features/auth/OTP/data/repository/otp_repository.dart';
import 'package:clients/features/auth/complete%20profile/data/repository/complete_profile_repository.dart';
import 'package:clients/features/auth/complete%20profile/data/service/complete_profile_service.dart';
import 'package:clients/features/auth/login/data/datasource/login_service.dart';
import 'package:clients/features/auth/login/data/repository/login_repository.dart';
import 'package:clients/features/auth/data/datasource/auth_service.dart';
import 'package:clients/features/auth/data/repository/auth_repository.dart';
import 'package:clients/features/book_session/data/datasource/book_session_service.dart';
import 'package:clients/features/book_session/data/repository/book_session_repo.dart';
import 'package:clients/features/home/data/datasource/home_service.dart';
import 'package:clients/features/home/data/repository/home_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/logic/auth_cubit.dart';
import '../../features/doctor_info/data/datasource/doctor_info_service.dart';
import '../../features/doctor_info/data/repository/doctor_info_repository.dart';
import '../../features/specializations_filter/data/datasource/specializations_filter_service.dart';
import '../../features/specializations_filter/data/repository/specializations_filter_repo.dart';
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
  sl.registerLazySingleton<AuthServices>(() => AuthServices(sl()));
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

  //Home -> Specializations
  sl.registerLazySingleton(() => HomeService(dio: sl()));
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(homeService: sl()));

  //DoctorInfo
  sl.registerLazySingleton(() => DoctorInfoService(dio: sl()));
  sl.registerLazySingleton<DoctorInfoRepository>(
      () => DoctorInfoRepositoryImpl(doctorInfoService: sl()));

  //SpecializationsFilter
  sl.registerLazySingleton(() => SpecializationsFilterService(dio: sl()));
  sl.registerLazySingleton<SpecializationsFilterRepo>(
      () => SpecializationsFilterRepoImpl(service: sl()));

  //BookSession
  sl.registerLazySingleton(() => BookSessionService(dio: sl()));
  sl.registerLazySingleton<BookSessionRepoImpl>(
      () => BookSessionRepoImpl(service: sl()));

  //Complete Profile
  sl.registerLazySingleton(() => CompleteProfileService(sl()));
  sl.registerLazySingleton<CompleteProfileRepository>(
      () => CompleteProfileRepositoryImpl(completeProfileService: sl()));
}
