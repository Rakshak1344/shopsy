import 'package:app/features/cart/data/models/cart_item.dart';
import 'package:app/features/cart/services/cart_item_service.dart';
import 'package:app/features/products/views/widgets/product_counter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_item_state.g.dart';

@Riverpod(keepAlive: true)
class CartItemState extends _$CartItemState {
  CartItemService get _cartItemService => ref.read(cartItemServiceProvider);

  @override
  Stream<List<CartItem>> build() {
    return ref.watch(cartItemServiceProvider).watch();
  }

  Future<void> updateCartItem(
    int productId,
    CounterAction counterAction,
  ) async {
    try {
      await _cartItemService.updateCart(productId, counterAction);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
