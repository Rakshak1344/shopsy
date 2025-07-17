import 'package:app/features/cart/data/models/cart_item.dart';
import 'package:app/features/cart/views/state/cart_item_state.dart';
import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_item_detail_state.g.dart';

@riverpod
class CartItemDetailState extends _$CartItemDetailState {
  @override
  FutureOr<CartItem?> build(String productId) async {
    return ref.watch(
      cartItemStateProvider.selectAsync((transactionList) {
        return transactionList.firstWhereOrNull(
          (t) => t.productId == int.parse(productId),
        );
      }),
    );
  }
}
