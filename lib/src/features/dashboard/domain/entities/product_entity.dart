import 'package:zipmart/src/features/dashboard/data/models/product_model.dart';

class ProductEntity {
  final int id;
  final String title;
  final double price;
  final String image;
  final num ratingRate;
  final int ratingCount;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.ratingRate,
    required this.ratingCount,
  });

  ProductModel toModel() {
    return ProductModel(
      id: id,
      title: title,
      price: price,
      image: image,
      ratingRate: ratingRate,
      ratingCount: ratingCount,
    );
  }
}
