import 'package:app/features/cart/data/models/cart_item.dart';
import 'package:app/features/products/data/models/product.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProductAdapter());
    Hive.registerAdapter(CartItemAdapter());
  }
}
