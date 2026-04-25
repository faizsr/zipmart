import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.title,
    required super.price,
    required super.image,
    required super.ratingRate,
    required super.ratingCount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value) {
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return ProductModel(
      title: json['title'] as String? ?? '',
      price: parseDouble(json['price']),
      image: json['image'] as String? ?? '',
      ratingRate: parseDouble(json['rating']?['rate']),
      ratingCount: json['rating']['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'image': image,
      'rating_rate': ratingRate,
      'rating_count': ratingCount,
    };
  }

  ProductEntity toEntity() {
    return ProductEntity(
      title: title,
      price: price,
      image: image,
      ratingRate: ratingRate,
      ratingCount: ratingCount,
    );
  }
}
