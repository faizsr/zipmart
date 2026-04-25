import 'package:zipmart/src/core/network/network_response.dart';
import 'package:zipmart/src/features/dashboard/domain/entities/product_entity.dart';
import 'package:zipmart/src/features/dashboard/domain/repositories/dashboard_repository.dart';

class FetchProductsUsecase {
  final DashboardRepository dashboardRepository;

  FetchProductsUsecase(this.dashboardRepository);

  Future<NetworkResponse<List<ProductEntity>>> call() async {
    return dashboardRepository.fetchProducts();
  }
}
