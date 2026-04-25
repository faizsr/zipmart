import 'package:zipmart/src/config/di/injections.dart';
import 'package:zipmart/src/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:zipmart/src/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:zipmart/src/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:zipmart/src/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:zipmart/src/features/dashboard/domain/usecases/fetch_categories_usecase.dart';
import 'package:zipmart/src/features/dashboard/domain/usecases/fetch_products_usecase.dart';
import 'package:zipmart/src/features/dashboard/presentation/bloc/dashboard/dashboard_bloc.dart';

Future<void> initDashboardInjections() async {
  // Local Data Source
  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSource(dio: sl()),
  );

  // Repository
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(sl()),
  );

  // Usecase
  sl.registerLazySingleton(() => FetchProductsUsecase(sl()));
  sl.registerLazySingleton(() => FetchCategoriesUsecase(sl()));

  // Controller
  sl.registerFactory(() {
    return DashboardBloc(
      fetchCategoriesUsecase: sl(),
      fetchProductsUsecase: sl(),
    );
  });
  // Controller
  sl.registerFactory(() {
    return CartBloc();
  });
}
