import 'package:zipmart/src/core/network/network_response.dart';
import 'package:zipmart/src/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:zipmart/src/features/dashboard/domain/entities/product_entity.dart';
import 'package:zipmart/src/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource dashboardRemoteDataSource;

  DashboardRepositoryImpl(this.dashboardRemoteDataSource);

  @override
  Future<NetworkResponse<List<String>>> fetchCategories() async {
    return await dashboardRemoteDataSource.fetchCategories();
  }

  @override
  Future<NetworkResponse<List<ProductEntity>>> fetchProducts() async {
    final result = await dashboardRemoteDataSource.fetchProducts();
    final products = result.data?.map((e) => e.toEntity()).toList();
    return NetworkResponse(type: result.type, data: products);
  }
}
