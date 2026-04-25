import 'package:zipmart/src/features/dashboard/domain/entities/product_entity.dart';

class CartEntity {
  final int quantity;
  final ProductEntity product;

  CartEntity({required this.quantity, required this.product});
}
