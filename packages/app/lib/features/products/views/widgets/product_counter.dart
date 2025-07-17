import 'package:app/features/cart/views/state/cart_item_detail_state.dart';
import 'package:app/features/cart/views/state/cart_item_state.dart';
import 'package:app/features/products/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CounterAction { increment, decrement }

class ProductCounter extends ConsumerStatefulWidget {
  final Product product;

  const ProductCounter({super.key, required this.product});

  @override
  ConsumerState createState() => _ProductCounterState();
}

class _ProductCounterState extends ConsumerState<ProductCounter> {
  @override
  Widget build(BuildContext context) {
    var cartItem = ref.watch(
      cartItemDetailStateProvider(widget.product.id.toString()),
    );

    if (cartItem.value == null) {
      return buildAddButton(context);
    }

    return SizedBox(
      height: 40,

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              ref
                  .read(cartItemStateProvider.notifier)
                  .updateCartItem(widget.product.id, CounterAction.decrement);
            },
            iconSize: 18,
            splashRadius: 20,
          ),
          Text(
            cartItem.value!.quantity.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              if (cartItem.value!.quantity >=
                  widget.product.availableQuantity) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Maximum quantity reached: ${widget.product.availableQuantity}",
                    ),
                  ),
                );
                return;
              }
              ref
                  .read(cartItemStateProvider.notifier)
                  .updateCartItem(widget.product.id, CounterAction.increment);
            },
            iconSize: 18,
            splashRadius: 20,
          ),
        ],
      ),
    );
  }

  Widget buildAddButton(BuildContext context) {
    return SizedBox(
      height: 40,
      child: OutlinedButton.icon(
        icon: const Icon(Icons.add, size: 18),
        label: const Text('Add'),
        onPressed:
            () => ref
                .read(cartItemStateProvider.notifier)
                .updateCartItem(widget.product.id, CounterAction.increment),
        style: OutlinedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          side: BorderSide(
            color:
                widget.product.availableQuantity == 0
                    ? Colors.grey.shade400
                    : Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
