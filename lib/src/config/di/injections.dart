import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zipmart/src/features/auth/auth_injections.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  final sf = await SharedPreferences.getInstance();

  // Variables
  sl.registerLazySingleton<SharedPreferences>(() => sf);

  initAuthInjections();
}
