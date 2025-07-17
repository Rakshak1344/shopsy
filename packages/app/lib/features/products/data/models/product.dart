import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'product.freezed.dart';

part 'product.g.dart';

@freezed
class Product extends HiveObject with _$Product {
  Product._();

  @HiveType(typeId: 0, adapterName: 'ProductAdapter')
  factory Product({
    @HiveField(0) required int id,
    @HiveField(1) required String name,
    @HiveField(2) required String description,
    @HiveField(3) required String imageUrl,
    @HiveField(4) required int availableQuantity,
    @HiveField(5) required double price,
  }) = _Product;

  factory Product.fromJson(Map<String, Object?> json) =>
      _$ProductFromJson(json);
}
