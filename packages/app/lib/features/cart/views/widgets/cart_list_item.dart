import 'package:app/features/cart/data/models/cart_item.dart';
import 'package:app/features/products/views/states/product_detail_state.dart';
import 'package:app/features/products/views/widgets/product_counter.dart';
import 'package:app/features/products/views/widgets/product_image.dart';
import 'package:core/utils/extensions/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartListItem extends ConsumerWidget {
  final CartItem cartItem;

  const CartListItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(
      productDetailStateProvider(cartItem.productId),
    );

    return productAsync.when(
      data: (product) {
        if (product == null) {
          return const ListTile(title: Text('Product not found'));
        }

        final lineItemPrice = product.price * cartItem.quantity;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              ProductImage(imageUrl: product.imageUrl, size: 40),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ProductCounter(product: product),
              const SizedBox(width: 16),
              SizedBox(
                width: 70,
                child: Text(
                  lineItemPrice.formatAsCurrency(),
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        );
      },
      loading:
          () => const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          ),
      error: (e, s) => ListTile(title: Text('Could not load product: $e')),
    );
  }
}
