import 'package:app/features/products/data/models/product.dart';
import 'package:app/features/products/views/states/product_state.dart';
import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_detail_state.g.dart';

@riverpod
class ProductDetailState extends _$ProductDetailState {
  @override
  FutureOr<Product?> build(String id) async {
    return ref.watch(
      productStateProvider.selectAsync((transactionList) {
        return transactionList.firstWhereOrNull((t) => t.id == int.parse(id));
      }),
    );
  }
}
