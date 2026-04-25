import 'package:zipmart/src/core/network/network_response.dart';
import 'package:zipmart/src/features/dashboard/domain/entities/product_entity.dart';

abstract class DashboardRepository {
  Future<NetworkResponse<List<ProductEntity>>> fetchProducts();
  Future<NetworkResponse<List<String>>> fetchCategories();
}
