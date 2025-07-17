import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'cart_item.freezed.dart';

part 'cart_item.g.dart';

@freezed
class CartItem extends HiveObject with _$CartItem {
  CartItem._();

  @HiveType(typeId: 1, adapterName: 'CartItemAdapter')
  factory CartItem({
    @HiveField(0) required int productId,
    @HiveField(1) required int quantity,
    @HiveField(2) required DateTime createdAt,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, Object?> json) =>
      _$CartItemFromJson(json);
}
