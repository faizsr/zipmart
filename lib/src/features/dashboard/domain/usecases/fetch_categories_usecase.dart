import 'package:zipmart/src/core/network/network_response.dart';
import 'package:zipmart/src/features/dashboard/domain/repositories/dashboard_repository.dart';

class FetchCategoriesUsecase {
  final DashboardRepository dashboardRepository;

  FetchCategoriesUsecase(this.dashboardRepository);

  Future<NetworkResponse<List<String>>> call() async {
    return dashboardRepository.fetchCategories();
  }
}
