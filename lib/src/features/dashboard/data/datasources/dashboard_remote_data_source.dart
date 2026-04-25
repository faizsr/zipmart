import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:zipmart/src/core/network/network_constants.dart';
import 'package:zipmart/src/core/network/network_response.dart';
import 'package:zipmart/src/features/dashboard/data/models/product_model.dart';

class DashboardRemoteDataSource {
  final Dio dio;

  DashboardRemoteDataSource({required this.dio});

  Future<NetworkResponse<List<ProductModel>>> fetchProducts() async {
    final url = '${NetworkConstants.baseUrl}/products';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data as List;
        final products = data.map((e) => ProductModel.fromJson(e)).toList();
        return NetworkResponse(
          type: NetworkResponseType.success,
          data: products,
        );
      }
    } on DioException catch (e) {
      log(
        'Dio exception on fetching products: ${e.response?.statusCode} ${e.response?.data}',
      );
    } catch (e) {
      log('Exception in fetching products: $e');
    }

    return NetworkResponse(type: NetworkResponseType.error, data: []);
  }

  Future<NetworkResponse<List<String>>> fetchCategories() async {
    final url = '${NetworkConstants.baseUrl}/products/categories';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data as List;
        final categories = data.map((e) => e.toString()).toList();
        return NetworkResponse(
          type: NetworkResponseType.success,
          data: categories,
        );
      }
    } on DioException catch (e) {
      log(
        'Dio exception on fetching categories: ${e.response?.statusCode} ${e.response?.data}',
      );
    } catch (e) {
      log('Exception in fetching categories: $e');
    }

    return NetworkResponse(type: NetworkResponseType.error, data: []);
  }
}
