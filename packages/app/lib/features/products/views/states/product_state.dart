import 'package:app/features/products/data/models/product.dart';
import 'package:app/features/products/services/product_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_state.g.dart';

@Riverpod(keepAlive: true)
class ProductState extends _$ProductState {
  ProductService get _productService => ref.read(productServiceProvider);

  @override
  Stream<List<Product>> build() {
    return ref.watch(productServiceProvider).watch();
  }

  Future<void> fetchProducts([int page = 1]) async {
    try {
      return await _productService.getProducts(page);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> removeCachedProducts()async {
    try {
      state = const AsyncLoading();
      await _productService.deleteAll();
      state = const AsyncData([]);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
