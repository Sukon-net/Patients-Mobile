import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> initDI() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

}