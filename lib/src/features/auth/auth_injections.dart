import 'package:zipmart/src/config/di/injections.dart';
import 'package:zipmart/src/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:zipmart/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:zipmart/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:zipmart/src/features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'package:zipmart/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:zipmart/src/features/auth/domain/usecases/logout_usecase.dart';
import 'package:zipmart/src/features/auth/presentation/bloc/bloc/auth_bloc.dart';

Future<void> initAuthInjections() async {
  // Local Data Source
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // Usecase
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  sl.registerLazySingleton(() => CheckAuthStatusUsecase(sl()));

  // Controller
  sl.registerFactory(
    () => AuthBloc(
      loginUsecase: sl(),
      logoutUsecase: sl(),
      checkAuthStatusUsecase: sl(),
    ),
  );
}
