import 'package:clients/core/networking/dio_factory.dart';
import 'package:clients/core/utils/shared_preferences/shared_preferences_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> initDI() async {
  // Shared Preferences
  sl.registerLazySingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());
  sl.registerLazySingleton<SharedPreferencesHelper>(
      () => SharedPreferencesHelper(sl()));

  // Dio
  sl.registerLazySingleton(() => DioFactory.getDio());
}
