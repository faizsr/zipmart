import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zipmart/src/features/auth/auth_injections.dart';
import 'package:zipmart/src/features/dashboard/dashboard_injections.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  final dio = Dio();
  final sf = await SharedPreferences.getInstance();

  // Variables
  sl.registerLazySingleton<Dio>(() => dio);
  sl.registerLazySingleton<SharedPreferences>(() => sf);

  initAuthInjections();
  initDashboardInjections();
}
