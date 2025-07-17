import 'package:app/features/cart/data/models/cart_item.dart';
import 'package:app/features/cart/repositories/local_cart_item_repository.dart';
import 'package:app/features/products/views/widgets/product_counter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_item_service.g.dart';

@Riverpod(keepAlive: true)
CartItemService cartItemService(Ref ref) {
  return CartItemService(ref);
}

class CartItemService {
  final Ref ref;
  final LocalCartItemRepository _localCartItemRepository;

  CartItemService(this.ref)
    : _localCartItemRepository = ref.read(localCartItemRepositoryProvider);

  /// Fetches all cart items.
  Stream<List<CartItem>> watch() => _localCartItemRepository.watch();

  /// Adds a cart item to the cart.
  Future<void> updateCart(int productId, CounterAction counterAction) async {
    var cartItem = _localCartItemRepository.getByProductId(productId);
    if (cartItem == null) {
      _localCartItemRepository.saveOne(
        CartItem(productId: productId, quantity: 1),
      );
      return;
    }
    var quantity =
        counterAction.name == CounterAction.increment.name
            ? cartItem.quantity + 1
            : cartItem.quantity - 1;
    var updatedCart = cartItem.copyWith(quantity: quantity);
    if (updatedCart.quantity <= 0) {
      await _localCartItemRepository.delete(updatedCart);
      return;
    }

    await _localCartItemRepository.saveOne(updatedCart);
    return;
  }
}
