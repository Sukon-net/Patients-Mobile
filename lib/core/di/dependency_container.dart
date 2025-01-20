import 'package:clients/core/networking/dio_factory.dart';
import 'package:clients/core/utils/shared_preferences/shared_preferences_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> initDI() async {
  // Shared Preferences
  final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferencesHelper>(
          () => SharedPreferencesHelper(_sharedPreferences));

  // Dio
  sl.registerLazySingleton(() => DioFactory.getDio(););
}